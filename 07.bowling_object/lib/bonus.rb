# frozen_string_literal: true

class Bonus
  def initialize(input_ary)
    @input_ary = input_ary.map do |shot|
      @shot = Shot.new(shot)
      @shot.score
    end

    @score_ary = []
    @input_ary.each_slice(2) do |frame|
      @score_ary << frame
    end
  end

  def calc_strike_and_spare_bonus
    @strike_and_spare_bonus = 0
    @score_ary.each_with_index do |frame, i|
      @strike_and_spare_bonus += (@score_ary[i - 1][0] != 10 ? frame[0] : frame.sum) if @score_ary[i - 1].sum == 10 && ((i != 0) && (i != 10) && (i != 11))
    end
    @strike_and_spare_bonus
  end

  def calc_double_strike_bonus
    @double_strike_bonus = 0
    @score_ary.each_with_index do |frame, i|
      @double_strike_bonus += frame[0] if (@score_ary[i - 2][0] == 10 && @score_ary[i - 1][0] == 10) && ((i != 0) && (i != 1) && (i != 11))
    end
    @double_strike_bonus
  end

  def score
    calc_strike_and_spare_bonus + calc_double_strike_bonus
  end
end
