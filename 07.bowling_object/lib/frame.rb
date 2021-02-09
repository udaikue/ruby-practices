# frozen_string_literal: true

class Frame
  def initialize(shot1_mark, shot2_mark, shot3_mark = nil)
    @shot1 = Shot.new(shot1_mark)
    @shot2 = Shot.new(shot2_mark)
    @shot3 = Shot.new(shot3_mark)
  end

  def score
    @shot1.score + @shot2.score + @shot3.score
  end
end
