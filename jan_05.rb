class BSTNode
  attr_reader :value
  attr_accessor :right, :left

  def initialize(val)
    @value = value
    @right = nil
    @left = nil
  end
end

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(val)
    @root = insert_into_tree(@root, val)
  end

  def delete(val)
    @root = delete_from_tree(@root, val)
  end

  def insert_into_tree(tree_node, val)
    return BSTNode.new(val) if tree_node.nil?
    if value <= tree_node.value
      tree_node.left = insert_into_tree(tree_node.left, val)
    else
      tree_node.right = insert_into_tree(tree_node.right, val)
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
    elsif node.left && node.right.nil?
      node = node.left
    elsif node.right && node.left.nil?
      node = node.right
    else
      node = replace_parent(node)
    end
    tree_node
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
end


def maximum(node = @root)
  if node.right
    max_node = maximum(node.right)
  else
    max_node = node
  end
  max_node
end

def in_order_traversal(tree_node = @root, arr = [])
  if tree_node.left
    in_order_traversal(tree_node.left, arr)
  end
  arr.push(tree_node.value)
  if tree_node.right
    in_order_traversal(tree_node.right, arr)
  end
  arr
end

end
