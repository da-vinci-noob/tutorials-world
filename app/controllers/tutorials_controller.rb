class TutorialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tutorials = Tutorial.where(user: current_user).order(:title)
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.user = current_user
    if @tutorial.save
      render json: { msg: 'Tutorial will be approved soon' }, status: 200
    else
      render json: {
               msg: 'An Error Occured',
               errors: @tutorial.errors.full_messages
             },
             status: 500
    end
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    if current_user.admin? || @tutorial.user == current_user
      if @tutorial.update!(tutorial_params)
        render json: { msg: 'Tutorial Updated' }, status: 200
      else
        render json: { msg: 'An Error Occured' }, status: 500
      end
    else
      render json: { msg: 'User Not Authorized' }, status: 401
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])
    if current_user.admin? || @tutorial.user == current_user
      if @tutorial.destroy
        render json: { msg: 'Tutorial Deleted' }, status: 200
      else
        render json: { msg: 'An Error Occured' }, status: 500
      end
    else
      render json: { msg: 'User Not Authorized' }, status: 401
    end
  end

  def approval
    if current_user.admin?
      @tutorials =
        Tutorial
          .where(is_approved: false)
          .as_json(include: { language: { only: [:title] } })
    else
      flash[:alert] = 'User not authorized'
      redirect_to root_path
    end
  end

  def approve_tutorial
    if current_user.admin?
      @tutorial = Tutorial.find(params[:id])
      @tutorial.is_approved = true
      if @tutorial.save
        render json: { msg: 'Tutorial Approved' }, status: 200
      else
        render json: { msg: 'An Error Occured' }, status: 500
      end
    else
      render json: { msg: 'User Not Authorized' }, status: 401
    end
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :body, :language_id)
  end
end
