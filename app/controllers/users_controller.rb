class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show



  def index
    @users = User.paginate(page: params[:page], per_page: 5).search(params[:search])
  end

  def import
    if User.import(params[:file])
      flash[:success] = "CSVファイルをインポートしました"
    else
      flash[:danger] = "CSVファイルをインポートできませんでした"
    end
    redirect_to users_url
  end

  def index_working
    @users = []
    User.all.each do |user|
      if user.attendances.any?{|a| ( Date.today && !a.started_at.blank? && a.finished_at.blank?)}
        @users.push(user)
      end
    end
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @attendance1 = @user.attendances.find_by(worked_on: @first_day)
    @users = User.where(superior: "2")
    @requests1 = @user.requests.where(category: 1).order(:applicant)
    @requests2 = @user.requests.where(category: 2).order(:applicant)
    @requests3 = @user.requests.where(category: 3).order(:applicant)
    @applied_users1 = @requests1.pluck(:applicant).uniq
    @applied_users2 = @requests2.pluck(:applicant).uniq
    @applied_users3 = @requests3.pluck(:applicant).uniq
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] ="#{@user.name}の基本情報を更新しました"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def search
    @users = User.search(params[:search])
  end
  
  def create_request
    
		@superior = params[:superior]
		@superior.each do |key, value|
			if value.present? && params[:note][key].present?
				if params[:started_at][key]["(4i)"].present? && params[:started_at][key]["(5i)"].present?
					if params[:finished_at][key]["(4i)"].present? && params[:finished_at][key]["(5i)"].present?
		        @user = User.find_by(name: value)
						@request = @user.requests.new(request_params)
						@request.request_date = params[:request_date][key]
						
						@request.note = params[:note][key]
						@request.started_at = Time.local(
						  @request.request_date.year.to_s,
						  @request.request_date.month.to_s,
						  @request.request_date.day.to_s,
						  params[:started_at][key]["(4i)"].to_i,
						  params[:started_at][key]["(5i)"].to_i)
						  
						  if params[:change_date][key] == "1"
						    @request.finished_at = Time.local(
						  @request.request_date.year,
						  @request.request_date.month,
						  @request.request_date.day,
						  params[:finished_at][key]["(4i)"].to_i,
						  params[:finished_at][key]["(5i)"].to_i)
						  
						  else
						@request.finished_at = Time.local(
						  @request.request_date.year,
						  @request.request_date.month,
						  @request.request_date.day,
						  params[:finished_at][key]["(4i)"].to_i,
						  params[:finished_at][key]["(5i)"].to_i)
						end
						debugger
						@request.save
						@applied_user = User.find(params[:applicant])
				
        		@worked_on = @applied_user.attendances.find_by(worked_on: params[:request_date][key])
        		c = params[:category]
        		@worked_on.update("status#{c}": 1)
        		@worked_on.update("note#{c}": @request.note)
					end
				end
			end
		end
		redirect_to user_path
  end
  
 
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def request_params
			params.permit(:request_date, :applicant, :category, :note, :finish_time)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :work_time, :basic_time)
    end

    def logged_in_user
      unless logged_in?
         store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
    # 管理者かどうか確認
    def admin_user
     redirect_to(root_url) unless current_user.admin?
    end
end