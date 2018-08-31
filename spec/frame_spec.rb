require_relative '../frame'

RSpec.describe Frame do
  it 'Can\'t create frame with number 11' do
    expect { Frame.new(11) }.to raise_error(RuntimeError, 'Min 1 and Max 10')
  end

  context 'first frame' do
    before :each do
      @frame = Frame.new(1)
    end

    it 'has strike status' do
      @frame.knock_down(10)
      expect(@frame.status).to eq('strike')
    end

    it 'has spare status' do
      2.times { @frame.knock_down(5) }
      expect(@frame.status).to eq('spare')
    end

    it 'has closed status' do
      2.times { @frame.knock_down(4) }
      expect(@frame.status).to eq('closed')
    end

    it 'with strike status do not accept throw' do
      @frame.knock_down(10)
      expect(@frame.accept_throw?).to be false
    end

    it 'with spare status do not accept throw' do
      2.times { @frame.knock_down(5) }
      expect(@frame.accept_throw?).to be false
    end

    it 'with closed status do not accept throw' do
      2.times { @frame.knock_down(4) }
      expect(@frame.accept_throw?).to be false
    end

    it 'with open status accept throw' do
      @frame.knock_down(4)
      expect(@frame.accept_throw?).to be true
    end

    it 'with strike status accept points' do
      @frame.knock_down(10)
      expect(@frame.accept_points?).to be true
    end

    it 'has spare status accept points' do
      2.times { @frame.knock_down(5) }
      expect(@frame.accept_points?).to be true
    end

    it 'has closed status do not accept points' do
      2.times { @frame.knock_down(4) }
      expect(@frame.accept_points?).to be false
    end

    it 'with strike status accept 20 points'do
      @frame.knock_down(10)
      2.times { @frame.add_points(10) }
      expect(@frame.score).to eq(30)
    end

    it 'with spare status accept 10 points'do
      2.times { @frame.knock_down(5) }
      @frame.add_points(10)
      expect(@frame.score).to eq(20)
    end
  end

  context 'last frame' do
    before :each do
      @frame = Frame.new(10)
    end

    it 'has strike status' do
      @frame.knock_down(10)
      expect(@frame.status).to eq('strike')
    end

    it 'has spare status' do
      2.times { @frame.knock_down(5) }
      expect(@frame.status).to eq('spare')
    end

    it 'has closed status' do
      2.times { @frame.knock_down(4) }
      expect(@frame.status).to eq('closed')
    end

    it 'with strike status accept throw' do
      @frame.knock_down(10)
      expect(@frame.accept_throw?).to be true
    end

    it 'with spare status accept throw' do
      2.times { @frame.knock_down(5) }
      expect(@frame.accept_throw?).to be true
    end

    it 'with closed status do not accept throw' do
      2.times { @frame.knock_down(4) }
      expect(@frame.accept_throw?).to be false
    end

    it 'with open status accept throw' do
      @frame.knock_down(4)
      expect(@frame.accept_throw?).to be true
    end

    it 'with strike status do not accept fourth throw' do
      3.times { @frame.knock_down(10) }
      expect(@frame.knock_down(10)).to eq("Can't accept throw!")
    end

    it 'with spare status do not accept fourth throw' do
      3.times { @frame.knock_down(5) }
      expect(@frame.knock_down(5)).to eq("Can't accept throw!")
    end
  end
end
