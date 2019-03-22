class HashSet
  attr_reader :count

  ALPHA = 2
  
  def initialize(num_buckets = 8)
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
    store[num.hash % num_buckets]
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
