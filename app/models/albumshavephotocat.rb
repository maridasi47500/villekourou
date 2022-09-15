class Albumshavephotocat < ApplicationRecord
belongs_to :album
belongs_to :photocat
validates_uniqueness_of :album_id, scope: :photocat_id
end