class SpaceMap
    def initialize(size, start)
        @start = start
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
            point = [row, col]
            if is_valid_obstacle_point?(map, point)
                map[row][col] = type
                number -= 1
            end
        end
        map
    end

    def is_valid_obstacle_point?(map, point)
        slot = map[point[0]][point[1]]
        slot == '.' && !starting_point?(point) && !near_probe?(point, map)
    end

    def starting_point?(point)
        point == @start
    end

    def near_probe?(point, map)
        x, y = point
        area = iterate_area(x, y, map)
        area.each do |node|
            return true if node == @start
        end
        false
    end

    def coordinate_content(coord)
        @map[coord[0]][coord[1]]
    end

    def safe_point?(coord)
        unsafe = is_obstacle?(coord) || near_gravity_well?(coord)

        !unsafe
    end

    def is_obstacle?(coord)
        point = @map[coord[0]][coord[1]]
        point == 'A' or point == 'G'
    end

    def near_gravity_well?(coord)
        x, y = coord
        area = iterate_area(x,y, @map)

        area.each do |point|
            return true if @map[point[0]][point[1]] == 'G'
        end

        false
    end

    def iterate_area(x, y, map)
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
            area.push([new_x, new_y]) if valid_index?(new_x, new_y, map.length)
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

    def get_surrounding_nodes(node)
        puts 'surrounding nodes'
        puts coordinate_content [node[0]][node[1]]
    end
end
