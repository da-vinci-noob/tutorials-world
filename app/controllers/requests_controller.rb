class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      render json: { msg: 'Request Sent' }, status: 200
    else
      render json: { msg: 'An Error Occured' }, status: 500
    end
  end

  private

  def request_params
    params.require(:request).permit(:type_of_request, :body)
  end
end
