class MaxIntSet
  attr_reader :max
  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
    if is_valid?(num)
      #do something
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    if is_valid?(num)
      #do something
      @store[num] = false
    else
      raise "Out of bounds"
    end
  end

  def include?(num)
    if is_valid?(num)
      #do something
      @store[num]
    else
      raise "Out of bounds"
    end
  end

  private

  def is_valid?(num)
    if num <= max && num >=0
      return true
    else
      false
    end
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    store[num % store.length] << num
  end

  def remove(num)
    store[num % store.length].delete(num)
  end

  def include?(num)
    store[num % store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count > num_buckets
    #put in bucket corresponding to num if bucket exists
    unless store[num % num_buckets].include?(num)
      store[num % num_buckets] << num
      @count += 1
    end
  end

  def remove(num)
    removed = store[num % num_buckets].delete(num)
    @count -= 1 if removed
  end

  def include?(num)
    store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0

    store_dup.each.with_index do |bucket, index|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
