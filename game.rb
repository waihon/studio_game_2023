require_relative 'player'
require_relative 'game_turn'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def  add_player(a_player)
    @players.push(a_player)
  end

  def play(rounds=1)
    puts "There are #{@players.size} players in #{@title}:"

    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end
end
