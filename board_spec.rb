Bundler.require(:default)

require './board.rb'
require './pieces.rb'

describe Board do
  subject(:board) { Board.new }

  it 'can be instantiated' do
    expect(board).not_to be_nil
    expect(board).to be_an_instance_of Board
  end

  describe '#return_cell' do
    it 'throws InvalidGridError with out of range input' do
      expect(board.return_cell('z9')).to be_an_instance_of InvalidGridError
      expect(board.return_cell('asfdjkadfhsjk')).to be_an_instance_of InvalidGridError
      expect(board.return_cell('1a')).to be_an_instance_of InvalidGridError
      expect(board.return_cell('23')).to be_an_instance_of InvalidGridError
    end

    it 'returns the correct grid element on the default board' do
      expect(board.return_cell('a4')).to be_an_instance_of EmptyTile
      expect(board.return_cell('c4')).to be_an_instance_of Water
    end
  end
end
