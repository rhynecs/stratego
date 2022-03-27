require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'
require './pieces.rb'

game = Board.new
game.render

puts game.cell_index("g1")

puts game.cell_contents("g1")