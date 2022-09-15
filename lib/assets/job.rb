require "nokogiri"
require "open-uri"
@url1="https://www.ville-kourou.fr"
Job.delete_all
#telecharger les emplois
#ecrire la page job

def dlarticle(lienpage)
if !lienpage.include?(@url1)
lienpage=@url1+lienpage
end
event=Job.new

event.url=lienpage.split('/').without('').last
doc=Nokogiri::HTML(URI.open(lienpage))
event.title=doc.css('div.content.single .main-title')[0].text
event.image=doc.css('div.content.single div .m-post-image a img')[0].attributes['src'].value rescue nil

@categories=[]

content=""
subtitle=""


doc.css(%w(p ul h1 h2 h3).map{|s|"div.content.single #{s}"}.join(', ')).select{|y|y.parent.name=="div" && y.parent.attributes['class'] && y.parent.attributes['class'].value.include?('content') && (y.name == "h2" ? !y.attributes['class'].try(:value).to_s.include?('main-title') : true)}.each do |info|
content << " "
content << info.to_html

end
include ActionView::Helpers::TextHelper
event.content=content
event.subtitle=strip_tags(content).truncate(130,separator:",").truncate(130,separator:" ")
event.save

end

@doc=Nokogiri::HTML(File.read("./jobs.html"))

@doc.css(".widget-links ul li a").each do |link|
url11="https://www.ville-kourou.fr"
maconnexion=(url11+link.attributes['href'].value.gsub(url11,""))
dlarticle(maconnexion)
rescue  => e
p e.inspect
next
end