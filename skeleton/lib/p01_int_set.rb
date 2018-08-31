require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if num > @store.length || num < 0
      raise "Out of bounds"
    end
    @store[num] = true
  end

  def remove(num)
    if num > @store.length || num < 0
      raise "Cannot remove you hooligna"
    end
    @store[num] = false
  end

  def include?(num)
    if num > @store.length || num < 0
      raise "Cannot remove you hooligna"
    end
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if include?(num)
    elsif @count == num_buckets
      resize!
      self[num] << num
      @count += 1
    else
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num) == false
    else
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
   self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets * 2) { Array.new }
    @store.each do |el|
      el.each do |nums|
        new_index = nums % (num_buckets * 2)
        new_arr[new_index] << nums
      end
    end
    @store = new_arr
  end
end
