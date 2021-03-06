require './gameplay'
require './board'
require './pieces'

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

  describe '#valid_move_distance' do
    it 'returns true with a valid move distance' do
      expect(board.valid_move_distance(%w[b3 b4])).to eq true
      expect(board.valid_move_distance(%w[b3 b2])).to eq true
      expect(board.valid_move_distance(%w[b3 c3])).to eq true
      expect(board.valid_move_distance(%w[b3 a3])).to eq true
    end
    it 'raises InvalidMove exception with an invalid move distance' do
      expect { board.valid_move_distance(%w[b3 c4]) }.to raise_error(InvalidMove)
      expect { board.valid_move_distance(%w[b3 a2]) }.to raise_error(InvalidMove)
      expect { board.valid_move_distance(%w[b3 b9]) }.to raise_error(InvalidMove)
      expect { board.valid_move_distance(%w[b3 j3]) }.to raise_error(InvalidMove)
      expect { board.valid_move_distance(%w[b3 e9]) }.to raise_error(InvalidMove)
    end
  end

  describe '#valid_origin_selected' do
    it 'returns true with a valid tile selection' do
      expect(board.valid_origin_selected('j0')).to eq true
      expect(board.valid_origin_selected('e0')).to eq true
      expect(board.valid_origin_selected('a3')).to eq true
    end
    it 'raises InvalidMove exception with invalid selection' do
      # opponent tile
      expect { board.valid_origin_selected('a6') }.to raise_error(InvalidMove)
      # bomb
      expect { board.valid_origin_selected('e3') }.to raise_error(InvalidMove)
      # empty tile
      expect { board.valid_origin_selected('a4') }.to raise_error(InvalidMove)
      # water
      expect { board.valid_origin_selected('c4') }.to raise_error(InvalidMove)
    end
  end

  describe '#valid_target_selected' do
    it 'returns true with a valid target selection' do
      # enemy tiles
      expect(board.valid_target_selected('a6')).to eq true
      expect(board.valid_target_selected('e9')).to eq true
      expect(board.valid_target_selected('f9')).to eq true
    end
    it 'raises error with invalid target selection' do
      # friendly tile
      expect { board.valid_target_selected('a3') }.to raise_error(InvalidMove)
      # water
      expect { board.valid_target_selected('c4') }.to raise_error(InvalidMove)
    end
  end

  describe '#cell_index' do
    it 'returns the correct index values to access a cell from the board array' do
      expect(board.cell_index('b5')).to eq [4, 1]
      expect(board.cell_index('j0')).to eq [9, 9]
    end
  end
end