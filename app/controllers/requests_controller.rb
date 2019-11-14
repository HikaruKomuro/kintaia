class RequestsController < ApplicationController
    
	def create
		if params[:request][:category] == "2"
			@superior = params[:superior]
			@superior.each do |key, value|
				if value.present? || params[:note][key].present? || params[:started_at][key]["(4i)"].present? || params[:started_at][key]["(5i)"].present? || params[:finished_at][key]["(4i)"].present? || params[:finished_at][key]["(5i)"].present?
					if value.present? && params[:note][key].present? && params[:started_at][key]["(4i)"].present? && params[:started_at][key]["(5i)"].present? && params[:finished_at][key]["(4i)"].present? && params[:finished_at][key]["(5i)"].present?
		        @user = User.find_by(name: value)
		        @applied_user = User.find(params[:request][:applicant]).attendances.find_by(worked_on: params[:request_date][key].to_time.localtime)
						@request = @user.requests.new(request_params)
						@request.change_date = params[:change_date][key]
						@request.request_date = params[:request_date][key].to_time.localtime
						@request.note = params[:note][key]
						@request.started_at = Time.new( @request.request_date.year.to_s,
																					  @request.request_date.month.to_s,
																					  @request.request_date.day.to_s,
																					  params[:started_at][key]["(4i)"].to_i,
																					  params[:started_at][key]["(5i)"].to_i)
					  @request.finished_at = Time.new(@request.request_date.year,
																					  @request.request_date.month,
																					  @request.request_date.day,
																					  params[:finished_at][key]["(4i)"].to_i,
																					  params[:finished_at][key]["(5i)"].to_i)
						@request.save
        		@applied_user.update(status2: 1, note2: @request.note, superior2: params[:superior][key])
        		flash[:success] = "勤怠の変更を申請しました。"
        	else	
						flash[:danger] = "入力項目の一部に不足がありました。申請中になっていない日を確認して、再度入力してください。"
					end
				end
			end
		
		elsif params[:request][:category] == "1"
			@user = User.find_by(name: params[:superior])
			@request = @user.requests.new(request_params)
			@request.save
			@applied_user = User.find_by(id: params[:request][:applicant])
			@worked_on = @applied_user.attendances.find_by(worked_on: params[:request][:request_date].to_date.beginning_of_month)
			@worked_on.update(status1: 1, superior1: params[:superior])
			flash[:success] = "一ヶ月分の勤怠を申請しました。"
			
				
		elsif params[:request][:category] == "3"
			if params[:superior].present? && params[:request][:note].present?
				@applied_user = User.find_by(id: params[:request][:applicant])
				@user = User.find_by(name: params[:superior])
				basic_end_mtime = @applied_user.designated_work_end_time.hour*60 + @applied_user.designated_work_end_time.min
				if params[:change_date] == "1"
					over_end_mtime = 24*60 + params[:request]["finish_time(4i)"].to_i*60 + params[:request]["finish_time(5i)"].to_i
		  	else
		    	over_end_mtime = params[:request]["finish_time(4i)"].to_i*60 + params[:request]["finish_time(5i)"].to_i
		    end
		    if (over_time = over_end_mtime - basic_end_mtime) > 0
					@request = @user.requests.new(request_params)
					@request.save
					@worked_on = @applied_user.attendances.find_by(worked_on: params[:request][:request_date])
					@worked_on.update(status3: 1, superior3: params[:superior])
					@worked_on.update(finish_time: @request.finish_time, overtime: over_time/60.00, note3: @request.note)
					flash[:success] = "#{params[:request][:request_date].to_date.strftime("%-m月%-d日")}　の残業を申請しました。"
				else
					flash[:danger] = "指定勤務終了時間より遅い時間を入力してください。"
				end
			else
				flash[:danger] = "必要項目を全て入力してください。"
			end
		end
		redirect_to user_path
	end
	
	
	
	
	
	def destroy
		@statuses = params[:status]
		@user = User.find(params[:id])
		c = params[:category]
		@requests = @user.requests.where(category: "#{c}").order(:applicant)
		s = 0
		m = 0
		pre_applicant = @requests.first.applicant
		@requests.each do |r|
			m = 0 if pre_applicant != r.applicant
			if params["check_box#{r.applicant}"].present?
				if params["check_box#{r.applicant}"]["#{m}"] == "1"
					@applied_user = User.find(r.applicant).attendances.find_by(worked_on: r.request_date)
					if @statuses[s] == "2"
						@applied_user.update("status#{c}": 2)
						if c == "2"
							if r.change_date == "1"
								@applied_user.update(note2: r.note,
																		superior: @user.id,
																		approval_date: Date.today,
																		change_date: r.change_date,
																		started_at: (r.started_at - 9*60*60),
																		finished_at: (r.finished_at + (24 - 9)*60*60))
							else
								@applied_user.update(note2: r.note,
																		superior: @user.id,
																		approval_date: Date.today,
																		change_date: r.change_date,
																		started_at: (r.started_at - 9*60*60),
																		finished_at: (r.finished_at - 9*60*60))
							end
							@applied_user.update(first_started_at: r.started_at, first_finished_at: r.finished_at) if @applied_user.first_started_at.blank?
							@date.save! if @date = User.find(r.applicant).logs.new(date: r.request_date)
						end
						r.destroy
					end
					
					if @statuses[s] == "3"
						@applied_user.update("status#{c}": 3, change_date: nil)
						if c != "1"
							@applied_user.update("note#{c}": nil)
							if c == "3"
								@applied_user.update(finish_time: nil, overtime: nil)
							end
						end
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
			params.require(:request).permit(:request_date, :applicant, :category, :note, :finish_time, :started_at, :finished_at)
		end
		
end
