class RequestsController < ApplicationController
    
	def create
		@user = User.find_by(name: params[:request][:target])
		@request = @user.requests.new(request_month: params[:request_month], category: params[:category], applicant: params[:applicant])
		@request.save
		
		
		@user_applied = User.find_by(id: params[:applicant])
		@status = @user_applied.attendances.where(status: @first_day)
		@status == 2
	
		redirect_to user_path
	end
	
	def destroy
	end
	
	private
	
	def params_request
		params.require(:request).permit(:request_month, :applicant, :category)
	end
	
end
