class ApplicationController < ActionController::Base
before_action :setmyvar

def setmyvar
@cats=Eventcat.all.order(:name => :asc)
@emplois=Job.all
end

end

