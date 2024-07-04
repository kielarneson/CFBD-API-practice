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

recruits_on_specific_cfb_team_from2019to2023 = (team_recruits_by_year("Georgia", 2020) | 
                                                team_recruits_by_year("Georgia", 2019) |
                                                team_recruits_by_year("Georgia", 2018) |
                                                team_recruits_by_year("Georgia", 2017) |
                                                team_recruits_by_year("Georgia", 2016))

def nfl_draft_class_by_year(year)
  uri = URI.parse("https://api.collegefootballdata.com/draft/picks?year=#{year}")
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

  draft_class = JSON.parse(response.body)
  return draft_class
end

nfl_draft_classes_from2020to2024 = (nfl_draft_class_by_year(2023) | 
                                    nfl_draft_class_by_year(2022) | 
                                    nfl_draft_class_by_year(2021) | 
                                    nfl_draft_class_by_year(2020) | 
                                    nfl_draft_class_by_year(2019))

# pp recruits_on_specific_cfb_team_from2019to2023
# pp nfl_draft_classes_from2020to2024
                                    
def player_information_for_nfl_draft_picks_from_specific_cfb_team_over_specific_timespan(players, draft_class)
  players_in_nfl = []
  index1 = 0
  index2 = 0

  while index1 < players.length
    while index2 < draft_class.length
      if players[index1]["athleteId"].to_i == draft_class[index2]["collegeAthleteId"] && players[index1]["committedTo"] == draft_class[index2]["collegeTeam"]

        players_in_nfl << {"name" => players[index1]["name"],
                           "position" => players[index1]["position"],
                           "committedTo" => players[index1]["committedTo"],
                           "year" => players[index1]["year"],
                           "highSchoolHeight" => players[index1]["height"],
                           "height" => draft_class[index2]["height"],
                           "highSchoolWeight" => players[index1]["weight"],
                           "weight" => draft_class[index2]["weight"],
                           "school" => players[index1]["school"],
                           "city" => players[index1]["city"],
                           "stateProvince" => players[index1]["stateProvince"],
                           "country" => players[index1]["country"],
                           "stars" => players[index1]["stars"],
                           "rating" => players[index1]["rating"],
                           "ranking" => players[index1]["ranking"],
                           "draftedBy" => draft_class[index2]["nflTeam"],
                           "draftYear" => draft_class[index2]["year"],
                           "overall" => draft_class[index2]["overall"],
                           "round" => draft_class[index2]["round"],
                           "pick" => draft_class[index2]["pick"],
                           "preDraftRanking" => draft_class[index2]["preDraftRanking"],
                           "preDraftPositionRanking" => draft_class[index2]["preDraftPositionRanking"],
                           "preDraftGrade" => draft_class[index2]["preDraftGrade"],
                           "collegeToProRankingChange" => players[index1]["ranking"] - draft_class[index2]["overall"]}
      end
      index2 += 1
    end
    index1 += 1
    index2 = 0
  end

  return players_in_nfl
end

pp player_information_for_nfl_draft_picks_from_specific_cfb_team_over_specific_timespan(recruits_on_specific_cfb_team_from2019to2023, nfl_draft_classes_from2020to2024)

