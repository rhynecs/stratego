require './gameplay.rb'
require './board.rb'
require './pieces.rb'

describe Board do
  subject(:board) { Board.new }
  describe '#user_coordinates' do
    it 'returns InvalidUserInput exception if coordinate input is invalid' do
      expect { board.user_coordinates('a4 b10') }.to raise_error(InvalidUserInput)
      expect { board.user_coordinates('q9 c3') }.to raise_error(InvalidUserInput)
      expect { board.user_coordinates('a4 4c') }.to raise_error(InvalidUserInput)
      expect { board.user_coordinates('a1b2') }.to raise_error(InvalidUserInput)
      expect { board.user_coordinates('a1 a1') }.to raise_error(InvalidUserInput)
    end

    it 'returns array of coordinates if the input is a valid string of coordinates' do
      expect(board.user_coordinates('a1 b3')).to eq ['a1', 'b3']
      expect(board.user_coordinates('j5 b1')).to eq ['j5', 'b1']
      expect(board.user_coordinates('e2 g9')).to eq ['e2', 'g9']
    end
  end

  describe '#valid_tile_selected' do
    it 'returns true with a valid tile selection' do
      expect(board.valid_tile_selected('j0')).to eq true
    end
  end

  describe '#cell_index' do
    it 'returns the correct index values to access a cell from the board array' do
      expect(board.cell_index('b5')).to eq [4, 1]
      expect(board.cell_index('j0')).to eq [9, 9]
    end
  end
end