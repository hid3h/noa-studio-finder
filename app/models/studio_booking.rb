class StudioBooking
  ENDPOINT = "https://www.noahstudio.jp/noahweb/Webs/search/1/0/1"

  FORMAT = "%Y-%m-%d %H:%M:%S"

  # branchlist 秋葉原18, 駒沢6, 銀座16, 新宿76, 代々木79, 学芸大78, 都立大77
  # roomsize 6_10, 10_20
  class << self
    def search(date: Time.zone.now, branchlist: [18, 6, 16, 76, 79, 78, 77], roomsizelist: "")

      start_date = date.beginning_of_hour + 1.hour
      end_date = date.beginning_of_day + 1.day

      list = []
      ((end_date - start_date).to_i / 3600).times do |i|
        sdate = (start_date + i.hour).strftime(FORMAT)
        edate = (start_date + 1.hour + i.hour).strftime(FORMAT)
        p sdate, "~", edate, "取得開始"
        resp = Faraday.post(ENDPOINT, "all_branch_id=1&branchlist=#{branchlist.join(',')}&car_flg=0&recorder_flg=0&sub_room_flg=0&piano_flg=0&sdate=#{sdate}&edate=#{edate}&roomsizelist=#{roomsizelist}")
        list.push(JSON.parse(resp.body))
      end

      return make_response_json(list)
    end

    def make_response_json(json_list)
      hash = {}
      json_list.each do |json|
        json["studiolist"].each do |studio|
          studio_id = studio["m_stu"]["id"]

          if hash.has_key?(studio_id)
            hash[studio_id][:aki] << studio["0"].merge({price: studio["m_price0"]["price0"]})
          else
            hash[studio_id] = studio["m_stu"].merge({
              id: studio_id,
              web_branch_name: studio["m_bra"]["web_branch_name"],
              branch_name: studio["m_bra"]["branch_name"],
              aki: [studio["0"].merge({price: studio["m_price0"]["price0"]})]
            })
          end
        end
      end
      return hash
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
