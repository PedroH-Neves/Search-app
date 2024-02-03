class SearchesController < ApplicationController
  def index
    @searchs = Search.where(indentifier: request.remote_ip).order(search_count: :desc)
  end
  
  def create
    search_query = params[:search]
    existing_search = Search.find_by("query LIKE ?", "%#{search_query}%")

    if existing_search.present?
      existing_search.increment!(:search_count) if existing_search.query == search_query
      
    elsif included_words(search_query).any?
      included_words(search_query).each { |search| search.destroy }

      create_new_search(search_query)
    else
      create_new_search(search_query)
    end
  end
  
  def create_new_search(search)
    Search.create(indentifier: request.remote_ip, query: search, search_count: 1)
  end

  def included_words(words)
    Search.all.select {|search| words.include?(search.query)}
  end
end