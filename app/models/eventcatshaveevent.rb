class Eventcatshaveevent < ApplicationRecord
belongs_to :eventcat
belongs_to :event
validates_uniqueness_of :event_id, scope: :eventcat_id

end