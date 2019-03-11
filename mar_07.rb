class BinaryMinheap
  attr_reader :store, :prc
  def initialize(&prc)
    prc ||= Proc.new { |a,b| a<=>b }
    @store = []
    @prc = prc
  end

  def push(val)
    @store.push(val)
    BinaryMinheap.heapify_up(@store, @store.length-1, @store.length, &@prc)
  end

  def self.heapify_up(array, child_idx, len, &prc)
    return array if child_idx == 0
    parent_idx = (child_idx-1)/2
    parent_val = array[parent_idx]
    child_val = array[child_idx]
    if prc.call(child_val, parent_val) < 0
      array[parent_idx], array[child_idx] =   array[child_idx], array[parent_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end

  def extract
    @store[0], @store[@store.length-1] = @store[@store.length-1],@store[0]
    val = @store.pop
    BinaryMinheap.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def self.child_indices(parent_idx, len)
    indices = [2*parent_idx+1, 2*parent_idx+2]
    indices.pop if indices.last >= len
    indices.pop if indices.last >= len
    indices
  end

  def self.heapify_down(array, parent_idx, len, &prc)
    idxs = self.child_indices(parent_idx, len)
    return array if idxs.empty?
    if idxs.length == 1
      smallest_idx = idxs[0]
    else
      if prc.call(array[idxs[0]], array[idxs[1]]) < 0
        smallest_idx = idxs[0]
      else
        smallest_idx = idxs[1]
      end
    end
    parent_val = array[parent_idx]
    smallest_child_val = array[smallest_idx]
    if prc.call(smallest_child_val, parent_val) < 0
      array[smallest_idx], array[parent_idx] = array[parent_idx], array[smallest_idx]
      self.heapify_down(array, smallest_idx, len, &prc)
    end
    array
  end
end

class Array
  def merge_sort
    return self if self.length  == 1
    mid  = self.length/2
    left  = self[0...mid].merge_sort
    right = self[mid..-1].merge_sort
    merge(left, right)
  end

  def merge(left, right, &prc)
    prc ||= Proc.new { |a,b| a<=>b }
    result = []
    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) < 0
        result << left.shift
      else
        result << right.shift
      end
    end
    result+left+right
    end
  end

  def self.heapify_down(array, parent_idx, len, &prc)
    prc ||= Proc.new{ |a,b| a<=>b }
    idxs = self.child_indices(parent_idx, len)
    return array if idxs.empty?
    if idxs.length == 1
      smallest_idx = idxs[0]
    else
      if prc.call(array[idxs[0]], array[idxs[1]]) < 0
        smallest_idx = idxs[0]
      else
        smallest_idx = idxs[1]
      end
    end
    smallest_child_val = array[smallest_idx]
    parent_val = array[parent_idx]
    if prc.call(smallest_child_val, parent_val) < 0
      array[smallest_idx], array[parent_idx] = array[parent_idx], array[smallest_idx]
      self.heapify_down(array, smallest_idx, len, &prc)
    end
    array
  end
end
