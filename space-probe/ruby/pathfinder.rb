class Pathfinder

    def initialize(map, from, to)
        @map = map
        @from = from
        @to = to
        @heuristics = Manhattan.new(map, to)
    end

    def find_path()
        closed_list, open_list = [], []

        open_list << {:point => @from,
                      :parent => nil,
                      :g => 0,
                      :f => 0,
                      :h => 0
        }

        decide_next_node(open_list, closed_list)
    end

    def decide_next_node(open_list, closed_list)
        surrounding_nodes = @map.get_surrounding_nodes(open_list[0][:point])

        surrounding_nodes.each do |node|
            node = {
                :point => node,
                :parent => open_list[0],
                :f => 0,
                :g => 0,
                :h => 0
            }

            node[:g] = node[:parent][:g] + 10
            node[:h] = @heuristics.get_distance(node[:point])
            node[:f] = node[:g] + node[:h]

            open_list << node if @map.safe_point?(node[:point])
        end

        closed_list << open_list.shift

        puts open_list
        puts closed_list
    end

end

class PathNode
    def initialize

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
