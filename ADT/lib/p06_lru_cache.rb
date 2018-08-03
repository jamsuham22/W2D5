require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'


class LRUCache
  attr_reader :count
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
    return_val = nil
    if @map.include?(key)
      update_node!(@map[key])
      return_val = @map[key].val
    else
      val = calc!(key)
      # debugger
      @store.append(key, val)
      @map[key] = @store.last
      return_val = val
    end

    eject! if count > @max

    return_val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    node.remove
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def eject!
    least_used_node = @store.first
    least_used_node.remove

    @map.delete(least_used_node.key)
  end
end
