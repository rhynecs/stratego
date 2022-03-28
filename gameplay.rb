# gets two coordinates from user input. Prompts until valid input is recieved.
def get_coordinates
  begin
    coordinates = ''
    while coordinates.empty? do
      puts 'Enter coordinate values '
      coordinates = gets.chomp.split(' ')
    end
    raise InvalidUserInput if coordinates[0] == coordinates[1] || coordinates.length != 2
    raise InvalidUserInput unless valid_coordinates_input(coordinates)
  rescue InvalidUserInput => e
    puts e.message
    retry
  end
  coordinates
end


def move
  coords = get_coordinates
  selected_piece = cell_index(coords[0])
  target_square = 
  begin
    return cell_contents(selected_piece)
    raise InvalidMove unless cell_contents.moveable 
  rescue InvalidMove => e
    puts e.message
    retry
  end
end

# checks that elements of an array of coordinates are within range. returns false if invalid.
def valid_coordinates_input(coordinates)
  coordinates.each do |grid_ref|
    return false unless /^[a-j][0-9]$/.match(grid_ref)
  end
end

def valid_target_square()
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