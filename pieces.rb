# Empty tile board piece
class EmptyTile
  attr_reader :moveable, :symbol

  def initialize
    @moveable = false
    @value = nil
    @symbol = Rainbow('■').white
  end
end

# Water board piece
class Water
  attr_reader :moveable, :symbol

  def initialize
    @moveable = false
    @symbol = Rainbow('■').blue
  end
end

# generic piece class to make class inheritence and testing easier
# not used in game
class Piece
  attr_reader :player1, :moveable, :value, :icon, :symbol

  def initialize(player1: true, moveable: true, value: 9, icon: '9')
    @player1 = player1
    @moveable = moveable
    @value = value
    @icon = icon
    if @player1
      @symbol = Rainbow(@icon).red
    else
      @symbol = Rainbow(@icon).green
    end
  end
end


class General < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 9, icon: '9')
  end
end