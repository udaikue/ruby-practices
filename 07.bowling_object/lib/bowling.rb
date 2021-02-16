#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'game'

input = ARGV[0]
puts Game.new(input).total_score
