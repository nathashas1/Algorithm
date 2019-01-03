class BinaryMinheap
  def initialize(&prc)
    @store = []
    prc ||= Proc.new{|a,b| a<=>b }
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
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
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
    smallest_val = array[smallest_idx]
    parent_val = array[parent_idx]
    if prc.call(smallest_val, parent_val) < 0
      array[smallest_idx], array[parent_idx] = array[parent_idx], array[smallest_idx]
      self.heapify_down(array, smallest_idx, len, &prc)
    end
    array
  end

end


class Array
  def merge_sort
    return self if self.length == 1
    mid = self.length/2
    left = self[0...mid].merge_sort
    right = self[mid..-1].merge_sort
    merge(left, right)
  end

  def merge(left, right, &prc)
    prc ||= Proc.new{ |a,b| a<=>b}
    result = []
    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) < 0
        result << left.shift
      else
        result << right.shift
      end
    end
    result + left + right
  end
 end


 class BSTNode
   attr_reader :value
   attr_accessor :left, :right

   def initialize(value)
     @value = value
     @left = nil
     @right = nil
   end
 end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_into_tree(@root, value)
  end

  def delete(value)
    @root = delete_from_tree(@root, value)
  end

  def maximum(tree_node = @root)
    if tree_node.right
      maximum_node = maximum(tree_node.right)
    else
      maximum_node = tree_node
    end
    maximum_node
  end


  def insert_into_tree(tree_node, value)
    return BSTNode.new(value) if tree_node.nil?
    if value <= tree_node.value
      tree_node.left = insert_into_tree(tree_node.left, value)
    else
      tree_node.right = insert_into_tree(tree_node.right, value)
    end
    tree_node
  end

  def delete_from_tree(tree_node, value)
    if value == tree_node.value
      tree_node = remove(tree_node)
    elsif value < tree_node.value
        tree_node.left = delete_from_tree(tree_node.left, value)
    else
        tree_node.right = delete_from_tree(tree_node.right, value)
    end
    tree_node
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      node = nil
    elsif node.left.nil? && node.right
      node = node.right
    elsif node.left && node.right.nil?
      node = node.left
    else
      node = replace_parent(node)
    end
    node
  end

  def replace_parent(node)
    replacement_node = maximum(node.left)
    if replacement_node.left
      promote_child(node.left)
    end
    replacement_node.left = node.left
    replacement_node.right = node.right
    replacement_node
  end

  def promote_child(tree_node)
    if tree_node.right
      parent = tree_node
      child = tree_node.right
    while child.right
      parent = child
      child = child.right
    end
    parent.right = child.left
  end
  else
    tree_node = tree_node.left
  end

end
