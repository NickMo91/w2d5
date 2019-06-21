require "byebug"

class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.inject { |acc, ele|  acc.to_s + ele.to_s }.to_i.hash
  end
end

class String
  def hash
    array = self.split("").map(&:ord)
    array.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0 if self.empty? 
    # debugger
    array = []
    self.each do |k, v|
      array.push(k.to_s, v.to_s)
    end
    array.map(&:ord).sort.hash
  end
end
