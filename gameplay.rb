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

# checks that elements of an array of coordinates are within range. returns false if invalid.
def valid_coordinates_input(coordinates)
  coordinates.each do |grid_ref|
    return false unless /^[a-j][0-9]$/.match(grid_ref)
  end
end

def move()
end

# returns a cell index from a grid-cordinate
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

# error class for invalid user input method
class InvalidUserInput < StandardError
  def message
    'Invalid input. Please try again.'
  end
end