require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10)
    letter_array = 'abcdefghijklmnopqrstuvwxyz'

    @letters.each_with_index do |_, index|
      rand = Random.new
      @letters[index] = letter_array[rand.rand(letter_array.length)]
    end
  end

  def score
    word = params[:word].downcase
    letters = params[:letters]
    @message = message(word, letters)
    @score = 0

    word.chars.each do |_|
      @score += 100 if chars?(word, letters) == true && valid?(word) == true
    end

    save_score
  end

  private

  def chars?(word, letters)
    word.chars.each do |char|
      return false if letters.include?(char) == false
    end
    true
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.parse(url).open.read
    dictionary = JSON.parse(serialized)
    dictionary['found']
  end

  def message(word, letters)
    true_msg = "Congratulations! #{word.capitalize} is a valid English word!"
    invalid_msg = "Sorry but #{word} does not seem to be a valid English word..."
    false_msg = "Sorry but #{word} can't be built out of (#{letters.upcase})"

    return true_msg if chars?(word, letters) == true && valid?(word) == true
    return invalid_msg if chars?(word, letters) == true && valid?(word) == false
    return false_msg if chars?(word, letters) == false
  end

  def save_score
    cookies[:high_score] = @score if @score > cookies[:high_score].to_i
  end
end
