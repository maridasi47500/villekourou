require "nokogiri"
require "open-uri"
Photocat.destroy_all
Album.destroy_all
Photo.destroy_all
@url1="https://www.ville-kourou.fr"
@doc=Nokogiri::HTML(URI.open("#{@url1}/phototheque"))

@list_link_categories=@doc.css("a[href*='/album-phototheque/']")
@list_link_categories.each do |y|
@photocat=Photocat.find_or_create_by(title: y.text.strip.squish, url: y.attributes['href'].value.split('/').without('').last)
linky=y.attributes['href'].value
if !linky.include?(@url1)
linky=@url1+linky

end

albums=Nokogiri::HTML(URI.open(linky)).css(".phototheque-icon a[href*='/phototheque/']")
albums.each do |a|
next if "phototheque" == a.attributes['href'].value.split('/').without('').last
album=Album.find_or_create_by(title: a.text.squish.strip, url: a.attributes['href'].value.split('/').without('').last)

begin
@photocat.albums << album
rescue => e
p e.inspect
end
linka=a.attributes['href'].value
if !linka.include?(@url1)
linka=@url1+linka

end
pagephoto=Nokogiri::HTML(URI.open(linka))

album.content=pagephoto.css('h1,div.text_exposed_show,p').select{|h|h.parent.attributes && h.parent.attributes['class'] && ["content","single"].all? {|xx|h.parent.attributes['class'].value.include?(xx)}}.map(&:inner_html).join('')
album.date=pagephoto.css('.content.single div p')[1].children.last.text
album.save
photos=pagephoto.css("[src*='/wp-content/uploads/']")
photos.each do |p|

begin
p p
p "====text : #{p.parent.parent.parent.css('figcaption')[0].try(:text)}====="
photo=album.photos.find_or_create_by(url:p.attributes['src'].value, title: p.parent.parent.parent.css('figcaption')[0].text.strip.squish)

rescue => e
p e.inspect
end
end

end

end