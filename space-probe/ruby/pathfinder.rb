class Pathfinder

    def initialize(map, from, to)
        @map = map
        @from = from
        @to = to
        @heuristics = Manhattan.new(map, to)
    end

    def find_path()
        closed_list = NodeList.new
        open_list = NodeList.new

        node = PathNode.new(@from, nil, 0)

        open_list << node
        decide_next_node(open_list, closed_list)
    end

    def decide_next_node(open_list, closed_list)
        if closed_list.contains_goal? @to
            puts closed_list.length
            puts closed_list[-1].inspect
            #closed_list.walkthrough
            return closed_list
        end

        surrounding_nodes = @map.get_surrounding_nodes(open_list[0].point)

        surrounding_nodes.each do |node|
            h = @heuristics.get_distance(node)
            node = PathNode.new(node, open_list[0], h)

            if !@map.safe_point?(node.point) && closed_list.in_list?(node) > -1
                next
            end

            list_position = open_list.in_list?(node)

            if list_position < 0
                open_list << node
            else
                open_list.update_node(node, list_position)
            end
        end

        open_list.sort
        closed_list << open_list.shift

        decide_next_node(open_list, closed_list)
    end
end

class NodeList
    def initialize
        @list = []
    end

    def list
        @list
    end

    def [](index)
        @list[index]
    end

    def length
        @list.length
    end

    def sort
        @list = @list.sort {|a,b| a.f <=> b.f  }
    end

    def shift
        @list.shift
    end

    def <<(node)
        @list << node
    end

    def in_list?(node)
        @list.each_with_index do |list_node, i|
            return i if list_node.point == node.point
        end
        -1
    end

    def node_index(node)
        @list.index node
    end

    def update_node(node, i)
        return if !better_node?(node, i)
        @list[i].parent = node.parent
        @list[i].g = node.g
        #@list[i].f = @list[i].g + @list[i].h
    end

    def better_node?(node, i)
        @list[i].g < node.g
    end

    def contains_goal?(goal)
        @list.each do |node|
            return true if node.point == goal
        end
        false
    end

    def walkthrough
        @list.each do |node|
            puts node.to_s
        end
    end
end

class PathNode
    attr_reader :point
    attr_accessor :f, :g, :h, :parent

    def initialize(point, parent, h)
        @point = point
        @parent = parent
        @g = @parent ? @parent.g + 10 : 0
        @h = h
        @f = @g + @h
    end

    def update_score(value)
        @g = @parent.g + value
        @f = @g + @h
    end

    def to_s
        @point.join ','
    end

end

class Manhattan
    def initialize(map, target_point)
        @map = map
        @target = target_point
    end

    def get_distance(from)
        distance = [
            @target[0] - from[0],
            @target[1] - from[1]
        ]

        (distance[0] + distance[1]) * 10
    end
end
