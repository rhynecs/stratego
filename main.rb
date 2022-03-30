require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board'
require './pieces'
require './gameplay'

game = Board.new
game.render

while true
    game.move
end