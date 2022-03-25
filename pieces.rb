class EmptyTile
  attr_reader :moveable, :symbol

  def initialize
    @moveable = false
  end

  def symbol
    @symbol = Rainbow('■').white
  end
end

class Water < EmptyTile
  def symbol
    @symbol = Rainbow('▧').blue
  end
end