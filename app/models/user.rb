# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  sms_number             :string(255)
#  sms_carrier            :string(255)
#  roles                  :string(255)      is an Array
#  stripe_customer_token  :string(255)
#  title                  :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  plan                   :string(255)
#

class User < ActiveRecord::Base
	attr_accessor :stripe_card_token

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable

	before_save :update_stripe_plan

	has_and_belongs_to_many :subscriptions, -> { uniq }, class_name: "ClassSession", join_table: "class_sessions_subscribers", foreign_key: "subscriber_id"
	has_and_belongs_to_many :class_sessions

	validates_presence_of :customer, if: :plan

	def pro?
		!! self.plan
	end

	def student?
		self.roles && self.roles.include?("student")
	end

	def teacher?
		self.roles && self.roles.include?("teacher")
	end

	def sms_number=(number)
		write_attribute(:sms_number, number.gsub(/[^0-9]/, '').gsub(/^1/, ''))
	end

	def customer
		customer = Stripe::Customer.retrieve self.stripe_customer_token if self.stripe_customer_token

		if (defined? customer.deleted) && customer.deleted
			nil
		else
			customer
		end
	end

	def customer=(value)
		self.stripe_customer_token = value.id

		self.customer
	end

	def add_billing(options)
		if self.customer
			customer = self.customer
			customer.card = options[:stripe_card_token]
			customer.save
		else
			self.customer = Stripe::Customer.create email: self.email, card: options[:stripe_card_token]
		end
	end

	def confirm!
		(self.roles ||= []) << :teacher if School.valid_teacher self

		super
	end

private
	def update_stripe_plan
		if self.customer && self.plan_changed?
			if self.plan.blank?
				customer.subscription && customer.subscription.delete
			else
				customer = self.customer
				customer.plan = plan
				customer.save
			end
		end
	end
end
