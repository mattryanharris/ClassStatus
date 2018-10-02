class ClassSessionsController < ApplicationController
	load_and_authorize_resource

	# GET /class_sessions
	# GET /class_sessions.json
	def index
		@class_sessions = ClassSession.all
	end

	# GET /class_sessions/1
	# GET /class_sessions/1.json
	def show
	end

	# GET /class_sessions/new
	def new
		@class_session = ClassSession.new
	end

	# GET /class_sessions/1/edit
	def edit
	end

	# POST /class_sessions
	# POST /class_sessions.json
	def create
		@class_session = ClassSession.new(class_session_params.merge({teachers: [current_user]}))

		respond_to do |format|
			if @class_session.save
				format.html { redirect_to @class_session, notice: 'Class session was successfully created.' }
				format.json { render action: 'show', status: :created, location: @class_session }
			else
				format.html { render action: 'new' }
				format.json { render json: @class_session.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /class_sessions/1
	# PATCH/PUT /class_sessions/1.json
	def update
		respond_to do |format|
			if @class_session.update(class_session_params)
				format.html { redirect_to @class_session, notice: 'Class session was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @class_session.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /class_sessions/1
	# DELETE /class_sessions/1.json
	def destroy
		@class_session.destroy
		respond_to do |format|
			format.html { redirect_to class_sessions_url }
			format.json { head :no_content }
		end
	end

	# GET /class_sessions/1/cancel
	# GET /class_sessions/1/cancel.json
	# POST /class_sessions/1/cancel
	# POST /class_sessions/1/cancel.json
	def cancel
		@notification = Notification::Cancel.new
		@notification.notifiable = @class_session

		unless params[:notification_cancel].blank?
			respond_to do |format|
				@notification.assign_attributes class_session_notification_params
				if @notification.save
					@notification.issue_to @class_session.subscribers

					format.html { redirect_to @class_session, notice: 'Class session cancellation was successfully posted.' }
					format.json { render action: 'show', status: :created, location: @class_session }
				else
					throw
					format.html { render :cancel, error: 'Class session cancellation failed.' }
					format.json { render json: notification.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	def subscribe
		if current_user.pro? || current_user.subscriptions.count < 1
			respond_to do |format|
				@class_session.subscribers << current_user

				format.html { redirect_to @class_session, notice: 'You successfully subscribed to the Class Session' }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to @class_session, error: "You cannot subscribe to more than one class without #{view_context.link_to "premium", plans_path}" }
				format.json { render json: {class_session: "You cannot subscribe to more than one class without premium"}, status: :unprocessable_entity }
			end
		end
	end

	def unsubscribe
		respond_to do |format|
			@class_session.subscribers.delete [current_user]

			format.html { redirect_to @class_session, notice: 'You successfully unsubscribed from the Class Session' }
			format.json { render action: 'show', status: :created, location: @class_session }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_class_session
		@class_session = ClassSession.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def self.allowed_params
		[:name, :start_time, :end_time, :class_code, :location, days: ClassSession.days_of_week]
	end
	def class_session_params
		params.require(:class_session).permit ClassSessionsController.allowed_params
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def class_session_notification_params
		params.require(:notification_cancel).permit(:date)
	end

	permit_params allowed_params
end
