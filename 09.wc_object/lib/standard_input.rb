# frozen_string_literal: true

class StandardInput
  attr_reader :stdin_lines, :stdin_words, :stdin_bytes

  def initialize(readlines)
    @stdin_lines = 0
    @stdin_words = 0
    @stdin_bytes = 0

    readlines.each do |readline|
      count(readline)
    end
  end

  def output
    puts @stdin_lines.to_s.rjust(8) + @stdin_words.to_s.rjust(8) + @stdin_bytes.to_s.rjust(8)
  end

  private

  def count(line)
    @stdin_lines += 1
    @stdin_words += line.scan(/ +/).size - line.scan(/^\x20+|\x20+$/).size + 1
    @stdin_bytes += line.bytesize
  end
end
