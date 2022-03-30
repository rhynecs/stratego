require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'
require './pieces.rb'
require './gameplay.rb'

game = Board.new
game.render
