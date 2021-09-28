require "net/http"
require "json"
require "uri"

uri = URI.parse("https://api.collegefootballdata.com/games?year=2021&seasonType=regular&team=Alabama")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"
request["Authorization"] = "Bearer "

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

team_schedule = JSON.parse(response.body)

# Data example
# {"id"=>401281942,
#   "season"=>2021,
#   "week"=>1,
#   "season_type"=>"regular",
#   "start_date"=>"2021-09-04T19:30:00.000Z",
#   "start_time_tbd"=>false,
#   "neutral_site"=>true,
#   "conference_game"=>false,
#   "attendance"=>nil,
#   "venue_id"=>5348,
#   "venue"=>"Mercedes-Benz Stadium",
#   "home_id"=>2390,
#   "home_team"=>"Miami",
#   "home_conference"=>"ACC",
#   "home_points"=>13,
#   "home_line_scores"=>[0, 3, 10, 0],
#   "home_post_win_prob"=>"0.01176962249522609",
#   "away_id"=>333,
#   "away_team"=>"Alabama",
#   "away_conference"=>"SEC",
#   "away_points"=>44,
#   "away_line_scores"=>[10, 17, 14, 3],
#   "away_post_win_prob"=>"0.9882303775047739",
#   "excitement_index"=>"0.7900699466",
#   "highlights"=>nil,
#   "notes"=>nil},
# }

front_end = team_schedule.map { |game| "Week #{game["week"]}: #{game["away_team"]} at #{game["home_team"]}, Final score: #{game["away_points"]} - #{game["home_points"]}" }

pp front_end
