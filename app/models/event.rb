class Event < ApplicationRecord
has_many :eventcatshaveevents
has_many :eventcats, through: :eventcatshaveevents
has_many :categories, through: :eventcatshaveevents, source: :eventcat
belongs_to :place
belongs_to :manager
def self.nextevents
where("begindate >= ?",Date.today)

end
def self.pasteventskourou
where("begindate < ?",Date.today)
end
def self.mostrecent
order(:begindate => :desc).limit(10)
end
end