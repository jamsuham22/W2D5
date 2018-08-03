require_relative "p01_int_set"
require_relative "p02_hashing"
require 'byebug'
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    # @store = Array.new(num_buckets) { Array.new }
    @store = ResizingIntSet.new(8)
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      @store.insert(key.hash)
      @count += 1
      resize!
    else
      @store.insert(key.hash)
      @count += 1
    end
  end

  def include?(key)
    @store.include?(key.hash)
  end

  def remove(key)
    @store.remove(key.hash)
    @count = @store.count
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.store.length
  end

  def resize!
    # @store.resize!
    # @count = @store.count
  end
end
