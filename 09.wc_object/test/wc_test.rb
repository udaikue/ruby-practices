# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/standard_input'
require_relative '../lib/argument_input'
require_relative '../lib/lines_count'
require_relative '../lib/words_count'
require_relative '../lib/bytes_count'
require_relative '../lib/total_line'

class WcTest < Minitest::Test
  def test_one_argument
    my_wc = ArgumentInput.new(['test1.rb'], { 'l' => false })

    assert_includes `wc test1.rb`, my_wc.output_list.join
  end

  def test_multiple_argument
    my_wc = ArgumentInput.new(['test1.rb', 'test2.rb', 'test3.rb'], { 'l' => false })
    my_total = TotalLine.new(my_wc.total_lines, my_wc.total_words, my_wc.total_bytes, false)

    assert_includes `wc test1.rb test2.rb test3.rb`, my_wc.output_list.join
    assert_includes `wc test1.rb test2.rb test3.rb`, my_total.output_total.join
  end

  def test_l_option_one
    my_wc = ArgumentInput.new(['test1.rb'], { 'l' => true })

    assert_includes `wc -l test1.rb`, my_wc.output_list.join
  end

  def test_l_option_multiple
    my_wc = ArgumentInput.new(['test1.rb', 'test2.rb', 'test3.rb'], { 'l' => true })
    my_total = TotalLine.new(my_wc.total_lines, my_wc.total_words, my_wc.total_bytes, true)

    assert_includes `wc -l test1.rb test2.rb test3.rb`, my_wc.output_list.join
    assert_includes `wc -l test1.rb test2.rb test3.rb`, my_total.output_total.join
  end

  def test_standard_input
    readlines = `ls -l`.split("\n")
    my_wc = StandardInput.new(readlines)
    add_bytes = readlines.length * "\n".bytesize

    assert_includes `ls -l | wc`, my_wc.stdin_lines.to_s
    assert_includes `ls -l | wc`, my_wc.stdin_words.to_s
    assert_includes `ls -l | wc`, (my_wc.stdin_bytes + add_bytes).to_s
  end
end
