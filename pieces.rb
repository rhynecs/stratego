class EmptyTile
  attr_reader :moveable, :symbol

  def initialize
    @moveable = false
    @symbol = Rainbow('■').white
  end
end

class Water
  attr_reader :moveable, :symbol

  def initialize
    @moveable = false
    @symbol = Rainbow('■').blue
  end
end

class General
  attr_reader :moveable, :symbol, :player

  def initialize(player1 = true)
    @moveable = true
    @value = 9
    @symbol = '9'
    @player1 = player1
    if @player1.true? 
      @symbol = Rainbow('9').red
    else
      @symbol = Rainbow('9').green
    end
  end
end