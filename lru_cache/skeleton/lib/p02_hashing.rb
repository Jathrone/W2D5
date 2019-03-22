require "byebug"

class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      sum += el.hash * (i + 1)
    end
    sum
  end
end

class String
  def hash
    arr = self.each_char.map(&:ord)
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    dup = self.sort_by {|k,v| k}
    arr = []
    dup.each do |k, v|
      arr << [k,v]
    end
    arr.hash

  end
end
