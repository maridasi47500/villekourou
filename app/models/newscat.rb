class Newscat < ApplicationRecord
has_many :newscatshavenews
has_many :news, through: :newscatshavenews
end