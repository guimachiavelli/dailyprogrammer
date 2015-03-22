#!/usr/bin/env ruby

require './map'
require './pathfinder'

class Probe
    attr_reader :start, :finish
    def initialize(start, finish)
        @start = start
        @finish = finish
    end
end

class SpaceProbe
    def initialize(size, from, to)
        @map = SpaceMap.new(10, from)

        raise 'Obstacle on starting point' unless @map.safe_point?(from)
        #raise 'Obstacle on finish point' unless @map.safe_point?(to)

        @probe = Probe.new(from, to)

        @pathfinder = Pathfinder.new @map
        @pathfinder.find_path(from, to)
    end
end

SpaceProbe.new 10,[0,0],[9,9]
