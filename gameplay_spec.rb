Bundler.require(:default)

require './gameplay.rb'
require './board.rb'
require './pieces.rb'


describe '#valid_coordinates_input' do
  it 'returns false if coordinate input is invalid' do
    expect(valid_coordinates_input(%w[a10 b4])).to eq false
    expect(valid_coordinates_input(%w[q9 c3])).to eq false
    expect(valid_coordinates_input(%w[a4 4c])).to eq false
  end
end

describe '#move' do
  it 'returns'