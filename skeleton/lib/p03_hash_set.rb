class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if include?(key)
    elsif @count == num_buckets
      resize!
      self[key] << key
      @count += 1
    else
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key) == false
    else
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
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
