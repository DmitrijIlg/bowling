require_relative 'game'

game = Game.new

until game.game_over?
  puts 'Press Enter to throw the ball!'
  gets
  game.throw_a_ball
  game.current_frame_stats
end

game.stats
