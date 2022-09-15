class Videoshavevideocat < ApplicationRecord
belongs_to :video
belongs_to :videocat
validates_uniqueness_of :video_id, scope: :videocat_id
end