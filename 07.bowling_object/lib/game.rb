# frozen_string_literal: true

require_relative 'frame'
require_relative 'bonus'

class Game
  def initialize(input)
    @input = input.gsub('X', 'X0').chars
    @pins_all_frame =
      @input.each_slice(2).sum do |shots|
        Frame.new(shots).pins_per_frame
      end
    @bonus = Bonus.new(@input)
  end

  def total_score
    @pins_all_frame + @bonus.total_bonus
  end
end
