require "rubygems"
require "watir"
require "watir-webdriver"
require 'open-uri'

main_url = "http://downloads.khinsider.com/game-soundtracks/album/outrun"

browser = Watir::Browser.new :firefox
browser.goto(main_url)

mp3_target = []

browser.links.each do |l|
  if /\.mp3$/ =~ l.href and l.text == "Download" then
    mp3_target.push(l.href)
  end
end

mp3_target.each do |target|

  browser.link(:href, target).click
  tg_link = browser.link(:text, "Click here to download")

  filename = tg_link.href.split(/\//).last

  open(tg_link.href) do |source|
    open(filename, "w+b") do |o|
      o.print source.read
    end
  end

  browser.goto(main_url)

end

browser.close
