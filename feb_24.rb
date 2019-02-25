class BSTNode
attr_reader :value
attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left  = nil
    @right = nil
  end
end

class BinarySearchTree
attr_reader :root

  def initialize
    @root  = nil
  end

  def insert(value)
    @root = (insert_into_tree(@root, value))
  end

  def delete(value)
    @root = delete_from_tree(@root, value)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    # left children, itself, right children
    if tree_node.left
      in_order_traversal(tree_node.left, arr)
    end

    arr.push(tree_node.value)

    if tree_node.right
      in_order_traversal(tree_node.right, arr)
    end

    arr
  end

  def maximum(tree_node = @root)
    if tree_node.right
      maximum_node = maximum(tree_node.right)
    else
      maximum_node = tree_node
    end
    maximum_node
  end

  private
  def insert_into_tree(tree_node, value)
    return BSTNode.new(value) if tree_node.nil?

      if value <= tree_node.value
        tree_node.left = insert_into_tree(tree_node.left, value)
      elsif value > tree_node.value
        tree_node.right = insert_into_tree(tree_node.right, value)
      end

      tree_node
  end



  def delete_from_tree(tree_node, value)
  # Find the value call for remove
    if value == tree_node.value
      tree_node = remove(tree_node)
    elsif value <= tree_node.value
    tree_node.left = delete_from_tree(tree_node.left, value)
    else value >= tree_node.value
    tree_node.right = delete_from_tree(tree_node.right, value)
    end
    # Return value for recursion
    tree_node
  end

  def remove(node)
  # If node does not have any children just delete it by assigning to nil
  # if it has one child assign that childs value to that node
  # Return the node
  if node.left.nil? && node.right.nil?
    node = nil
  elsif node.left && node.right.nil?
    node = node.left
    elsif node.left.nil? && node.right
      node = node.right
    else
    # if it has both children call replace_parent node to find which will replace that node
      node = replace_parent(node)
    end
    node
  end

  def replace_parent(node)
  # Its immediate predecessor or successor will replace it
    replacement_node = maximum(node.left)
    # if replacement node has child we have to take care of it
    if replacement_node.left
      promote_child(node.left)
    end
    # Replace it by assigning original parents children to replacement node
    replacement_node.left = node.left
    replacement_node.right = node.right
    replacement_node
  end

  def promote_child(tree_node)
  # find the replacement nodes child and give it the replacement nodes place
    if tree_node.right
    parent = tree_node
    child = tree_node.right
    while child.right
      parent = parent.right
      child = child.right
    end
    parent.right = child.left
    end
  end
end
bst = BinarySearchTree.new
bst.insert(50)
bst.insert(30)
bst.insert(35)
bst.insert(20)
bst.insert(32)
bst.insert(70)
bst.insert(60)
bst.insert(80)
bst.delete(50)
bst.in_order_traversal
