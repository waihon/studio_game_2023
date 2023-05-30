require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(a_player)
    @players.push(a_player)
  end

  def load_players(from_file)
    File.readlines(from_file).each do |line|
      add_player(Player.from_csv(line))
    end
  end

  def play(rounds=1)
    puts "There are #{@players.size} players in #{@title}:"
    print_treasures

    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def total_points
    @players.reduce(0) { |sum, player| sum + player.points }
  end

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def high_score_entry(player)
    formatted_name = player.name.ljust(20, '.')
    "#{formatted_name} #{player.score}"
  end

  def print_name_and_score(player)
    puts high_score_entry(player)
  end

  def print_stats
    puts "\n#{@title} Statistics:"

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

    puts "\n#{total_points} total points from treasures found"
    @players.sort_by(&:points).each do |player|
      puts "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grant total points"
    end
  end

  def print_treasures
    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found:"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end
  end

  def save_high_scores(to_file="high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{title} High Scores:"
      @players.sort_by(&:score).each do |player|
        file.puts high_score_entry(player)
      end
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
