#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'bonus'
require_relative 'game'

input = ARGV[0]
game = Game.new(input)
puts game.score
