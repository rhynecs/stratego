require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'
require './move.rb'

game = Board.new
game.render

puts game.return_cell('fdasdfa').class
