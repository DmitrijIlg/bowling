require_relative '../game'

RSpec.describe Game do
  before :each do
    @game = Game.new
  end

  it "after 12 balls game over" do
    12.times { @game.throw_a_ball(10) }
    expect(@game.game_over?).to be true
  end

  it "after 11 balls not game over" do
    11.times { @game.throw_a_ball(10) }
    expect(@game.game_over?).to be false
  end

  it "after 12 balls score 300" do
    12.times { @game.throw_a_ball(10) }
    expect(@game.score).to eq 300
  end

  it "after 12 balls when last frame with status spare score 285" do
    9.times { @game.throw_a_ball(10) }
    3.times { @game.throw_a_ball(5) }
    expect(@game.score).to eq 270
  end

  it "after 14 balls when first frame with status spare score 290" do
    2.times { @game.throw_a_ball(5) }
    11.times { @game.throw_a_ball(10) }
    expect(@game.score).to eq 290
  end

  it "after 13 balls when first frame with status closed score 274" do
    2.times { @game.throw_a_ball(2) }
    11.times { @game.throw_a_ball(10) }
    expect(@game.score).to eq 274
  end

  it "after 14 balls when last frame with status closed score 250" do
    9.times { @game.throw_a_ball(10) }
    2.times { @game.throw_a_ball(2) }
    expect(@game.score).to eq 250
  end

  it "after 20 balls when all frame with status closed score 40" do
    20.times { @game.throw_a_ball(2) }
    expect(@game.score).to eq 40
  end
end
