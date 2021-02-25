# frozen_string_literal: true

require 'minitest/autorun'
require 'etc'
require_relative '../lib/long_option'
require_relative '../lib/no_long_option'
require_relative '../lib/file_attribute'

class LsTest < Minitest::Test
  def test_no_option
    my_ls = NoLongOption.new(Dir.glob('*').sort)

    assert_equal `ls`.split, my_ls.output.transpose.flatten.compact!
  end

  def test_l_option
    my_ls_l = LongOption.new(Dir.glob('*').sort)
    assert_includes `ls -l`, my_ls_l.total_blocks.to_s

    my_ls_l.all_attributes.each do |line|
      assert_includes `ls -l`.gsub(' ', ''), line.gsub(' ', '')
    end
  end

  def test_a_option
    my_ls_a = NoLongOption.new(Dir.glob('*', File::FNM_DOTMATCH).sort)

    assert_equal `ls -a`.split, my_ls_a.output.transpose.flatten.compact!
  end

  def test_r_option
    my_ls_r = NoLongOption.new(Dir.glob('*').sort.reverse!)

    assert_equal `ls -r`.split, my_ls_r.output.transpose.flatten.compact!
  end

  def test_alr_option
    my_ls_alr = LongOption.new(Dir.glob('*', File::FNM_DOTMATCH).sort.reverse!)
    assert_includes `ls -alr`, my_ls_alr.total_blocks.to_s

    my_ls_alr.all_attributes.each do |line|
      assert_includes `ls -alr`.gsub(' ', ''), line.gsub(' ', '')
    end
  end
end
