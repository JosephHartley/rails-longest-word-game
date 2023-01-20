require 'securerandom'

require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    if included?(params[:word].upcase, params[:letters].split)
      if english_word?(params[:word])
        @score = "Great word!"
      else
        @score = "Sorry, but #{params[:word]} does not seem to be a valid word"
      end
    else
      @score = "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}"
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
