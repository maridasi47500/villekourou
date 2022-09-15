class News < ApplicationRecord
has_many :newscatshavenews
has_many :newscats, through: :newscatshavenews
has_many :categories, through: :newscatshavenews, source: :newscat
def self.eventsnews
Event.order(:begindate => :desc).limit(2).to_a+News.order(:date => :desc).limit(2).to_a
end
def self.search(s)
x="%#{s.gsub(' ','%').downcase}%"
k=Event.where("lower(title) like ? or lower(content) like ?",x,x)+News.where("lower(title) like ? or lower(content) like ?",x,x)
k.sort_by{|h|h.date || Date.today}.reverse
end
end