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

team_roster = team_roster("Alabama", 2021)

def team_recruits_by_year(team, year)
  uri = URI.parse("https://api.collegefootballdata.com/recruiting/players?year=#{year}&classification=HighSchool&team=#{team}")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"
  request["Authorization"] = "Bearer "

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  team_recruits = JSON.parse(response.body)
  return team_recruits
end

all_recruits_from2017_to2021 = (team_recruits_by_year("Alabama", 2021) |
                                team_recruits_by_year("Alabama", 2020) |
                                team_recruits_by_year("Alabama", 2019) |
                                team_recruits_by_year("Alabama", 2018) |
                                team_recruits_by_year("Alabama", 2017))

def adding_players_recruiting_info_to_team_roster(team_roster, all_recruits)
  index1 = 0
  index2 = 0

  while index1 < team_roster.length
    while index2 < all_recruits.length
      if team_roster[index1]["id"] == all_recruits[index2]["athleteId"]
        team_roster[index1]["recruiting_class"] = all_recruits[index2]["year"]
        team_roster[index1]["ranking"] = all_recruits[index2]["ranking"]
        team_roster[index1]["rating"] = all_recruits[index2]["rating"]
      end
      index2 += 1
    end
    index1 += 1
    index2 = 0
  end
  return team_roster
end

team_roster_with_recruiting_info = adding_players_recruiting_info_to_team_roster(team_roster, all_recruits_from2017_to2021)
