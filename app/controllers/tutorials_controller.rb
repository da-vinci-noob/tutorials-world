class TutorialsController < ApplicationController
  before_action :authenticate_user!, only: %i[create new]

  def new
  
  end

  def create
  
  end
end
