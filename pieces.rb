# Empty tile board piece
class EmptyTile
  attr_reader :moveable, :symbol, :targetable

  def initialize
    @player1 = nil
    @moveable = false
    @targetable = true
    @value = nil
    @symbol = Rainbow('■').white
  end
end

# Water board piece
class Water
  attr_reader :moveable, :symbol, :targetable

  def initialize
    @player1 = nil
    @moveable = false
    @targetable = false
    @symbol = Rainbow('■').blue
  end
end

# generic piece class to make class inheritence and testing easier
# not used in game
class Piece
  attr_reader :player1, :moveable, :value, :icon, :symbol, :targetable

  def initialize(player1: true, moveable: true, value:, icon:)
    @targetable = true
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

class Marshall < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 10, icon: '1')
  end
end

class General < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 9, icon: '2')
  end
end

class Colonel < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 8, icon: '3')
  end
end

class Major < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 7, icon: '4')
  end
end

class Captain < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 6, icon: '5')
  end
end

class Lieutenant < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 5, icon: '6')
  end
end

class Sergeant < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 4, icon: '7')
  end
end

class Miner < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 3, icon: '8')
  end
end

class Scout < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 2, icon: '9')
  end
end

class Spy < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 1, icon: 'S')
  end
end

class Flag < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 0, icon: 'F')
  end
end

class Bomb < Piece
  attr_reader :player1, :moveable, :value, :symbol

  def initialize(player1 = true)
    super(player1: player1, moveable: true, value: 11, icon: 'B')
  end
end