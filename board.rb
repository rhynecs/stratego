require './pieces.rb'
require './gameplay.rb'

# Responsible for holding game state, rendering board and querying board information
class Board
  attr_accessor :state, :player1_turn

  DEFAULT_BOARD = [
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, Water.new, Water.new, EmptyTile.new, 
      EmptyTile.new, Water.new, Water.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, Water.new, Water.new, EmptyTile.new, 
      General.new(false), Water.new, Water.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new],
    [EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, 
      EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new, EmptyTile.new]
  ]

  def initialize(board = DEFAULT_BOARD)
    @state = board
    @player1_turn = true
  end

  def render
    # print top horizontal axis
    x_axis = %w[a b c d e f g h i j]
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white }
    puts '', Rainbow(' ' * 3 + '-' * 30).white

    # print vertical axis and board
    i = 9
    @state.each do |line_arr|
      print Rainbow("#{i}|  ").white
      line_arr.each { |element| print "#{element.symbol}  "}
      print Rainbow("|#{i}").white
      puts
      i -= 1
    end

    # print bottom horizontal axis
    puts Rainbow(' ' * 3 + '-' * 30).white
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white }
  end

  # returns the contents of a cell from a grid_reference
  def cell_contents(grid_ref)
    board_index = cell_index(grid_ref)
    @state[board_index[0]][board_index[1]]
  end

  def insert_to_cell(contents, cell_index)
    @state[cell_index[0]][cell_index[1]] = contents
  end
end


# returns two cell index values from a grid-cordinate
def cell_index(grid_ref)
  grid_ref = grid_ref.strip

  # hard coded lookups
  y_lookup = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  x_lookup = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7, 'i' => 7, 'j' => 9 }

  # converts grid co-ordinates to equivalent array indicies
  grid_letter = grid_ref.chars[0]
  grid_number = grid_ref.chars[1].to_i
  y_index = y_lookup[grid_number]
  x_index = x_lookup[grid_letter]
  [y_index, x_index]
end





