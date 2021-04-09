class LanguagesController < ApplicationController
  before_action :set_language, only: [:show]

  def create
    @language = Language.new(language_params)
    @language.save!
  end

  def show
    @language_w_tutorials =
      @language.as_json(
        include: {
          tutorials: {
            include: {
              user: {
                only: [:name]
              }
            }
          }
        }
      )

    @language_w_tutorials['tutorials'].reject! do |tutorial|
      tutorial['is_approved'] == false
    end
  end

  private

  def language_params
    params.require(:language).permit(:title)
  end

  def set_language
    @language =
      Language
        .eager_load(:tutorials)
        .order('tutorials.created_at DESC')
        .find(params[:id])
  end
end
