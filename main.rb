require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'
require './pieces.rb'

game = Board.new
game.render

puts game.return_cell("g1")