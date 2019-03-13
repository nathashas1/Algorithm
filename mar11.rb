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
