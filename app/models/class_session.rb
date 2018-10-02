# == Schema Information
#
# Table name: class_sessions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_time :time
#  end_time   :time
#  days       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  location   :string(255)
#  class_code :string(255)
#

class ClassSession < ActiveRecord::Base
	has_many :notifications, as: :notifiable
	has_and_belongs_to_many :teachers, -> { uniq }, class_name: "User"
	has_and_belongs_to_many :subscribers, -> { uniq }, class_name: "User", join_table: "class_sessions_subscribers", association_foreign_key: "subscriber_id"

	def days
		unless @days
			@days = read_attribute :days
			if @days
				@days = JSON.parse(@days).with_indifferent_access.reverse_merge(ClassSession.default_days)
			else
				@days = ClassSession.default_days
			end
		end

		@days
	end

	def days=(value)
		@days = value.with_indifferent_access.slice(*ClassSession.days_of_week)
		@days.dup.each do |day_val|
			@days[day_val[0]] = !!(day_val[1] == true || day_val[1] =~ (/^(true|t|yes|y|1)$/i))
		end
		write_attribute :days, @days.to_json
	end

	validates_presence_of :name
	validates_presence_of :teachers

	def issue_notification(options)
		self.notifications.create options.merge(type: "Notification::#{options[:type].to_s.capitalize
		}")

		self.subscribers.each do |user|
			unless user.email.blank?
				begin
					NotificationMailer.notification(user.id, self.id).deliver
				rescue Exception => ex
					puts ex.message
					puts "Failed to send email notification to #{user.email}"
				end
			end

			unless user.sms_number.blank?
				begin
					NotificationTexter.notification(user.id, self.id).deliver
				rescue Exception => ex
					puts ex.message
					puts "Failed to send text notification to #{user.sms_number}"
				end
			end
		end
	end

	def self.days_of_week
		[:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
	end

	def self.default_days
		ClassSession.days_of_week.inject({}) { |hash, elem| hash.merge!(elem => false)}
	end
end
