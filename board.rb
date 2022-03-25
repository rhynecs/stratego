# Responsible for holding game state, rendering board and querying board information
class Board
  attr_accessor :state

  DEFAULT_BOARD = [
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '#'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '~', '~', '*', '*', '~', '~', '*', '*'],
    ['*', '*', '~', '~', '*', '*', '~', '~', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '3', '*', '*', '*'],
    ['*', '*', '*', '*', '2', '*', 'H', '*', '*', '*'],
    ['#', '*', '*', '*', '*', '*', 'R', '*', '*', '*']
  ]

  def initialize(board = DEFAULT_BOARD)
    @state = board
  end

  def render
    # print top horizontal axis
    x_axis = %w[a b c d e f g h i j]
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white}
    puts '', Rainbow(' ' * 3 + '-' * 30).white

    # print vertical axis and board
    i = 9
    @state.each do |line_arr|
      print Rainbow("#{i}|  ").white
      line_arr.each { |element| print "#{element}  " }
      print Rainbow("|#{i}").white
      puts
      i -= 1
    end

    #print bottom horizontal axis
    puts Rainbow(' ' * 3 + '-' * 30).white
    print ' ' * 4
    x_axis.each { |letter| print Rainbow("#{letter}  ").white }
  end

  # returns the contents of a cell from a grid_reference
  def return_cell(grid_ref)
    # raise error
    grid_ref.strip
    return InvalidGridError.new unless /^[a-j][0-9]$/.match(grid_ref)
  end
end

# error for return_cell method
class InvalidGridError < StandardError
  def message
    'Grid co-ordinate out of range or invalid syntax'
  end
end
