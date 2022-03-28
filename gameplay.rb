# gets two coordinates from user input. Prompts until valid input is recieved.
def get_coordinates
  # repeats prompting until user inputs a string
  coordinates = ''
  while coordinates.empty?
    puts 'Enter coordinate values '
    coordinates = gets.chomp.split(' ')
  end
  # raises error if coordinates are the same or there is only one coordinate
  raise InvalidUserInput if coordinates[0] == coordinates[1] || coordinates.length != 2
  # raises error unless grid reference is of the correct syntax and in range
  raise InvalidUserInput unless coordinates.each { |grid_ref| /^[a-j][0-9]$/.match(grid_ref) }

  return coordinates
end

def move
  until valid_tile && valid_target
    begin
      coordinates = get_coordinates
      raise InvalidMove unless valid_tile_selected(coordinates)
      valid 
      raise InvalidMove unless true
    rescue InvalidMove => e
      puts e.message
      retry
    end
  end
end

def valid_target_selected

end

# checks if selected tile is valid to be moved.
# must be have the moveable parameter and belong to the player whose turn it is.
def valid_tile_select(coordinate)
  cell = game.cell_contents(coordinate)
  if game.player1_turn == cell.player1 && cell.moveable
    return true
  else
    raise InvalidMove
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