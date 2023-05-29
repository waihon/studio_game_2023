class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def  add_player(a_player)
    @players.push(a_player)
  end
end
