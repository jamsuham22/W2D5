class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = -1
    self.each_with_index do |el, idx|
      sum += el.hash * (idx + 1)
    end
    return sum
  end
end

class String
  def hash
    hashed = 0
    self.each_byte.with_index do |c, idx|
      hashed += c.hash * (idx + 1)
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.values.sort.hash
  end
end
