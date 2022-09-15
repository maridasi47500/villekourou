class MediathequeController < ApplicationController
    before_action :set_cats
  def photo
    @albums=Album.all
  end
    def album
        @album=Album.find_by_url(params[:title])
    end
    def voirvideo
        @video=Video.find_by_url(params[:title])
    end
  def video
    @videos=Video.all
  end

  def photocat
    @cat=Photocat.find_by_url(params[:title])
  end

  def videocat
    @cat=Videocat.find_by_url(params[:title])

  end
    private
    def set_cats
        @videocats=Videocat.all
        @photocats=Photocat.all
    end
end
