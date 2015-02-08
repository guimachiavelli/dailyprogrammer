#!/usr/bin/env ruby

class SpaceMap
    def initialize(size)
        @map = generate_map(size)
    end

    def generate_map(size)
        map = []

        map_area = size * size

        asteroids = (map_area * 0.3).to_i
        wells = (map_area * 0.1).to_i

        size.times do |count|
            row = []
            size.times { row.push('.') }
            map.push row
        end

        map = add_obstacles(asteroids, map, 'A')
        map = add_obstacles(wells, map, 'G')
        map
    end

    def add_obstacles(number, map, type)
        while number > 0 do
            row = rand(map.length)
            col = rand(map[row].length)
            slot = map[row][col]
            if slot == '.'
                map[row][col] = type
                number -= 1
            end
        end
        map
    end

    def coordinate_content(coord)
        return @map[coord[0]][coord[1]]
    end

    def safe_point?(coord)
        near_gravity_well?(coord) or is_obstacle?(coord)
    end

    def is_obstacle?(coord)
        point = @map[coord[0]][coord[1]]
        point == 'A' or point == 'G'
    end

    def near_gravity_well?(coord)
        x, y = coord
        area = iterate_area(x,y)

        area.each do |point|
            return true if @map[point[0]][point[1]] == 'G'
        end

        return false
    end

    def iterate_area(x,y)
        dirs = [
            [1,   0],
            [1,   1],
            [1,  -1],
            [-1,  0],
            [-1,  1],
            [-1, -1],
            [0,   1],
            [0,  -1],
            [0,   0]
        ]

        area = []

        dirs.each do |dir|
            new_x = x + dir[0]
            new_y = y + dir[1]
            area.push([new_x, new_y]) if valid_index?(new_x, new_y, @map.length)
        end

        area
    end

    def valid_index?(x, y, length)
        x > -1 and x < length and
        y > -1 and y < length
    end

    def to_s
        @map.map do |row|
            row.join
        end
    end

end

class Probe
    def initialize(start, finish)
        @start = start
        @finish = finish
    end
end

class SpaceProbe
    def initialize(size, from, to)
        @map = SpaceMap.new(10)

        raise 'Obstacle on starting point' unless @map.safe_point?(from)
        raise 'Obstacle on finish point' unless @map.safe_point?(to)

        @probe = Probe.new(from, to)
    end
end

space_probe = SpaceProbe.new 10,[0,0],[9,9]
