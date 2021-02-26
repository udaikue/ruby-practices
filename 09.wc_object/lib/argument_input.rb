# frozen_string_literal: true

require_relative 'lines_count'
require_relative 'words_count'
require_relative 'bytes_count'
require_relative 'total_line'

class ArgumentInput
  attr_reader :output_list, :total_lines, :total_words, :total_bytes

  def initialize(argument_files, l_option)
    @argument_files = argument_files
    @l_option = l_option['l']
    @output_list = []
    @total_lines = 0
    @total_words = 0
    @total_bytes = 0

    argument_files.each do |filename|
      lines_count = LinesCount.new(filename)
      @output_list.push(lines_count.output)
      @total_lines += lines_count.total
      unless @l_option
        words_count = WordsCount.new(filename)
        bytes_count = BytesCount.new(filename)
        @output_list.push(words_count.output, bytes_count.output)
        @total_words += words_count.total
        @total_bytes += bytes_count.total
      end
      @output_list.push(" #{filename}")
      @output_list.push("\n") if multiple_files?
    end
  end

  def output
    puts @output_list.join
    puts TotalLine.new(@total_lines, @total_words, @total_bytes, @l_option).output.join if multiple_files?
  end

  private

  def multiple_files?
    @argument_files.length != 1
  end
end
