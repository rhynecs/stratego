# gets two coordinates from user input. Prompts until valid input is recieved.
module Gameplay
  def won?
    player1_has_flag = false
    player2_has_flag = false
    @state.each do |line|
      line.each do |element|
        if element.instance_of? Flag
          if element.player1
            player1_has_flag = true
          else
            player2_has_flag = true
          end
        end
      end
    end
    if !player1_has_flag
      puts "green wins!"
      true
    elsif !player2_has_flag
      puts "red wins!"
      true
    else
      false
    end
  end

  def move
    begin
      # check move validity
      coordinates = user_coordinates
      valid_move_distance(coordinates)
      valid_origin_selected(coordinates[0])
      valid_target_selected(coordinates[1])
    rescue InvalidMove, InvalidUserInput => e
      puts e.message
      retry
    end
    update_board(coordinates)
    render
  end

  def update_board(coordinates)
    if cell_contents(coordinates[1]).player1.nil?
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    else
      battle(coordinates)
    end
    @player1_turn = !@player1_turn
  end

  def battle(coordinates)
    attacker_value = cell_contents(coordinates[0]).value
    defender_value = cell_contents(coordinates[1]).value
    if attacker_value > defender_value
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    elsif attacker_value < defender_value
      insert_to_cell(EmptyTile.new, coordinates[0])
    else
      insert_to_cell(EmptyTile.new, coordinates[0])
      insert_to_cell(EmptyTile.new, coordinates[1])
    end
  end

  def user_coordinates(coordinates = '')
    # repeats prompting until user inputs a string
    while coordinates.empty?
      puts ''
      puts 'Enter coordinate values:'
      coordinates = STDIN.gets
    end
    coordinates = coordinates.chomp.split(' ')
    if coordinates[0] == coordinates[1] || coordinates[0].nil? || coordinates[1].nil?
      raise InvalidUserInput
    end

    coordinates.each do |grid_ref|
      unless (/^[a-j][0-9]$/.match?(grid_ref))
        raise InvalidUserInput
      end
    end
    coordinates
  end

  # checks that the distance the selected tile moves is
  def valid_move_distance(coordinates)
    y1 = cell_index(coordinates[0])[0]
    y2 = cell_index(coordinates[1])[0]
    x1 = cell_index(coordinates[0])[1]
    x2 = cell_index(coordinates[1])[1]

    y_dist = (y1 - y2).abs
    x_dist = (x1 - x2).abs

    unless (x_dist == 1 && y_dist.zero?) || (x_dist.zero? && y_dist == 1)
      raise InvalidMove
    end
    true
  end

  # checks if selected tile is valid to be moved.
  # must be have the moveable parameter and belong to the player whose turn it is.
  def valid_origin_selected(coordinate)
    moveable = cell_contents(coordinate).moveable
    player1 = cell_contents(coordinate).player1

    if (@player1_turn == player1) && moveable
      true
    else
      raise InvalidMove
    end
  end

  def valid_target_selected(coordinate)
    targetable = cell_contents(coordinate).targetable
    player1 = cell_contents(coordinate).player1

    if (@player1_turn != player1) && targetable
      true
    else
      raise InvalidMove
    end
  end
  
  # returns two cell index values from a grid coordinate
  def cell_index(coordinate)
    coordinate = coordinate.strip

    # hard coded lookups
    y_lookup = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    x_lookup = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7, 'i' => 7, 'j' => 9 }

    # converts grid co-ordinates to equivalent array indicies
    grid_letter_equiv = coordinate.chars[0]
    grid_number_equiv = coordinate.chars[1].to_i
    y_index = y_lookup[grid_number_equiv]
    x_index = x_lookup[grid_letter_equiv]
    [y_index, x_index]
  end
end

# error class for invalid user input method
class InvalidUserInput < StandardError
  def message
    'Invalid input. Please try again.'
  end
end

class InvalidMove < StandardError
  def message
    'Move is not legal. Please try again.'
  end
end