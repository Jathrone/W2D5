class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false) 
  end

  def insert(num)
    raise "Out of bounds" unless (0...store.length).include?(num)
    store[num] = true 
  end
  
  def remove(num)
    raise "Out of bounds" unless (0...store.length).include?(num)
    store[num] = false
  end
  
  def include?(num)
    raise "Out of bounds" unless (0...store.length).include?(num)
    store[num]
  end

  private
  attr_reader :store
  def is_valid?(num)

  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !self.include?(num) 
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  # self.store[num % num_buckets].include? 
  def include?(num)
    self[num].include?(num)
  end

  private
  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end
  
  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  
  ALPHA = 2
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(num)
    if num_buckets == @count 
      resize!
    end

    if !self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end
  
  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end
  
  def include?(num)
    if self[num].include?(num) then true else false end 
  end
  
  private
  attr_reader :store 
  
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store_temp = @store.dup 
    @store = Array.new((num_buckets * ALPHA).ceil) {Array.new}
    @count = 0
    @store_temp.each do |bucket|
      bucket.each do |num|
        self.insert(num)
      end
    end
  end
end
