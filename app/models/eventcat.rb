class Eventcat < ApplicationRecord
has_many :eventcatshaveevents
has_many :events, through: :eventcatshaveevents

end