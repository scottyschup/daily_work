class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    parent.children << self unless parent.nil? || parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "Not a child!" unless @children.include? child
    child.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      this_result = child.dfs(target_value)
      return this_result unless this_result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      this_node = queue.shift
      return this_node if this_node.value == target_value
      queue += this_node.children
    end

    nil
  end

  def trace_path_back
    nodes = [self]
    path = [self.value]

    until nodes.first.parent.nil?
      next_node = nodes.first.parent
      nodes.unshift next_node
      path.unshift next_node.value
    end

    path
  end
end
