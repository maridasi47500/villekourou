class Newscatshavenews < ApplicationRecord
belongs_to :news
belongs_to :newscat
validates_uniqueness_of :news_id, scope: :newscat_id
end