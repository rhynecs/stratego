Bundler.require(:default)

require './pieces.rb'

describe EmptyTile do
  subject(:empty) { EmptyTile.new }

  it 'can be instantiated' do
    expect(empty).not_to be_nil
    expect(empty).to be_an_instance_of EmptyTile
  end

  it 'returns correct values' do
    expect(empty.moveable).to eq false
    expect(empty.targetable).to eq true
    expect(empty.symbol).to eq Rainbow('■').white
  end
end

describe Water do
  subject(:water) { Water.new }

  it 'can be instantiated' do
    expect(water).not_to be_nil
    expect(water).to be_an_instance_of Water
  end

  it 'has correct values' do
    expect(water.moveable).to eq false
    expect(water.targetable).to eq false
    expect(water.symbol).to eq Rainbow('■').blue
  end
end

describe Piece do
  subject(:piece) { Piece.new(player1: false, moveable: false, value: 5, icon: '3') }
  it 'can be instantiated' do
    expect(piece).not_to be_nil
    expect(piece).to be_an_instance_of Piece
  end

  it 'can initialize values with given parameters correctly' do
    expect(piece.targetable).to eq true
    expect(piece.player1).to eq false
    expect(piece.moveable).to eq false
    expect(piece.value).to eq 5
    expect(piece.icon).to eq '3'
    expect(piece.symbol).to eq Rainbow('3').green
  end
  
  it 'can initialize values with default parameters correctly' do
    expect(Piece.new.player1).to eq true
    expect(Piece.new.moveable).to eq true
    expect(Piece.new.value).to eq 9
    expect(Piece.new.icon).to eq '9'
    expect(Piece.new.symbol).to eq Rainbow('9').red
  end
end