require 'securerandom'

require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    data = JSON.parse(user_serialized)
    choices = params[:word].upcase.split(//) - params[:letters].split(//)
    if choices.empty? && data["found"] == true
      @score = "Great word!"
    elsif data["found"] == false
      @score = "Sorry, but #{params[:word]} does not seem to be a valid word"
    else
      @score = "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}"
    end
  end
end
