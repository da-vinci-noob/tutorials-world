class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path unless current_user.admin?
    @requests = Request.all.order(created_at: :desc)

    @requests_w_user = @requests.as_json(include: { user: { only: [:name] } })
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      render json: { msg: 'Request Sent' }, status: 200
    else
      render json: { msg: 'An Error Occured' }, status: 500
    end
  end

  def update
    if current_user.admin?
      @request = Request.find(params[:id])
      @request.update(is_completed: true)
      render json: { msg: 'Request Updated' }, status: 200
    else
      render json: { msg: 'An Error Occured' }, status: 500
    end
  end

  private

  def request_params
    params.require(:request).permit(:type_of_request, :body)
  end
end
