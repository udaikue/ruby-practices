# frozen_string_literal: true

require_relative 'shot'

class Bonus
  def initialize(input)
    input_ary = input.map do |mark|
      shot = Shot.new(mark)
      shot.mark
    end

    @score_ary = input_ary.each_slice(2).to_a
  end

  def strike_and_spare_bonus
    @strike_and_spare_bonus = 0
    @score_ary.each_with_index do |frame, i|
      next if i.zero?
      break if i == 10

      @strike_and_spare_bonus += frame.sum if strike(i)
      @strike_and_spare_bonus += frame[0] if spare(i)
    end
    @strike_and_spare_bonus
  end

  def double_strike_bonus
    @double_strike_bonus = 0
    @score_ary.each_with_index do |frame, i|
      next if i <= 1
      break if i == 11

      @double_strike_bonus += frame[0] if double_strike(i)
    end
    @double_strike_bonus
  end

  private

  def strike(index)
    @score_ary[index - 1][0] == 10
  end

  def spare(index)
    @score_ary[index - 1].sum == 10 && @score_ary[index - 1][0] != 10
  end

  def double_strike(index)
    @score_ary[index - 2][0] == 10 && @score_ary[index - 1][0] == 10
  end
end
