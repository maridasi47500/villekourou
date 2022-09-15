class Videocat < ApplicationRecord
has_many :videoshavevideocats
has_many :videos, through: :videoshavevideocats
before_save do
self.title=self.title.squish.strip
end
end
