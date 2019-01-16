class BinaryMinheap

  def initialize(&prc)
    prc ||= Proc.new { |a,b| a<=>b }
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def push
    @store.push(val)
    BinaryMinheap.heapify_up(@store, @store.length - 1, @store.length, &@prc)
  end

  def self.heapify_up(array, child_idx, len, &prc)
    prc ||= Proc.new { |a,b| a<=>b }
    return array if child_idx == 0
    parent_idx = (child_idx-1)/2
    parent_val, child_val = array[parent_idx], array[child_idx]
    if prc.call(child_val, parent_val) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end

  def extract
    @store[0], @store[@store.length-1] = @store[@store.length-1], @store[0]
    val = @store.pop
    BinaryMinheap.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def self.child_indices(parent_idx, length)
    indices = [2*parent_idx+1, 2*parent_idx+2]
    indices.pop if indices.last >= length
    indices.pop if indices.last >= length
    indices
  end

  def self.heapify_down(array, parent_idx, len, &prc)
    prc ||= Proc.new { |a,b| a<=>b }
    idxs = self.child_indices(parent_idx, length)
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
