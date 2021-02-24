# frozen_string_literal: true

require 'etc'

class FileAttribute
  def initialize(filename)
    @filename = filename
    @attributes = []
    @fstat = File::Stat.new(filename)
  end

  def blocks
    link_file? ? 0 : @fstat.blocks
  end

  def fetch_file_attribute(filename)
    @attributes <<
      case File.ftype(filename)
      when 'directory'
        'd'
      when 'file'
        '-'
      when 'link'
        'l'
      else
        ' '
      end

    file_mode =
      link_file? ? File.lstat(filename).mode : @fstat.mode
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

    @attributes.push " #{@fstat.nlink.to_s.rjust(2)}  #{Etc.getpwuid(@fstat.uid).name}  #{Etc.getgrgid(@fstat.gid).name}"

    @fstat = File.readlink(filename) if link_file?
    @attributes.push(@fstat.size.to_s.rjust(7))

    @fstat = File.lstat(filename) if link_file?
    @attributes.push " #{@fstat.mtime.strftime('%-m').to_s.rjust(2)} #{@fstat.mtime.strftime('%e').to_s.rjust(2)} #{@fstat.mtime.strftime('%R')}"

    @attributes.push " #{filename}"
    @attributes << " -> #{File.readlink(filename)}" if link_file?
    @attributes.join
  end

  private

  def link_file?
    File.ftype(@filename) == 'link'
  end
end
