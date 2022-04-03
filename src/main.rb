require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board'
require './pieces'
require './gameplay'
require './menus'

include Menu
main_menu