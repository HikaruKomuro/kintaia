module UsersHelper
  def format_basic_info(time)
    format("%.2f",((time.hour*60)+time.min) / 60.0)
  end
  
  def superior_user?
    @user.superior > 1
  end
    
end
