# frozen_string_literal: true

require_relative 'file_attribute'

class LongOption
  attr_reader :file_attribute, :total_blocks, :all_attributes

  def initialize(filenames)
    @file_attribute = FileAttribute.new

    filenames.map do |filename|
      @file_attribute.reset_attribute
      fstat = File::Stat.new(filename)
      @file_attribute.convert_ftype(filename)
      File.ftype(filename) == 'link' ? @file_attribute.convert_permission(File.lstat(filename)) : @file_attribute.convert_permission(fstat)
      @file_attribute.fetch_number_of_links(fstat)
      @file_attribute.convert_user_name(fstat)
      @file_attribute.convert_group_name(fstat)
      File.ftype(filename) == 'link' ? @file_attribute.fetch_byte(File.readlink(filename)) : @file_attribute.fetch_byte(fstat)
      File.ftype(filename) == 'link' ? @file_attribute.fetch_update_time(File.lstat(filename)) : @file_attribute.fetch_update_time(fstat)
      @file_attribute.fetch_filename(filename)
      @file_attribute.link_to(filename) if File.ftype(filename) == 'link'
      @file_attribute.add_blocks(fstat) unless File.ftype(filename) == 'link'
      @file_attribute.join_attribute
    end
  end

  def output
    puts @file_attribute.output_total_blocks
    puts @file_attribute.all_attributes
  end
end
