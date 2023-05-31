require_relative 'playable'

class Player
  include Playable

  attr_reader :name
  attr_accessor :health

  # Class-level methods
  def self.from_csv(string)
    name, health = string.split(",")
    # Integer() method will raise an exception if health is not a valid number
    new(name, Integer(health))
  end

  def initialize(name, health=100)
    @name = name.capitalize
    @health = health
    @found_treasures = Hash.new(0)
  end

  def to_s
    "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score} as of #{time}."
  end

  def time
    current_time = Time.new
    current_time.strftime("%I:%M:%S %p")
  end

  def points
    @found_treasures.values.reduce(0, :+)
  end

  def score
    @health + points
  end

  def found_treasure(treasure)
    @found_treasures[treasure.name] += treasure.points
    puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
    puts "#{@name}'s treasures: #{@found_treasures}"
  end

  def each_found_treasure
    @found_treasures.each do |name, points|
      yield Treasure.new(name, points)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Moe")
  player2 = Player.new("Larry", 60)
  player1.blam
  player2.w00t
  puts player1
  puts player2
end
