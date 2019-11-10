class BasesController < ApplicationController
  
  before_action :admin_user, only: [:index, :create, :update, :destroy]
  
  def index
    @bases = Base.all.order(:id)
    @base = Base.new
    if params[:id].present?
      @base = Base.find(params[id])
    end
  end
  
  def create
    @base = Base.new
    @bases = Base.all
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報が追加されました"
      redirect_to bases_url
    else
      flash[:danger] = "拠点情報を追加できませんでした"
      render :index
    end
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update(base_params)
      flash[:success] = "拠点情報が変更されました"
      redirect_to bases_url
    else
      @bases = Base.all
      flash[:danger] = "拠点情報を変更できませんでした"
      render :index
    end
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "#{@base.base_name}の拠点を削除しました。"
    redirect_to bases_url
  end
private
  
  def base_params
    params.require(:base).permit(:base_number, :base_name, :work_type)
  end

end
