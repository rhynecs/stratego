require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './board'
require './gameplay'


module Menu
  def main_menu
    choices = %w[play help about]
    prompt = TTY::Prompt.new
    selection = prompt.select("Stratego", choices)
    case selection
    when 'play'
      play_game
    when 'help'
      display_help
    when 'about'
      display_about
    end
  end
  
  def play_game
    game = Board.new
    game.render
    until game.won?
      game.move
    end
    main_menu
  end
end
