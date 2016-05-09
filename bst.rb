class Node
    attr_accessor :value, :left_child, :right_child
    def initialize(value)
        @value = value.to_i
        @left_child = nil
        @right_child = nil
    end

    def build_tree(array)
        tree = [self] #Keeps track of node objects
        root_node = tree[0].value
        values = [self.value]
        array.each do | entry |
            next if values.include? entry
            written =  false
            while !written
                current_node = tree.select { |node| node.value == root_node}
                focus = current_node[0]
                if entry < focus.value
                    if focus.left_child == nil
                        new_node = Node.new(entry)
                        focus.left_child = new_node
                        tree << new_node
                        root_node = tree[0].value
                        written = true
                    else
                        root_node = focus.left_child.value
                        redo
                    end
                elsif entry > focus.value
                    if focus.right_child == nil
                        new_node = Node.new(entry)
                        focus.right_child = new_node
                        tree << new_node
                        root_node = tree[0].value
                        written = true
                    else
                        root_node = focus.right_child.value
                        redo
                    end
                end
            end
        end
        puts "Tree built with #{tree.length} nodes"
        return tree
    end
   
    def bfs(n, tree)
        location = nil
        queue = [tree[0]]
        visited = []
        while queue.length != 0
            focus = queue.shift
            visited << focus
            if focus.value == n
                location = focus
                puts "#{n} found in node #{focus}"
                return focus
            else
            queue.unshift(focus.left_child) unless focus.left_child == nil
            queue.unshift(focus.right_child) unless focus.right_child == nil
            end
        end
        puts "#{n} was not found"
        return nil
    end

    def dfs(n, tree)
        stack = [tree[0]]
        visited = []
        while stack.length > 0
            focus = stack.pop
            visited << focus
            if focus.left_child != nil
                stack << focus.left_child if !visited.include?(focus.left_child)
                if focus.left_child.value == n
                    puts "#{n} found in: #{focus.left_child}"
                    return focus.left_child
                end
            end
            if focus.right_child != nil
                stack << focus.right_child if !visited.include?(focus.right_child)
                if focus.right_child.value == n
                    puts "#{n} found in: #{focus.right_child}"
                    return focus.right_child
                end
            end
        end
        puts "#{n} could not be found"
        return nil
    end

    def dfs_rec(target, current)
        if target == current.value
            puts "#{target} found in: #{current}"
            return current
        end
        dfs_rec(target, current.left_child) if current.left_child != nil
        dfs_rec(target, current.right_child) if current.right_child != nil
    end
end


array =  [1, 7, 4, 23, 14,13, 8]
a = Node.new(12)
tree = a.build_tree(array)
a.bfs(4, tree)
a.dfs(4, tree)
a.dfs_rec(4, tree[0]) # call dfs_rec with the first node of the tree