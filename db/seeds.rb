# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

puts "Cleaning database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all
puts "Database cleaned"

url= "https://tmdb.lewagon.com/movie/top_rated"
json = URI.open(url).read
data = JSON.parse(json) #on le rend exploitable

movies = data["results"].first(34)
movies.each do |movie|
  title = movie["title"]
  overview = movie["overview"]
  rating = movie["vote_average"].round(1)
  poster_url = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"

  Movie.create!(title: title, overview: overview, rating: rating, poster_url: poster_url)
end

puts "#{Movie.count} movies created"
