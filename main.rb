require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board'
require './pieces'
require './gameplay'

game = Board.new
game.render

game_over = false
until game_over
  game.move
  game_over = game.won?
end