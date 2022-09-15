class Album < ApplicationRecord
has_many :photos
has_many :albumshavephotocats
has_many :photocats, :through => :albumshavephotocats
has_many :categories, :through => :albumshavephotocats,source: :photocat
before_save do
self.content=self.content.to_s.squish.strip
end
def date=(content)
I18n.t('date.month_names').without(nil).each_with_index do |t,i|
content.gsub!(t,I18n.t('date.month_names',locale: "en").without(nil)[i])
end
write_attribute(:date,content.to_date)
end
def date
read_attribute(:date)

end
end
