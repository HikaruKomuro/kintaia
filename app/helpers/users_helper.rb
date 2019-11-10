module UsersHelper
  
  def format_basic_info(time)
    format("%.2f",(time.hour*60 + time.min) / 60.00)
  end
  
  def a_user(id, date)
    User.find(id).attendances.find_by(worked_on: date)
  end
  
  def superior_user?
    @user.superior > 1
  end
  
end
