# frozen_string_literal: true

require_relative 'shot'

class Bonus
  def initialize(pins)
    shots_ary = pins.map { |pin| Shot.new(pin).shot }
    @frame_ary = shots_ary.each_slice(2).to_a
  end

  def total_bonus
    strike_and_spare_bonus + double_strike_bonus
  end

  private

  def strike_and_spare_bonus
    strike_and_spare_bonus = 0
    @frame_ary.each_with_index do |frame, i|
      next if i.zero?
      break if i == 10

      strike_and_spare_bonus += frame.sum if strike?(i)
      strike_and_spare_bonus += frame[0] if spare?(i)
    end
    strike_and_spare_bonus
  end

  def double_strike_bonus
    double_strike_bonus = 0
    @frame_ary.each_with_index do |frame, i|
      next if i <= 1
      break if i == 11

      double_strike_bonus += frame[0] if double_strike?(i)
    end
    double_strike_bonus
  end

  def strike?(index)
    @frame_ary[index - 1][0] == 10
  end

  def spare?(index)
    @frame_ary[index - 1].sum == 10 && @frame_ary[index - 1][0] != 10
  end

  def double_strike?(index)
    @frame_ary[index - 2][0] == 10 && @frame_ary[index - 1][0] == 10
  end
end
