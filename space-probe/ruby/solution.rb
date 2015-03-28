#!/usr/bin/env ruby

require './map'
require './pathfinder'

class SpaceProbe
    def initialize(size, from, to)
        @map = SpaceMap.new(10, from)

        path = pathfinder(from, to, @map)

        path.each_with_index do |node, i|
            symbol = '*'
            symbol = 'E' if i == 0
            symbol = 'S' if i == path.length - 1
            @map.update_coordinate node, symbol
        end

        puts @map.to_s
    end
end

SpaceProbe.new 10,[0,0],[9,9]
