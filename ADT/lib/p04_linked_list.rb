class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    next_node = @next
    prev_node = @prev
    prev_node.next = next_node
    next_node.prev = prev_node

  end
end

class LinkedList

  include Enumerable

attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil unless include?(key)

    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    return false
  end

  def append(key, val)
    node = Node.new(key, val)
    prev_node = @tail.prev
    prev_node.next = node
    node.prev = prev_node

    @tail.prev = node
    node.next = @tail
  end

  def update(key, val)
    return nil unless include?(key)

    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    return nil unless include?(key)

    self.each do |node|
      node.remove if node.key == key
    end
  end

  def each(&prc)
    cur_node = @head.next

    until cur_node == @tail
      prc.call(cur_node)
      cur_node = cur_node.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
