require_relative 'p04_linked_list'

class HashMap

  ALPHA = 2 

  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key) 
      bucket(key).update(key,val) 
    else
      if num_buckets == self.count
        resize!
      end
      bucket(key).append(key,val)  
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key) 
      bucket(key).remove(key)
      self.count -= 1
    end 
  end

  def each
    @store.each do |link|
      link.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  
  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store.dup
    @store = Array.new(num_buckets * ALPHA) {LinkedList.new}
    self.count = 0
    temp_store.each do |link|
      link.each do |node|
        self[node.key] = node.val
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
