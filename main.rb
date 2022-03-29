require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'
require './pieces.rb'
require './gameplay.rb'

game = Board.new
game.render


puts game.cell_contents('f4')

get_coordinates
