require_relative 'game'

knuckleheads = Game.new("Knuckleheads")
puts ARGV
knuckleheads.load_players(ARGV.shift || "players.csv")

loop do
  print "\nHow many rounds? ('quit' to exit) "
  answer = gets.chomp.downcase
  case answer
  when /^\d+$/
    knuckleheads.play(answer.to_i)
  when 'quit', 'exit'
    knuckleheads.print_stats
    knuckleheads.save_high_scores
    break
  else
    print "\nPlease enter a number or 'quit' "
  end
end
