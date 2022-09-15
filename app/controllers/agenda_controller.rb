class AgendaController < ApplicationController
  def index
    @nextevents=Event.nextevents
    @pasteventskourou=Event.pasteventskourou
    session[:results]=@pasteventskourou
    @pasteventskourou=@pasteventskourou.take(5)
  end

  def show
    @event=Event.find_by_url(params[:title])
  end
end
