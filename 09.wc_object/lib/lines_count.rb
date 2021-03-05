# frozen_string_literal: true

class LinesCount
  def initialize(filename)
    @number_of_lines = File.open(filename).read.count("\n")
  end

  def output
    @number_of_lines.to_s.rjust(8)
  end

  def total
    @number_of_lines
  end
end
