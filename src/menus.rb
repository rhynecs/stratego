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
      help1
    when 'about'
      about
    end
  end

  def play_game
    game = Board.new
    until game.won?
      game.render
      game.move
      print "\n" * 50 # to hide board
      puts game.turn_info
      game.turn_info = '' # resets turn info, ready for next turn
      turn_end_menu
    end
    main_menu
  end

  def turn_end_menu
    prompt = TTY::Prompt.new
    prompt.keypress("Press key when next player is ready")
  end

  def about
    parsed = TTY::Markdown.parse_file('./markdown/about.md')
    puts parsed
    prompt = TTY::Prompt.new
    prompt.keypress("Press key to return to menu")
    main_menu
  end

  def help1
    parsed = TTY::Markdown.parse_file('./markdown/help1.md')
    puts parsed
    choices = ['next page', 'menu']
    prompt = TTY::Prompt.new
    selection = prompt.select("help", choices)
    case selection
    when 'next page'
      help2
    when 'menu'
      main_menu
    end
  end

  def help2
    parsed = TTY::Markdown.parse_file('./markdown/help2.md')
    puts parsed
    choices = ['next page', 'back', 'menu']
    prompt = TTY::Prompt.new
    selection = prompt.select("help", choices)
    case selection
    when 'next page'
      help3
    when 'back'
      help1
    when 'menu'
      main_menu
    end
  end

  def help3
    pieces_table
    choices = ['back', 'menu']
    prompt = TTY::Prompt.new
    selection = prompt.select("help", choices)
    case selection
    when 'back'
      help2
    when 'menu'
      main_menu
    end
  end

  def pieces_table
    table = TTY::Table.new(header: ['Rank/Symbol', 'Piece', 'Number per side', 'Special Properties'])
    table << ['B', 'Bomb', '6', 'Immovable; captured by miner - all other pieces lose in battle']
    table << ['1', 'Marshall', '1', '']
    table << ['2', 'General', '1', '']
    table << ['3', 'Colonel', '2', '']
    table << ['4', 'Major', '3', '']
    table << ['5', 'Captain', '4', '']
    table << ['6', 'Lieutenant', '4', '']
    table << ['7', 'Sergeant', '4', '']
    table << ['8', 'Miner', '5', 'Can defuse bombs']
    table << ['9', 'Scout', '8', 'Moves any number of squares in one direction and can attack on the same move']
    table << ['S', 'Spy', '1', 'Can capture marshall if spy attacks first']
    table << ['F', 'Flag', '1', 'Immovable; capturing the flag wins']
    puts table.render(:ascii)
  end
end
