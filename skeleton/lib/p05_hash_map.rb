require 'byebug'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      if @count == @store.length
        resize!
      end
      @store[bucket(key)].append(key, val)
      @count +=1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    @store.each { |el| el.each { |node| yield node.key, node.val } }
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
    new_ll = Array.new(num_buckets * 2) { LinkedList.new }
    self.each do |k, v|
      # debugger
      new_index = k.hash % (num_buckets * 2)
      new_ll[new_index].append(k, v)
    end
    @store = new_ll
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
