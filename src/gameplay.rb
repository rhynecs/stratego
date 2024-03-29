# gets two coordinates from user input. Prompts until valid input is recieved.
module Gameplay
  # checks if game is won yet
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

  # begins sequence of methods that make up a player move
  def move
    begin
      # check move validity
      # if no error is found the move must be legal
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

  # starts board updating logic following a valid move
  def update_board(coordinates)
    if cell_contents(coordinates[1]).player1.nil?
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    else
      battle(coordinates)
    end
    @player1_turn = !@player1_turn
  end

  # determines what cells to replace when a battle occurs
  # handles special pieces
  def battle(coordinates)
    attacker_value = cell_contents(coordinates[0]).value
    defender_value = cell_contents(coordinates[1]).value
    self.turn_info << "attacker #{cell_contents(coordinates[0]).symbol} "

    # bomb special case
    if (attacker_value == 3) && (defender_value == 11)
      self.turn_info << "defuses bomb #{cell_contents(coordinates[1]).symbol}"
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    # spy and marshall special case
    elsif (attacker_value == 1) && (defender_value == 10)
      self.turn_info << "has vanquished #{cell_contents(coordinates[1]).symbol}"
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    # normal cases
    elsif attacker_value > defender_value
      self.turn_info << "defeats defender #{cell_contents(coordinates[1]).symbol}"
      insert_to_cell(cell_contents(coordinates[0]), coordinates[1])
      insert_to_cell(EmptyTile.new, coordinates[0])
    elsif attacker_value < defender_value
      self.turn_info << "loses to defender #{cell_contents(coordinates[1]).symbol}"
      insert_to_cell(EmptyTile.new, coordinates[0])
    else
      self.turn_info << "and defender #{cell_contents(coordinates[1]).symbol} each defeat each other in battle"
      insert_to_cell(EmptyTile.new, coordinates[0])
      insert_to_cell(EmptyTile.new, coordinates[1])
    end
  end

  # prompts user for coordinate input
  def user_coordinates(coordinates = '')
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
      # check each grid coordinate is in range and of the form LetterNumber
      unless (/^[a-j][0-9]$/.match?(grid_ref))
        raise InvalidUserInput
      end
    end
    self.turn_info << "move #{coordinates} :"
    coordinates
  end

  # checks that the distance the selected tile moves is legal
  # checks that the scout is only travelling in 1 direction and all tiles between are blank
  def valid_move_distance(coordinates)
    # get all cell index values
    y1 = cell_index(coordinates[0])[0]
    y2 = cell_index(coordinates[1])[0]
    x1 = cell_index(coordinates[0])[1]
    x2 = cell_index(coordinates[1])[1]

    # calculate magnitude of move distance in x or y direction
    y_dist = (y1 - y2).abs
    x_dist = (x1 - x2).abs

    # special scout logic
    if cell_contents(coordinates[0]).instance_of? Scout
      # ensures scout is only moving in one plane
      unless (x_dist.positive? && y_dist.zero?) || (x_dist.zero? && y_dist.positive?)
        raise InvalidMove
      end

      # ensures scout is only moving over empty tiles and not jumping over units
      if y1 == y2
        x_arr = (x1...x2).drop(1).to_a
        x_arr.each do |x_cord|
          unless @state[y1][x_cord].instance_of? EmptyTile
            raise InvalidMove
          end
        end
      else
        y_arr = (y1...y2).drop(1).to_a
        y_arr.each do |y_cord|
          unless @state[y_cord][x1].instance_of? EmptyTile
            raise InvalidMove
          end
        end
      end

    # for all other units, check it is only moving one tile in one direction
    else
      unless (x_dist == 1 && y_dist.zero?) || (x_dist.zero? && y_dist == 1)
        raise InvalidMove
      end
    end
    true
  end

  # checks if selected tile is a valid selection
  def valid_origin_selected(coordinate)
    moveable = cell_contents(coordinate).moveable
    player1 = cell_contents(coordinate).player1

    if (@player1_turn == player1) && moveable
      true
    else
      raise InvalidMove
    end
  end

  # checks if the targeted tile is a valid selection
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
  # cell index values can be used to access Board.state
  def cell_index(coordinate)
    coordinate = coordinate.strip

    # hard coded lookups
    y_lookup = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    x_lookup = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7, 'i' => 7, 'j' => 9 }

    grid_letter_equiv = coordinate.chars[0]
    grid_number_equiv = coordinate.chars[1].to_i
    y_index = y_lookup[grid_number_equiv]
    x_index = x_lookup[grid_letter_equiv]
    [y_index, x_index]
  end
end

# error class for invalid user input
class InvalidUserInput < StandardError
  def message
    'Invalid input. Please try again.'
  end
end

# error class for invalid moves
class InvalidMove < StandardError
  def message
    'Move is not legal. Please try again.'
  end
end