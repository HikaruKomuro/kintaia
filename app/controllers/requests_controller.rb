class RequestsController < ApplicationController
    
	def create
		
		@user = User.find_by(name: params[:superior])
		@request = @user.requests.new(request_params)
		@request.save
		@user_applied = User.find_by(id: params[:requests][:applicant])
		@worked_on = @user_applied.attendances.find_by(worked_on: params[:requests][:request_date])
		s = params[:requests][:category]
		@worked_on.update("status#{s}": 1)
    
    basic_end_mtime = @user_applied.designated_work_end_time.hour*60 + @user_applied.designated_work_end_time.min
    over_end_mtime = @request.finish_time.hour*60 + @request.finish_time.min
    @worked_on.update(overtime: (over_end_mtime - basic_end_mtime)/(60.00).floor(2))

		redirect_to user_path
	end
	
	
	
	def destroy
		@statuses = params[:status]
		@user = User.find(params[:id])
		c = params[:category]
		@requests = @user.requests.where(category: c).order(:applicant)
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
						@applied_user.update("status#{c}": 2)
						r.destroy
					elsif @statuses[s] == "3"
						@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
						@applied_user.update("status#{c}": 3)
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
	
		def request_params
			params.require(:requests).permit(:request_date, :applicant, :category, :note, :finish_time)
		end
		
end
