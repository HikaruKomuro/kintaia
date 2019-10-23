class RequestsController < ApplicationController
    
	def create
		
		@user = User.find_by(name: params[:request][:superior])
		@request = @user.requests.new(request_date: params[:request_date], category: params[:category], applicant: params[:applicant], finish_time: params[:request]["finish_time(3i)"], note: params[:note], change_date: params[:change_date])
		@request.save
		@user_applied = User.find_by(id: params[:applicant])
		@status = @user_applied.attendances.find_by(worked_on: params[:request_date])
		if @request.category  == 1
			@status.update(status1: 1)
		elsif @request.category == 3
			@status.update(status3: 1)
		end
		redirect_to user_path
		
	end
	
	def destroy
		
		@statuses = params[:status]
		@user = User.find(params[:id])
		@requests = @user.requests.where(category: 1).order(:applicant)
		s = 0
		@requests.each do |r|
			if @statuses[s] == "2"
				@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
				@applied_user.update(status1: 2)
				r.destroy
			elsif @statuses[s] == "3"
				@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
				@applied_user.update(status1: 3)
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
