class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      if el.is_a?(Integer)
        result += (el ^ idx)
      # elsif el.is_a?(String)
      #   alphabet = ('a'..'z').to_a
      #   el.chars.each do |char|
      #     result += alphabet.find_index(char)
      #   end
      #   result += idx
      # elsif el.is_a?(Hash)
      end
    end
    result.hash
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |char, idx|
      result += char.ord ^ idx
    end
    result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |k, v|
      result += k.to_s.ord ^ v.ord
      result += k.to_s.ord << v.ord
    end
    result.hash
  end
end
