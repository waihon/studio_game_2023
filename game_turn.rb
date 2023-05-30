require_relative 'player'
require_relative 'dice'
require_relative 'treasure_trove'

module GameTurn
  def self.take_turn(player)
    dice = Dice.new
    case  dice.roll
    when 1..2
      player.blam
    when 3..4
      puts "#{player.name} was skipped."
    when 5..6
      player.w00t
    end

    treasure = TreasureTrove.random
    player.found_treasure(treasure)
  end
end

