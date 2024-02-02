class MainController < ApplicationController
  def index
    @searchs = Main.search(params[:search])
  end
end