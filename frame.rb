class Frame
  STATUSES = %w[open strike spare closed].freeze
  NUMBERS = (1..10).to_a.freeze

  attr_reader :number

  def initialize(number)
    @number = number
    @pins_left = 10
    @status = 'open'
    @points = []
    @score = nil
  end

  def knock_down
    return "Can't accept throw!" unless accept_throw?
    pins = rand(0..@pins_left)
    # pins = 5
    @pins_left -= pins
    if    @points.count.zero? && @pins_left.zero? then set_strike(pins)
    elsif @points.count == 1 && @pins_left.zero?  then set_spare(pins)
    elsif @points.count == 2 && !@pins_left.zero? then set_close(pins)
    else  set_points(pins)
    end
    @score = @points.inject(:+)
    pins
  end

  def accept_points?
    %w[strike spare].include?(@status) && @points.count < 3
  end

  def stats
    puts '*' * 10
    p @number
    p @pins_left
    p @status
    p @points
    p @score
    puts '*' * 10
  end

  def accept_throw?
    !%w[strike spare close].include?(@status) ||
      tenth?
  end

  private

  def tenth?
    (%w[strike spare].include?(@status) &&
      @number == 10 &&
        @points.count < 3)
  end

  def set_strike(pins)
    @status = 'strike'
    @points << pins
    add_pins if tenth?
    nil
  end

  def set_spare(pins)
    @status = 'spare' unless @number == 10 && @points.count == 1
    @points << pins
    add_pins if tenth?
    nil
  end

  def set_close(pins)
    @status = 'closed' unless @number == 10 && @points.count == 2
    @points << pins
    nil
  end

  def set_points(pins)
    @points << pins
    nil
  end

  def add_pins
    @pins_left = 10
    nil
  end
end
