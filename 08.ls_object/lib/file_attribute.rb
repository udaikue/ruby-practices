# frozen_string_literal: true

require 'etc'

class FileAttribute
  attr_reader :all_attributes

  def initialize
    @total_blocks = 0
    @all_attributes = []
  end

  def add_blocks(fstat)
    @total_blocks += fstat.blocks
  end

  def convert_ftype(file_name)
    @attributes <<
      case File.ftype(file_name)
      when 'directory'
        'd'
      when 'file'
        '-'
      when 'link'
        'l'
      else
        ' '
      end
  end

  def convert_permission(fstat)
    file_mode = fstat.mode
    format = format('0%<file_mode>o', file_mode: file_mode)
    permission = format.slice(-3..-1)
    @attributes << permission.gsub(
      /7|6|5|4|3|2|1/,
      '7' => 'rwx',
      '6' => 'rw-',
      '5' => 'r-x',
      '4' => 'r--',
      '3' => '-wx',
      '2' => '-w-',
      '1' => '--x'
    )
  end

  def fetch_number_of_links(fstat)
    @attributes.push " #{fstat.nlink.to_s.rjust(2)}"
  end

  def convert_user_name(fstat)
    @attributes.push " #{Etc.getpwuid(fstat.uid).name}"
  end

  def convert_group_name(fstat)
    @attributes.push " #{Etc.getgrgid(fstat.gid).name}"
  end

  def fetch_byte(fstat)
    @attributes.push(fstat.size.to_s.rjust(7))
  end

  def fetch_update_time(fstat)
    @attributes.push " #{fstat.mtime.strftime('%-m').to_s.rjust(2)} #{fstat.mtime.strftime('%e').to_s.rjust(2)} #{fstat.mtime.strftime('%R')}"
  end

  def fetch_filename(file_name)
    @attributes.push " #{file_name}"
  end

  def link_to(file_name)
    @attributes << " -> #{File.readlink(file_name)}"
  end

  def output_total_blocks
    "total #{@total_blocks}"
  end

  def join_attribute
    @all_attributes << @attributes.join
  end

  def reset_attribute
    @attributes = []
  end
end
