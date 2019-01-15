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
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_into_tree(@root,value)
  end

  def delete(value)
    @root = delete_from_tree(@root, value)
  end

  def insert_into_tree(tree_node, value)
    return BSTNode.new if tree_node.nil?
    if value <= tree_node.value
      tree_node.left = insert_into_tree(tree_node.left, value)
    elsif value > tree_node.value
      tree_node.right = insert_into_tree(tree_node.right, value)
    end
    tree_node
  end

  def delete_from_tree(tree_node, value)
    if value == tree_node.value
      tree_node = remove(tree_node)
    elsif value <= tree_node.value
      tree_node.left = delete_from_tree(tree_node.left, value)
    else value > tree_node.value
      tree_node.right = delete_from_tree(tree_node.right, value)
    end
      tree_node
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      node = nil
    elsif node.left && node.right.nil?
      node = node.left
    elsif node.left.nil? && node.right
      node = node.right
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
  end

  def depth(tree_node = @root)
      if tree_node.nil?
        return -1;
      else
        left_depth = depth(tree_node.left)
        right_depth = depth(tree_node.right)

        if left_depth > right_depth
          return left_depth + 1
        else
          return right_depth + 1
        end
      end
    end

    def is_balanced?(tree_node = @root)
      return true if tree_node.nil?

      balanced = true
      left_depth = depth(tree_node.left)
      right_depth = depth(tree_node.right)
      balanced = false if (left_depth - right_depth).abs > 1

      if balanced && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
        return true
      end

      false
    end
  
end
