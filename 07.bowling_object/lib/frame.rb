# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :shots_per_frame

  def initialize(pins)
    @shots_per_frame = pins.sum { |pin| Shot.new(pin).shot }
  end
end
