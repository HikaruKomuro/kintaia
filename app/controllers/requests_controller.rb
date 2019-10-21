class RequestsController < ApplicationController
    
	def create
		@user = User.find_by(name: params[:request][:target])
		@request = @user.requests.new(request_month: params[:request_month], category: params[:category], applicant: params[:applicant])
		@request.save
		@user_applied = User.find_by(id: params[:applicant])
		@status = @user_applied.attendances.find_by(worked_on: params[:request_month])
		@status.update(status: 1)
		redirect_to user_path
	end
	
	def destroy
		@statuses = params[:status]
		@user = User.find(params[:id])
		@requests = @user.requests.where(category: 1)
		s = 0
		@requests.each do |r|
			if @statuses[s] == "2"
				@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_month)
				@applied_user.update(status: 2)
				r.destroy
			elsif @statuses[s] == "3"
				@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_month)
				@applied_user.update(status: 3)
				r.destroy
			end
			s += 1
		end
		redirect_to user_path
	end
	
	private
	
	def params_request
		params.require(:request).permit(:request_month, :applicant, :category)
	end
	
end
