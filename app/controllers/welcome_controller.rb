class WelcomeController < ApplicationController
  def index
    @eventsnews=News.eventsnews
@events=Event.mostrecent
  end

end
