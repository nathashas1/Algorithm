class BinaryMinheap
attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new{|a,b| a<=>b}
    @prc = prc
    @store= []
  end

  def count
    @store.length
  end

  def push(val)
    @store.push(val)
    BinaryMinheap.heapify_up(@store, @store.length-1,@store.length, &@prc)
  end

  def self.heapify_up(array, child_idx, len, &prc)
    prc ||= Proc.new{|a,b| a<=>b}
    return array if child_idx == 0
    parent_idx = (child_idx-1)/2
    parent_val, child_val = [array[parent_idx], array[child_idx]]
    if prc.call(child_val, parent_val) < 0
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, array.length,&@prc)
    end
    array
  end

  def extract
    @store[0], @store[@store.length-1] = @store[@store.length - 1], @store[0]
    val = @store.pop
    BinaryMinheap.heapify_down(@store, 0, @store.length, &prc)
    val
  end

  def self.child_indices(parent_idx)
    indices =
  end

  def self.heapify_down(array, parent_idx, len, )
    prc ||= Proc.new{ |a,b| a<=>b }
    idxs = self.child_indices(parent_idx)
  end
end
