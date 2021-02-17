# frozen_string_literal: true

class Shot
  attr_reader :shot

  def initialize(pin)
    @shot = pin == 'X' ? 10 : pin.to_i
  end
end
