# frozen_string_literal: true

require 'optparse'
require_relative 'long_option'
require_relative 'no_long_option'

class LsCommand
  def initialize
    options = ARGV.getopts('alr')
    filenames =
      options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    filenames.reverse! if options['r']
    @long_option =
      options['l'] ? LongOption.new(filenames) : NoLongOption.new(filenames)
  end

  def output
    @long_option.output
  end
end
