class Photo < ApplicationRecord
belongs_to :album
def urla
url.gsub('-850x478','')
end

end
