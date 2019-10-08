module AttendancesHelper
  
  def worked_time(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  def start_time(start)
    start = start.round_to(15.minutes)
  end
  
  def finish_time(finish)
    finish = finish.round_to(15.minutes)
  end 
 
end
