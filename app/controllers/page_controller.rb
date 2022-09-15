class PageController < ApplicationController
protect_from_forgery except: [:ajax]
    def ajax
    @results=session[:results][0..(params[:offset].to_i+4)] rescue []
    render layout: false
    end
  def site
    @page=Page.find_by_url(request.path)
  end
def job
    @job=Page.find_by_url(params[:title])

end
    def search
    @results=News.search(params[:s])
    session[:results]=@results
    @results=@results.take(5)
    end
end
