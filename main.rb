require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board.rb'

game = Board.new
game.render