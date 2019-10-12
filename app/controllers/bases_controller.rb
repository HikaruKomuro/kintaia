class BasesController < ApplicationController
  
  def index
    @bases = Base.all
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点情報が追加されました"
      redirect_to bases_url
    else
      flash[:danger] = "拠点情報を追加できませんでした"
      
      redirect_to bases_url
    end
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報が変更されました"
    else
      flash[:danger] = "拠点情報を変更できませんでした"
    end
    redirect_to bases_url
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
