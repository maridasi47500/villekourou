class Video < ApplicationRecord
has_many :videoshavevideocats
has_many :videocats, through: :videoshavevideocats
has_many :categories, through: :videoshavevideocats,source: :videocat
before_save do
self.content=self.content.to_s.squish.strip
end
has_many :othervideos, foreign_key: "videoa_id" 
has_many :linkedvideos, through: :othervideos, source: :videob
attr_accessor :associees
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
