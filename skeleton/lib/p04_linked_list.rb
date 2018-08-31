require 'byebug'
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
  end
end

class LinkedList
  attr_reader :list
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = nil
    @head.prev = @tail
    @tail.next = @head
    @tail.prev = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.prev
  end

  def last
    @tail.next
  end

  def empty?
    @head.prev == @tail
  end

  def get(key)
    current_node = first
    until current_node.val.nil?
      return current_node.val if current_node.key == key
      current_node = current_node.prev
    end
  end

  def include?(key)
    current_node = first
    until current_node.val.nil?
      return true if current_node.key == key
      current_node = current_node.prev
    end
    false
  end

  def append(key, val)
    node = Node.new(key,val)
    if @head.prev == @tail
      @head.prev = node
      node.next = @head
    else
      node.next = @tail.next
      @tail.next.prev = node
    end
    node.prev = @tail
    @tail.next = node
  end

  def update(key, val)
    # debugger
    updated = false
    current_node = last
    until current_node.val.nil?
      if current_node.key == key
        current_node.val = val
        updated = true
        break
      end
      current_node = current_node.prev
    end
    # append(key, val) unless updated
  end

  def remove(key)
    # debugger
    current_node = first
    until current_node.val.nil?
      if current_node.key == key
        new_prev = current_node.next
        new_next = current_node.prev
        new_prev.next = new_next
        new_next.prev = new_prev
        current_node.val = nil
        break
      else
        current_node = current_node.prev
      end
    end
  end

  def each
    current_node = first
    until current_node.val.nil?
      yield current_node
      current_node = current_node.prev
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
