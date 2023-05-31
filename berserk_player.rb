require_relative 'player'
require_relative 'clumsy_player'

class BerserkPlayer < Player
  def initialize(name, health=100)
    super(name, health)
    @w00t_count = 0
  end

  def berserk?
    @w00t_count >= 3
  end

  def w00t
    super
    @w00t_count += 1
    puts "#{name} is berserk!" if berserk?
  end

  def blam
    if berserk?
      w00t
    else
      super
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Moe")
  player2 = BerserkPlayer.new("Larry")
  player3 = ClumsyPlayer.new("Curly", 100, 3)

  knuckleheads = Game.new("Knuckleheads").tap do |game|
    game.add_player(player1)
    game.add_player(player2)
    game.add_player(player3)
  end
  knuckleheads.play(10)
  knuckleheads.print_stats
end
