# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shots)
    @pins_per_frame = 0
    shots.each do |mark|
      shot = Shot.new(mark)
      @pins_per_frame += shot.mark
    end
  end

  def score
    @pins_per_frame
  end
end
