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
pp team_schedule
