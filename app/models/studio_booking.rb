class StudioBooking
  ENDPOINT = "https://www.noahstudio.jp/noahweb/Webs/search/1/0/1"

  # date=2020-08-30
  class << self
    def search(date: Time.zone.now, branchlist: [18, 6, 16, 76, 79, 78, 77])
      p "date2", date.class
      # TODO 日本時間に変更
      # 秋葉原18, 駒沢6, 銀座16, 新宿76, 代々木79, 学芸大78, 都立大77

      sdate = "2020-09-05+20%3A00%3A00"
      edate = "2020-09-05+22%3A00%3A00"
      roomsizelist = ""
      # 6_10, 10_20
      resp = Faraday.post(ENDPOINT, "all_branch_id=1&branchlist=#{branchlist.join(',')}&car_flg=0&recorder_flg=0&sub_room_flg=0&piano_flg=0&sdate=#{sdate}&edate=#{edate}&roomsizelist=#{roomsizelist}")

      body = JSON.parse resp.body
      p "body_json", body
    end
  end
end

# await fetch("https://www.noahstudio.jp/noahweb/Webs/search/1/0/1", {
#   "credentials": "include",
#   "headers": {
#       "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0) Gecko/20100101 Firefox/78.0",
#       "Accept": "application/json, text/javascript, */*; q=0.01",
#       "Accept-Language": "ja,en-US;q=0.7,en;q=0.3",
#       "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
#       "X-Requested-With": "XMLHttpRequest"
#   },
#   "referrer": "https://www.noahstudio.jp/noahweb/webs/searchresults",
#   "body": "all_branch_id=0&branchlist=78&car_flg=0&recorder_flg=0&sub_room_flg=0&piano_flg=0&sdate=2020-08-30+13%3A00%3A00&edate=2020-08-30+15%3A00%3A00&roomsizelist=6_10%2C10_20",
#   "method": "POST",
#   "mode": "cors"
# });
