require_relative 'frame'

class Game
  def initialize
    @frames = []
    @current_frame = nil
  end

  def throw_a_ball(pins = nil)
    if @current_frame.nil? || !@current_frame.accept_throw?
      @frames << @current_frame unless @current_frame.nil?
      return 'Game over' if (@frames.count + 1) > 10
      @current_frame = Frame.new(@frames.count + 1)
    end
    add_points_to_frames(@current_frame.knock_down(pins))
  end

  def score
    @frames.map(&:score).inject(:+)
  end

  def current_frame_stats
    @current_frame.stats
  end

  def stats
    puts
    puts
    puts '*' * 10
    puts 'Game stats'
    puts '*' * 10
    @frames.each do |f|
      puts "Frame number #{f.number}"
      puts "Frame points #{f.points}"
      puts "Frame score #{f.score}"
      puts '-' * 10
    end
    puts
    puts
    puts "Total game score #{score}"
  end

  def game_over?
    @frames.count >= 10
  end

  private

  def add_points_to_frames(points)
    @frames.each do |frame|
      frame.add_points(points) if frame.accept_points?
    end
    nil
  end
end
