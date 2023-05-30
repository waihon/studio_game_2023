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

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def print_name_and_score(player)
    formatted_name = player.name.ljust(20, '.')
    puts "#{formatted_name} #{player.score}"
  end

  def print_stats
    puts "\n#{@title} Statustics:"

    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "\n#{strong_players.size} strong player(s):"
    strong_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{wimpy_players.size} wimpy player(s):"
    wimpy_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{@title} High Scores:"
    @players.sort_by(&:score).each do |player|
      print_name_and_score(player)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Moe")
  player2 = Player.new("Larry", 60)
  player3 = Player.new("Curly", 125)

  knuckleheads = Game.new("Knuckleheads").tap do |game|
    game.add_player(player1)
    game.add_player(player2)
    game.add_player(player3)
  end
  knuckleheads.play(3)
  knuckleheads.print_stats
end
