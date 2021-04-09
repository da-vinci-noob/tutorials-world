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
      flash[:notice] =
        "Tutorial has been saved in #{Language.find(params[:tutorial][:language_id]).title}"
    else
      flash[:alert] = @tutorial.errors.full_messages.join('<br>').html_safe
    end
    redirect_to new_tutorial_path
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

  def tutorial_params
    params.require(:tutorial).permit(:title, :body, :language_id)
  end
end
