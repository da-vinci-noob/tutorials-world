class LanguagesController < ApplicationController

  def create
    @language = Language.new(language_params)
    @language.save!
  end

  def show
  end

  private

  def language_params
    params.require(:language).permit(:title)
  end
end
