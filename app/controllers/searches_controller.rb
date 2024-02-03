class SearchesController < ApplicationController
  def index
    @searchs = Search.where(indentifier: request.remote_ip)
  end
  
  def create
    search_query = params[:search]

    Search.create(indentifier: request.remote_ip, query: search_query)
  end
end