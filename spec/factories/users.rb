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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user do
		transient do
			pro false
		end

		first_name { Faker::Name.first_name }
		last_name  { Faker::Name.last_name  }
		email      { Faker::Internet.email  }
		password     "foobar13"
		sms_number  { "9515555555" }
		sms_carrier  { %w[alltel att boost nextel sprint tmobile uscellular verizon virgin].sample }
		confirmed_at { Time.now }

		factory :student do
			roles { (pro ? ["pro"] : []) }
		end

		factory :teacher do
			roles ["teacher"]
		end
	end
end
