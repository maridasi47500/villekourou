require "nokogiri"
require "open-uri"
Videocat.delete_all
Video.delete_all
@videos=[]
@url1="https://www.ville-kourou.fr"
@doc=Nokogiri::HTML(URI.open("#{@url1}/videos"))

@list_link_categories=@doc.css("a[href*='/video-type/']")
@list_link_categories.each do |y|
@videocat=Videocat.find_or_create_by(title: y.text.squish.strip, url: y.attributes['href'].value.split('/').without('').last)
link=y.attributes['href'].value
if !link.include?(@url1)
link=@url1+link

end
pagesvideos=Nokogiri::HTML(URI.open(link))

videos=pagesvideos.css("[href*='/videos/']")
videos.each do |a|

linka=a.attributes['href'].value
next if "videos" == linka.split('/').without('').last
video=Video.find_or_create_by(title: a.text.strip.squish, url: linka.split('/').without('').last)
if !linka.include?(@url1)
linka=@url1+linka

end
pagevideo=Nokogiri::HTML(URI.open(linka))
video.content=pagevideo.css('.article-content .article-body')[0].inner_html
@myel1=pagevideo
@myel=pagevideo.css('.content.single div p')
video.date=pagevideo.css('.content.single div p')[1].children.last.text
video.fbvideo=pagevideo.css('.article .article-image .fb-video')[0].attributes['data-href'].value

video.save

begin
@videocat.videos << video
rescue => e
p e.inspect
end
begin
video.associees=pagevideo.css('.content.single section .gallery figure figcaption a').map {|x|x.attributes['href'].value.split('/').without('').last}
@videos.push(video)
rescue => e
p e.inspect
end

end

end
@videos.each do |vid|
vid.associees.each do |link|
vid.linkedvideos << Video.where(url: link)
rescue => e
p e.inspect
end
end