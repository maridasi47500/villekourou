class AgendaController < ApplicationController
  def index
    @nextevents=Event.nextevents
    @pasteventskourou=Event.pasteventskourou
  end

  def show
    @event=Event.find_by_url(params[:title])
  end
end
