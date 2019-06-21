require "byebug"

class MaxIntSet

  attr_accessor :store, :max

  def initialize(max)
      @max = max
      @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
       validate!(num)
    else
      raise "Out of bounds" 
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num <= @max && num > 0
  end

  def validate!(num)
    @store[num] = true
  end
end


class IntSet

  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    # debugger
  end

  def insert(num)
    @store[num % @store.length] << num
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].include?(num)
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
    resize! if count + 1 > @store.size
    unless include?(num)
      @store[num % @store.size] << num 
      @count += 1
    end
  end

  def remove(num)
    unless !include?(num)
      @store[num % @store.length].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(num_buckets*2) { Array.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |n|
        insert(n)
      end
    end
  end
end
