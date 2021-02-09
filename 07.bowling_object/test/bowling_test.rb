# frozen_string_literal: true

require 'minitest/autorun'
require './lib/bowling'

class BowlingTest < Minitest::Test
  def test_bowling
    game = Game.new('23558190X4263153730')
    assert_equal 94, game.score
    game = Game.new('XXXXXXXXXXXX')
    assert_equal 300, game.score
    game = Game.new('6390038273X9180X645')
    assert_equal 139, game.score
    game = Game.new('6390038273X9180XXXX')
    assert_equal 164, game.score
    game = Game.new('552082376490XX32X36')
    assert_equal 133, game.score
  end
end
