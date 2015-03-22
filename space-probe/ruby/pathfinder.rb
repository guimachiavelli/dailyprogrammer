class Pathfinder

    def initialize(map)
        @map = map
        @heuristics = Manhattan.new(map)
    end

    def find_path(start, finish)
        @map.get_surrounding_nodes(start)
    end

end

class Manhattan

    def initialize(map)
        @map = map
    end

end
