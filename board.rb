require './pieces'
require './gameplay'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

# Responsible for holding game state, rendering board and querying board information
class Board
  include Gameplay
  attr_accessor :state, :player1_turn, :turn_info
  
  DEFAULT_BOARD = [
    [Major.new(false), Lieutenant.new(false), Miner.new(false), Miner.new(false), Miner.new(false), 
      Captain.new(false), Bomb.new(false), Sergeant.new(false), Bomb.new(false), Flag.new(false)],
    [Captain.new(false), Scout.new(false), Captain.new(false), Sergeant.new(false), Lieutenant.new(false), 
      Scout.new(false), Scout.new(false), Bomb.new(false), Sergeant.new(false), Bomb.new(false)],
    [Scout.new(false), Major.new(false), Scout.new(false), Scout.new(false), Marshall.new(false), 
      Major.new(false), Captain.new(false), Miner.new(false), Bomb.new(false), Sergeant.new(false)],
    [Lieutenant.new(false), Scout.new(false), Colonel.new(false), Miner.new(false), Lieutenant.new(false), 
      Scout.new(false), Colonel.new(false), Spy.new(false), General.new(false), Bomb.new(false)],
    [EmptyTile.new, EmptyTile.new, Water.new, Water.new, EmptyTile.new, 
      EmptyTile.new, Water.new, Water.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, Water.new, Water.new, EmptyTile.new, 
      EmptyTile.new, Water.new, Water.new, EmptyTile.new, EmptyTile.new],
    [Scout.new, Scout.new, Scout.new, Scout.new, Bomb.new, 
      Bomb.new, Scout.new, Lieutenant.new, Bomb.new, Bomb.new],
    [Major.new, Captain.new, Miner.new, Scout.new, Captain.new, 
      Lieutenant.new, Colonel.new, Captain.new, Sergeant.new, Sergeant.new],
    [Bomb.new, Marshall.new, Colonel.new, Scout.new, General.new, 
      Major.new, Miner.new, Major.new, Captain.new, Lieutenant.new],
    [Flag.new, Bomb.new, Miner.new, Scout.new, Spy.new, 
      Lieutenant.new, Miner.new, Sergeant.new, Miner.new, Sergeant.new]
  ]

  def initialize(board = DEFAULT_BOARD)
    @state = board
    @player1_turn = true
    @turn_info = ''
  end

  # if openboard is passed in as an ARGV, render will not hide enemy units
  def render
    if ARGV.empty?
      arg_option = ''
    else
      arg_option = ARGV[0].chomp
    end
    if arg_option == 'openboard'
      top_axis
      i = 9
      @state.each do |line_arr|
        print Rainbow("#{i}|  ").white
        line_arr.each { |element| print "#{element.symbol}  "}
        print Rainbow("|#{i}").white
        puts
        i -= 1
      end
      bottom_axis
    else
      hidden_render
    end
  end

  def hidden_render
    top_axis
    i = 9
    @state.each do |line_arr|
      print Rainbow("#{i}|  ").white
      line_arr.each do |element|
        if element.player1 == @player1_turn || element.player1.nil?
          print "#{element.symbol  }  "
        else
          if @player1_turn
            print Rainbow("*  ").green
          else
            print Rainbow("*  ").red
          end
        end
      end
      print Rainbow("|#{i}").white
      puts
      i -= 1
    end
    bottom_axis
  end

  def top_axis
    x_axis = %w[a b c d e f g h i j]
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white }
    puts '', Rainbow(' ' * 3 + '-' * 30).white
  end

  def bottom_axis
    x_axis = %w[a b c d e f g h i j]
    puts Rainbow(' ' * 3 + '-' * 30).white
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white }
  end

  def cell_contents(coordinate)
    board_index = cell_index(coordinate)
    @state[board_index[0]][board_index[1]]
  end

  def insert_to_cell(contents, coordinate)
    board_index = cell_index(coordinate)
    @state[board_index[0]][board_index[1]] = contents
  end
end
