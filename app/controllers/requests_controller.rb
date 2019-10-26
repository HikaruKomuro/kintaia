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
		@requests = @user.requests.where(category: 1).order(:applicant)
		s = 0
		m = 0
		pre_applicant = @requests.first.applicant
		
		@requests.each do |r|
			if pre_applicant != r.applicant
				m = 0
			end
			if params["check_box#{r.applicant}"].present?
				if params["check_box#{r.applicant}"]["#{m}"] == "1"
					if @statuses[s] == "2"
						@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
						@applied_user.update(status1: 2)
						r.destroy
					elsif @statuses[s] == "3"
						@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
						@applied_user.update(status1: 3)
						r.destroy
					end
				end
			end
			s += 1
			m += 1
			pre_applicant = r.applicant
		end
		redirect_to user_path
	end
	
	private
	
		def params_request
			params.require(:request).permit(:request_month, :applicant, :category)
		end
		
end
