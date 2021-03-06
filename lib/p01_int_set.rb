class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.is_a?(Fixnum) && num.between?(0, @store.size)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    index = num % @num_buckets
    @store[index] << num
  end

  def remove(num)
    index = num % @num_buckets
    num_index = @store[index].find_index(num)
    @store[index].delete_at(num_index)
  end

  def include?(num)
    index = num % @num_buckets
    @store[index].include?(num)
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
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count >= num_buckets
    index = num % num_buckets
    @store[index] << num
  end

  def remove(num)
    index = num % num_buckets
    num_index = @store[index].find_index(num)
    @count -= 1 if num_index
    @store[index].delete_at(num_index)
  end

  def include?(num)
    index = num % num_buckets
    @store[index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times { @store << [] }

    @store.each do |bucket|
      bucket.each_with_index do |num, old_idx|
        new_index = num % num_buckets
        @store[new_index] << num
        bucket.delete_at(old_idx)
      end
    end
  end
end
