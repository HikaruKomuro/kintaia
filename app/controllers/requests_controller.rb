class RequestsController < ApplicationController
    
	def create

		@user = User.find_by(name: params[:superior])
		@request = @user.requests.new(request_params)
		@request.save
		
		@applied_user = User.find_by(id: params[:requests][:applicant])
		@worked_on = @applied_user.attendances.find_by(worked_on: params[:requests][:request_date])
		c = params[:requests][:category]
		@worked_on.update("status#{c}": 1)
		@worked_on.update(finish_time: @request.finish_time)
		@worked_on.update("note#{c}": @request.note)
		
    basic_end_mtime = @applied_user.designated_work_end_time.hour*60 + @applied_user.designated_work_end_time.min
    over_end_mtime = @worked_on.finish_time.hour*60 + @worked_on.finish_time.min
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
						if r.started_at.present?
							@applied_user.update(started_at: r.started_at)
							@applied_user.update(finished_at: r.finished_at)
						end
						r.destroy
					elsif @statuses[s] == "3"
						@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
						@applied_user.update("status#{c}": 3)
						@applied_user.update("note#{c}": nil)
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
			params.require(:requests).permit(:request_date, :applicant, :category, :note, :finish_time, :started_at, :finished_at)
		end
		
end
