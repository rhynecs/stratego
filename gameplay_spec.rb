Bundler.require(:default)

require './gameplay.rb'
  
describe '#cell_index' do
  it 'returns the correct index values to access a cell from the board array' do
    expect(cell_index('b5')).to eq [4, 1]
    expect(cell_index('j0')).to eq [9, 9]
  end
end

describe '#valid_coordinates_input' do
  it 'returns false if coordinate input is invalid' do
    expect(valid_coordinates_input(%w[a10 b4])).to eq false
    expect(valid_coordinates_input(%w[q9 c3])).to eq false
    expect(valid_coordinates_input(%w[a4 4c])).to eq false
  end
end