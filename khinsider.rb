require "rubygems"
require "watir"
require 'open-uri'

# URL지정
main_url = "http://downloads.khinsider.com/game-soundtracks/album/dance-dance-revolution-2nd-mix-original-soundtrack"

browser = Watir::Browser.new(main_url)
browser.goto()

mp3_target = []

# 각 songname의 링크를 찾아서 배열에 저장
browser.links.each do |l|
  if /\.mp3$/ =~ l.href and l.text != "Send to Phone" then
    mp3_target.push(l.href)
  end
end

#p mp3_target

mp3_target.each do |target|

  # songname링크 클릭
  browser.link(:url, target).click
  # 'Download to Computer'링크 취득
  tg_link = browser.link(:text, "Download to Computer")

  # 로컬에 보존할 파일명 취득
  filename = tg_link.href.split(/\//).last

  # 링크의 href에 있는 파일을 open해서 로컬에 write
  open(tg_link.href) do |source|
    open(filename, "w+b") do |o|
      o.print source.read
    end
  end

  # 끝나면 원위치로 돌아온다.
  browser.goto(main_url)

end
