require_relative 'frame'

class Game
  def initialize
    @frames = []
    @current_frame = nil
  end

  def throw_a_ball
    if @current_frame.nil? || !@current_frame.accept_throw?
      @frames << @current_frame unless @current_frame.nil?
      return 'Game over' if (@frames.count + 1) > 10
      @current_frame = Frame.new(@frames.count + 1)
    end
    add_points_to_frames(@current_frame.knock_down)
  end

  def score
    puts @frames.map(&:score).inject(:+)
  end

  def stats
    puts '*' * 10
    @frames.each do |f|
      p f
    end
    puts
    p @frames.count
    puts
    p @current_frame
    puts '*' * 10
  end

  private

  def add_points_to_frames(points)
    @frames.each do |frame|
      frame.add_points(points) if frame.accept_points?
    end
    nil
  end
end
