class Photocat < ApplicationRecord
has_many :albumshavephotocats
has_many :albums, :through => :albumshavephotocats
before_save do
self.title=self.title.squish.strip
end
end
