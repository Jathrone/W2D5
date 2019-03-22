require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node = Node.new(key, prc.call(key))
    store.append(key, prc.call(key), node)
    map[key] = node
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    store.remove(node.key).append(node.key, node.val, node)
  end

  def eject!
    map.delete(store.first.key)
    store.first.remove
  end
end
