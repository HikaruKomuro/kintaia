class RequestsController < ApplicationController
    
	def create
		@user = User.find(params[:id])
		@request = @user.requests.new(params_request)
	end
	
	def destroy
	end
	
	private
	
	def params_request
		params.require(:request).permit(:request_month, :applicant, :category)
	end
	
end
