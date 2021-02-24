# frozen_string_literal: true

require_relative 'file_attribute'

class LongOption
  attr_reader :total_blocks, :all_attributes

  def initialize(filenames)
    @total_blocks = 0
    @all_attributes = []

    filenames.map do |filename|
      @file_attribute = FileAttribute.new(filename)
      @total_blocks += @file_attribute.blocks
      @all_attributes << @file_attribute.fetch_file_attribute(filename)
    end
  end

  def output
    puts "total #{@total_blocks}"
    puts @all_attributes
  end
end
