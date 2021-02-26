# frozen_string_literal: true

class BytesCount
  def initialize(filename)
    @stat = File.stat(filename)
  end

  def output
    @stat.size.to_s.rjust(8)
  end

  def total
    @stat.size
  end
end
