require "nokogiri"
require "open-uri"
@url1="https://www.ville-kourou.fr"
News.delete_all

def dlarticle(lienpage)
if !lienpage.include?(@url1)
lienpage=@url1+lienpage
end
event=News.new

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
@categories=info.css("a[href*='/category/']")
when "Date de début"
I18n.t('date.month_names').without(nil).each_with_index do |t,i|
content.gsub!(t,I18n.t('date.month_names',locale: "en").without(nil)[i])
end
event.begindate=content
when "Posté le"
I18n.t('date.month_names').without(nil).each_with_index do |t,i|
content.gsub!(t,I18n.t('date.month_names',locale: "en").without(nil)[i])
end
event.date=content


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
cat=Newscat.find_or_create_by(name: linkcat.text,url: linkcat.attributes['href'].value.gsub("https://www.ville-kourou.fr",'').gsub('agenda-type','').gsub('/',''))
begin 
event.newscats << cat
rescue => e
p e.inspect
end
end
end

@doc=Nokogiri::HTML(File.read("./mynews.html"))
@doc.css(".widget-head h2 a").each do |link|
dlarticle(link.attributes['href'].value)

end
@doc.css("a[href='/category/']").each do |link|
Nokogiri::HTML(URI.open("https://www.ville-kourou.fr"+link.attributes['href'].value)).css(".widget-head h2 a").each do |mylink|
dlarticle(mylink.attributes['href'].value)

end
end