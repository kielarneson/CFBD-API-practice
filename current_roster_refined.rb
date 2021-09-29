require "net/http"
require "json"
require "uri"

def team_roster(team, year)
  uri = URI.parse("https://api.collegefootballdata.com/roster?team=#{team}&year=#{year}")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"
  request["Authorization"] = "Bearer "

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  team_roster = JSON.parse(response.body)
  return team_roster
end
