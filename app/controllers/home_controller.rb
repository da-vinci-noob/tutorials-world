class HomeController < ApplicationController
  def index
    @languages = Language.all.where(others: false)
    @others = Language.all.where(others: true)
  end
end
