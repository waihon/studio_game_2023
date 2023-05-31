require_relative 'player'
require_relative 'game'

class ClumsyPlayer < Player
  attr_reader :boost_factor

  def initialize(name, health=100, boost_factor=1)
    super(name, health)
    @boost_factor = boost_factor
  end

  def w00t
    @boost_factor.times { super }
  end

  def found_treasure(treasure)
    damaged_treasure = Treasure.new(treasure.name, treasure.points / 2.0)
    super(damaged_treasure)
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Moe")
  player2 = Player.new("Larry")
  player3 = ClumsyPlayer.new("Curly", 100, 3)

  knuckleheads = Game.new("Knuckleheads").tap do |game|
    game.add_player(player1)
    game.add_player(player2)
    game.add_player(player3)
  end
  knuckleheads.play(3)
  knuckleheads.print_stats
end
