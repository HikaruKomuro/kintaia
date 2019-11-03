module AttendancesHelper
  
  def worked_time(start1, finish1, change_date)
    if change_date == 1
      format("%.2f", (finish1 - start1)/3600)
    else
      format("%.2f", (finish.hour*60 + finish.min - start.hour*60 - start.min)/60.00)
    end
  end
  
  def start_time(start)
    start = start.round_to(15.minutes)
  end
  
  def finish_time(finish)
    finish = finish.round_to(15.minutes)
  end 
 
end
