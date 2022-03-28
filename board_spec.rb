Bundler.require(:default)

require './board.rb'
require './pieces.rb'

describe Board do
  subject(:board) { Board.new }

  it 'can be instantiated' do
    expect(board).not_to be_nil
    expect(board).to be_an_instance_of Board
  end

  describe '#cell_contents' do
    it 'returns the correct grid element on the default board' do
      expect(board.cell_contents('a4')).to be_an_instance_of EmptyTile
      expect(board.cell_contents('c4')).to be_an_instance_of Water
    end
  end

  describe '#insert_to_cell' do
    it 'can insert a value to a cell from a given an element and cell_index' do
      expect(board.insert_to_cell('a', [0, 0])).to eq board.state[0][0]
      expect(board.insert_to_cell('a', [5, 9])).to eq board.state[5][9]
      expect(board.insert_to_cell('a', [2, 1])).to eq board.state[2][1]
    end
  end
end
