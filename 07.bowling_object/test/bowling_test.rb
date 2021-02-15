# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative '../lib/bonus'
require_relative '../lib/shot'

class BowlingTest < Minitest::Test
  def test_perfect
    game = Game.new('XXXXXXXXXXXX')
    assert_equal 300, game.score
  end

  def test_frame10_all_strike
    game = Game.new('6390038273X9180XXXX')
    assert_equal 164, game.score
  end

  def test_frame10_strike
    game = Game.new('552082376490XX32X36')
    assert_equal 133, game.score
  end

  def test_frame10_spare
    game = Game.new('6390038273X9180X645')
    assert_equal 139, game.score
  end

  def test_not_special
    game = Game.new('23558190X4263153730')
    assert_equal 94, game.score
  end
end
