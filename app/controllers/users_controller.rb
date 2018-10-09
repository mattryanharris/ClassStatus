class UsersController < ApplicationController
	def dashboard
		if current_user.roles && current_user.teacher?
			@class_sessions = current_user.class_sessions
			render :teacher_dashboard
		else
			@class_sessions = current_user.subscriptions
			render :student_dashboard
		end
	end

	def plans_update
		respond_to do |format|
			if plans_params.include?(:plan) && current_user.update(plan: plans_params[:plan])
				format.html { render action: 'plans_edit' }
				format.json { head :no_content }
			else
				format.html { render action: 'plans_edit', notice: "You've successfully change your plan to #{current_user.plan}" }
				format.json { render json: current_user.errors, status: :unprocessable_entity }
			end
		end
	end

	def billing_update
		if billing_params.include?(:stripe_card_token)
			current_user.add_billing billing_params

			if current_user.save
				redirect_to edit_user_registration_path, notice: "You've successfully signed up for a pro account"
			else
				render :edit
			end
		else
			render :edit
		end
	end

private
	# Never trust parameters from the scary internet, only allow the white list through.
	def billing_params
		params.require(:user).permit(:stripe_card_token, :plan)
	end

	def plans_params
		params.require(:user).permit(:plan)
	end
end
