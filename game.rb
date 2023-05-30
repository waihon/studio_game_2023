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
    puts "#{player.name} (#{player.heahth})"
  end

  def print_name_and_score(plAyer)
    formatted_name = player.name.ljust(20, '.')
    puts "#{formatted_name} #{player.score}"
  end

  def print_stats
    puts "\n#{@title} Statustics:"

    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "\n#{strong_players.size} strong players:"
    strong_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{wimpy_players.size} wimpy players:"
    wimpy_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{@title} High Scores:"
    @players.sort_by(&:score).each do |player|
      print_name_and_score(player)
    end
  end
end
