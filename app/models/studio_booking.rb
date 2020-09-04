class StudioBooking
  ENDPOINT = "https://www.noahstudio.jp/noahweb/Webs/search/1/0/1"

  # date=2020-08-30
  class << self
    def search(date: Time.zone.now)
      p "date2", date
      # TODO 日本時間に変更

      branchlist = "18%2C6%2C16%2C76%2C79%2C78%2C77"
      sdate = "2020-09-05+20%3A00%3A00"
      edate = "2020-09-05+22%3A00%3A00"
      roomsizelist = ""
      resp = Faraday.post(ENDPOINT, "all_branch_id=1&branchlist=#{branchlist}&car_flg=0&recorder_flg=0&sub_room_flg=0&piano_flg=0&sdate=#{sdate}&edate=#{edate}&roomsizelist=#{roomsizelist}")

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
