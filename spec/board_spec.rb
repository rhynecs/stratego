
require './board.rb'
require './pieces.rb'

describe Board do
  subject(:board) { Board.new }

  it 'can be instantiated' do
    expect(board).not_to be_nil
    expect(board).to be_an_instance_of Board
  end

  describe '#cell_contents' do
    it 'returns the correct grid object on the default board' do
      expect(board.cell_contents('a4')).to be_an_instance_of EmptyTile
      expect(board.cell_contents('c4')).to be_an_instance_of Water
    end
  end

  describe '#insert_to_cell' do
    it 'can insert a value to a cell from a given an element and cell_index' do
      expect(board.insert_to_cell('a', 'a1')).to eq board.state[8][0]
      expect(board.insert_to_cell('a', 'g3')).to eq board.state[6][6]
      expect(board.insert_to_cell('a', 'j9')).to eq board.state[0][9]
    end
  end
end