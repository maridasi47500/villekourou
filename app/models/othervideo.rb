class Othervideo < ApplicationRecord
belongs_to :videoa, class_name: "Video"
belongs_to :videob, class_name: "Video"
validates_uniqueness_of :videoa_id,scope: :videob_id 
end