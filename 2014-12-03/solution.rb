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

    def to_s
        @map.map do |row|
            row.join
        end
    end

end

map = SpaceMap.new(9)

puts map.to_s
