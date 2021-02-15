# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shots)
    @shot_sum = 0
    shots.map do |shot|
      @shot = Shot.new(shot)
      @shot_sum += @shot.score
    end
  end

  def score
    @shot_sum
  end
end
