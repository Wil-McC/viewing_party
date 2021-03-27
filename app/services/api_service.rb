require 'faraday'
require 'json'

class ApiService

  @@conn = Faraday.new(
    url: "https://api.themoviedb.org",
    params: {'api_key': ENV['MDB_KEY']}
  )
end
