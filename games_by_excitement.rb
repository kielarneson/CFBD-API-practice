require "net/http"
require "json"
require "uri"

week = 1

uri = URI.parse("https://api.collegefootballdata.com/games?year=2021&week=#{week}&seasonType=regular")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"
request["Authorization"] = "Bearer "

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

week_games = JSON.parse(response.body)

# Data example
# {"id"=>401309606,
#   "season"=>2021,
#   "week"=>3,
#   "season_type"=>"regular",
#   "start_date"=>"2021-09-17T00:00:00.000Z",
#   "start_time_tbd"=>false,
#   "neutral_site"=>false,
#   "conference_game"=>false,
#   "attendance"=>nil,
#   "venue_id"=>3666,
#   "venue"=>"Cajun Field",
#   "home_id"=>309,
#   "home_team"=>"Louisiana",
#   "home_conference"=>"Sun Belt",
#   "home_points"=>49,
#   "home_line_scores"=>[7, 14, 7, 21],
#   "home_post_win_prob"=>"0.9974353768568665",
#   "away_id"=>195,
#   "away_team"=>"Ohio",
#   "away_conference"=>"Mid-American",
#   "away_points"=>14,
#   "away_line_scores"=>[0, 7, 7, 0],
#   "away_post_win_prob"=>"0.0025646231431335487",
#   "excitement_index"=>"3.4183850843",
#   "highlights"=>nil,
#   "notes"=>nil}

front_end = week_games.
  select { |game| game["excitement_index"].to_f > 8.0 }.
  map { |game| "#{game["away_team"]} vs #{game["home_team"]}" }

pp front_end
