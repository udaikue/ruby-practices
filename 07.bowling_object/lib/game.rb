# frozen_string_literal: true

require_relative 'frame'
require_relative 'bonus'

class Game
  def initialize(input)
    @pins = input.gsub('X', 'X0').chars
    @shots_all_frame =
      @pins.each_slice(2).sum do |pins|
        Frame.new(pins).shots_per_frame
      end
    @bonus = Bonus.new(@pins)
  end

  def score
    @shots_all_frame + @bonus.total_bonus
  end
end
