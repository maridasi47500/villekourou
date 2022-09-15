class NewsController < ApplicationController
  def index
    @news=News.all
  end
  def show
    @news=News.find_by_url(params[:title])
  end

  def showcategory
@category=Newscat.find_by_url(params[:title])
@news=@category.news
  end
end
