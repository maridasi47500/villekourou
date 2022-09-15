Rails.application.routes.draw do
    get "", to: redirect{|p,req| "/recherche/#{req.params[:s]}" },constraints: lambda {|req| req.params[:s].to_s.length > 0  }

  root to: 'welcome#index'
    post "/wp-admin/admin-ajax.php",to: "page#ajax"
    get "recherche/:s", to: "page#search"
    #mediatheque
  get "phototheque",to: 'mediatheque#photo',as: :albums
  get "phototheque/:title",to: 'mediatheque#album',as: :album
  get "videos",to: 'mediatheque#video',as: :videos
  get "videos/:title",to: 'mediatheque#voirvideo',as: :video
  get "album-phototheque/:title",to: 'mediatheque#photocat',as: :photocat
  get "video-type/:title",to: 'mediatheque#videocat',as: :videocat
    #
  get 'actualites', to: 'news#index'
  get ':title', to: 'page#job', constraints: lambda {|req| Job.find_by_url(req.params[:title])  },as: :job
  get ':title', to: 'page#site', constraints: lambda {|req| Page.find_by_url(req.path)  }

  get 'agenda', to: 'agenda#index'
  get 'agenda/:title', to: 'agenda#show', constraints: lambda {|req| Event.find_by_url(req.params[:title])}, as: :event 
  get 'agenda-type/:title', to: 'agenda#showcategory', constraints: lambda {|req|Eventcat.find_by_url(req.params[:title])},as: :agendatype
  
  get 'category/:title', to: 'news#showcategory', constraints: lambda {|req|Newscat.find_by_url(req.params[:title])},as: :newscat
  get ':title', to: 'news#showcategory', constraints: lambda {|req|Newscat.find_by_url(req.params[:title])}
  get ':title', to: 'news#show', constraints: lambda {|req|News.find_by_url(req.params[:title])}, as: :news
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
