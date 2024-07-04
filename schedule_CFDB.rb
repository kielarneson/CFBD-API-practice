require "net/http"
require "json"
require "uri"

uri = URI.parse("https://api.collegefootballdata.com/calendar?year=2021")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"
request["Authorization"] = "Bearer 5ln/cNSd7OW/bNvLui5+WIC0ljQ4gb/1irOPdeodJQUbo02+zv/mlp/rYLTbwBka"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

team_schedule = JSON.parse(response.body)

pp team_schedule
