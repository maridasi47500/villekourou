require "nokogiri"
require "open-uri"

Event.delete_all

def dlarticle(lienpage)
event=Event.new
event.url=lienpage.split('/').without('').last
doc=Nokogiri::HTML(URI.open(lienpage))
event.title=doc.css('div.content.single .main-title')[0].text

event.image=doc.css('div.content.single div .m-post-image a img')[0].attributes['src'].value rescue nil
event.imagelink=doc.css('div.content.single div .m-post-image a')[0].attributes['href'].value rescue nil
@categories=[]
doc.css('div.content.single div p').each do |info|
infos="\u24D8"
p infos.encode('utf-8')
myinfo=info.css('strong')[0].text.strip.squish
p myinfo
content=info.children[1].text.gsub(' : ','')

p info
p content
case myinfo
when "Catégorie"
@categories=info.css('a[href*=agenda-type]')
when "Date de début"
I18n.t('date.month_names').without(nil).each_with_index do |t,i|
content.gsub!(t,I18n.t('date.month_names',locale: "en").without(nil)[i])
end
event.begindate=content
when "Date de fin"
I18n.t('date.month_names').without(nil).each_with_index do |t,i|
content.gsub!(t,I18n.t('date.month_names',locale: "en").without(nil)[i])
end
event.enddate=content
when "Lieu"
p=Place.find_or_create_by(name: content.strip.squish)
event.place=p
when "Organisateur"
m=Manager.find_or_create_by(name: content.strip.squish)
event.manager=m


end
end
content=""
subtitle=""


doc.css(%w(p ul h1 h2 h3).map{|s|"div.content.single #{s}"}.join(', ')).select{|y|y.parent.name=="div" && y.parent.attributes['class'] && y.parent.attributes['class'].value.include?('content') && (y.name == "h2" ? !y.attributes['class'].try(:value).to_s.include?('main-title') : true)}.each do |info|
content << info.to_html

end
include ActionView::Helpers::TextHelper
event.content=content
event.subtitle=strip_tags(content).truncate(130,separator:",").truncate(130,separator:" ")
event.save
@categories.each do |linkcat|
cat=Eventcat.find_or_create_by(name: linkcat.text,url: linkcat.attributes['href'].value.gsub("https://www.ville-kourou.fr",'').gsub('agenda-type','').gsub('/',''))
begin 
event.eventcats << cat
rescue => e
p e.inspect
end
end
end

@doc=Nokogiri::HTML(File.read("./myagenda.html"))
@doc.css("a[href*='/agenda/']").each do |link|
dlarticle(link.attributes['href'].value)

end
