# frozen_string_literal: true

require 'optparse'
require_relative 'standard_input'
require_relative 'argument_input'

l_option = ARGV.getopts('l')
input = ARGV.empty? ? StandardInput.new(readlines) : ArgumentInput.new(ARGV, l_option)

input.output
