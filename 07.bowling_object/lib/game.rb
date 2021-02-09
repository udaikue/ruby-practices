# frozen_string_literal: true

class Game
  def initialize(input)
    @input = input.gsub('X', 'X0').chars
    @frame1 = Frame.new(@input[0], @input[1])
    @frame2 = Frame.new(@input[2], @input[3])
    @frame3 = Frame.new(@input[4], @input[5])
    @frame4 = Frame.new(@input[6], @input[7])
    @frame5 = Frame.new(@input[8], @input[9])
    @frame6 = Frame.new(@input[10], @input[11])
    @frame7 = Frame.new(@input[12], @input[13])
    @frame8 = Frame.new(@input[14], @input[15])
    @frame9 = Frame.new(@input[16], @input[17])
    @frame10 = Frame.new(@input[18], @input[19])
    @frame11 = Frame.new(@input[20], @input[21])
    @frame12 = Frame.new(@input[22], @input[23], @input[24])
    @bonus = Bonus.new(@input)
  end

  def score
    @frame1.score + @frame2.score + @frame3.score + @frame4.score + @frame5.score + @frame6.score +
      @frame7.score + @frame8.score + @frame9.score + @frame10.score + @frame11.score + @frame12.score + @bonus.score
  end
end
