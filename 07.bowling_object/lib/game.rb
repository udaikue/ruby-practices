# frozen_string_literal: true

require_relative 'frame'
require_relative 'bonus'

class Game
  def initialize(input)
    @input = input.gsub('X', 'X0').chars
    @pins_all_frame = 0
    @input.each_slice(2).each do |shots|
      frame = Frame.new(shots)
      @pins_all_frame += frame.score
    end
    @bonus = Bonus.new(@input)
  end

  def score
    @pins_all_frame + @bonus.strike_and_spare_bonus + @bonus.double_strike_bonus
  end
end
