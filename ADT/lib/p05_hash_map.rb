require_relative 'p04_linked_list'
require_relative 'p02_hashing'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    # @store.each do |link|
    #   return true if link.include?(key.hash)
    # end
    # false
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    if include?(key)
      @store[key.hash % num_buckets].update(key, val)
    else
      if @count <= num_buckets
        @store[key.hash % num_buckets].append(key, val)
        @count += 1
      else
        resize!
        @store[key.hash % num_buckets].append(key, val)
        @count += 1
      end
    end
  end

  def get(key)
    if include?(key)
      return @store[key.hash % num_buckets].get(key)
      # @store is the array of linked chains
      # linked chain is the chained nodes
    else
      return nil
    end
  end

  def delete(key)
    if include?(key)
      @store[key.hash % num_buckets].remove(key)
      @count -= 1
    else
      nil
    end
  end

  def each(&prc)
    @store.each do |ll|
      ll.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    store_dup.each.with_index do |ll, index|
      ll.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`

  end
end
