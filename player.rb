class Player
  attr_accessor :name
  attr_reader :health

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

  def strong?
    @health > 100
  end

  def blam
    @health -= 10
    puts "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
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
