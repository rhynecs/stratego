# Responsible for holding game state, rendering board.
class Board
  attr_accessor :state

  DEFAULT_BOARD = [
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '~', '~', '*', '*', '~', '~', '*', '*'],
    ['*', '*', '~', '~', '*', '*', '~', '~', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '3', '*', '*', '*'],
    ['*', '*', '*', '*', '2', '*', 'H', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', 'R', '*', '*', '*']
  ]

  def initialize
    @state = DEFAULT_BOARD
  end

  def render
    # TODO - intelligent axis alignment
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
end