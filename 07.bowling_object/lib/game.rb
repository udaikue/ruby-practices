# frozen_string_literal: true

require_relative 'frame'
require_relative 'bonus'

class Game
  def initialize(input)
    @input = input.gsub('X', 'X0').chars
    @frame_sum = 0
    @input.each_slice(2).map do |frame|
      @frame = Frame.new(frame)
      @frame_sum += @frame.score
    end

    @bonus = Bonus.new(@input)
  end

  def score
    @frame_sum + @bonus.score
  end
end
