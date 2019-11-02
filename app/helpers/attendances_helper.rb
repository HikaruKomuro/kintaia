module AttendancesHelper
  
  def worked_time(start, finish, change_date)
    if change_date == "1"
      format("%.2f", (((finish + 24*60*60 - start) / 60) / 60.0))
    else
      format("%.2f", (((finish - start) / 60) / 60.0))
    end
  end
  
  def start_time(start)
    start = start.round_to(15.minutes)
  end
  
  def finish_time(finish)
    finish = finish.round_to(15.minutes)
  end 
 
end
