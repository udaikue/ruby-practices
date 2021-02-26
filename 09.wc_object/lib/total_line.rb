# frozen_string_literal: true

class TotalLine
  attr_reader :output_total

  def initialize(total_lines, total_words, total_bytes, l_option)
    @output_total = []
    @output_total.push(total_lines.to_s.rjust(8))
    @output_total.push(total_words.to_s.rjust(8), total_bytes.to_s.rjust(8)) unless l_option
  end

  def output
    @output_total.push(' total')
  end
end
