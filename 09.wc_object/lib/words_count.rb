# frozen_string_literal: true

class WordsCount
  def initialize(filename)
    @number_of_words = 0
    File.open(filename) do |file|
      file.each_line do |line|
        next if line == "\n"

        @number_of_words += line.scan(/ +/).size - line.scan(/^\x20+|\x20+$/).size + 1
      end
    end
  end

  def output
    @number_of_words.to_s.rjust(8)
  end

  def total
    @number_of_words
  end
end
