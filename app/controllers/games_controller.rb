class GamesController < ApplicationController
  def new
    @letters = Array.new(10)
    letter_array = 'abcdefghijklmnopqrstuvwxyz'

    @letters.each_with_index do |_, index|
      rand = Random.new
      @letters[index] = letter_array[rand.rand(letter_array.length)].capitalize
    end
  end

  def score
    raise
  end
end
