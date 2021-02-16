# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :pins_per_frame

  def initialize(shots)
    @pins_per_frame =
      shots.sum do |mark|
        Shot.new(mark).pins
      end
  end
end
