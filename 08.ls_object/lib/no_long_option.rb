# frozen_string_literal: true

class NoLongOption
  def initialize(filenames)
    @sliced_filenames = []
    row = (filenames.length / 3.0).ceil
    filenames.each_slice(row) do |filename|
      @sliced_filenames << filename
    end
  end

  def output
    output_filenames = @sliced_filenames[0].zip(*@sliced_filenames[1..-1])
    output_filenames.each do |rows|
      rows.each do |column|
        print format('%+-24<column>s', column: column)
      end
      print "\n"
    end
  end
end
