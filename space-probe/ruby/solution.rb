#!/usr/bin/env ruby

require './map'
require './pathfinder'

class Probe
    attr_reader :start, :finish

    def initialize(start, finish)
        @start = start
        @finish = finish
    end

    def navigate_path(node_list, map)
        node_list.list.each_with_index do |node, i|
            map.update_coordinate node.point, '*'
            map.update_coordinate node.point, 'S' if i == 0
            map.update_coordinate node.point, 'E' if i == node_list.length - 1
        end
    end
end

class SpaceProbe
    def initialize(size, from, to)
        @map = SpaceMap.new(10, from)

        @probe = Probe.new(from, to)

        @pathfinder = Pathfinder.new @map, from, to
        @probe.navigate_path @pathfinder.find_path, @map

        puts @map.to_s
    end
end

SpaceProbe.new 10,[0,0],[9,9]
