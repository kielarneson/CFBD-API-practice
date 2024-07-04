require "net/http"
require "json"
require "uri"

def team_recruits_by_year(team, year)
  uri = URI.parse("https://api.collegefootballdata.com/recruiting/players?year=#{year}&classification=HighSchool&team=#{team}")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"
  request["Authorization"] = 
  "Bearer 5ln/cNSd7OW/bNvLui5+WIC0ljQ4gb/1irOPdeodJQUbo02+zv/mlp/rYLTbwBka"

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  team_recruits = JSON.parse(response.body)
  return team_recruits
end

recruits_that_may_be_on_current_team = (team_recruits_by_year("Alabama", 2023) | 
                                        team_recruits_by_year("Alabama", 2022) |
                                        team_recruits_by_year("Alabama", 2021))

pp recruits_that_may_be_on_current_team

# comment