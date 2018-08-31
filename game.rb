require_relative 'frame'

class Game
  attr_reader :frames

  def initialize
    @frames = []
    @current_frame = nil
  end

  def throw_a_ball(pins = nil)
    return 'Game over' if @frames.count >= 10
    @current_frame = Frame.new(@frames.count + 1) if @current_frame.nil?
    add_points_to_frames(@current_frame.knock_down(pins)) if @frames.count < 10
    unless @current_frame.accept_throw?
      @frames << @current_frame
      @current_frame = nil
    end
  end

  def score
    @frames.map(&:score).inject(:+)
  end

  def current_frame_stats
    @current_frame.nil? ? @frames.last.stats : @current_frame.stats
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
