def pathfinder(start, goal, map)
    frontier = []
    frontier << start
    visited = {}
    visited[start.join] = true
    came_from = {}
    came_from[start.join] = nil

    while !frontier.empty?
        current = frontier.shift

        return calculate_route(start, goal, came_from) if current == goal

        neighbours = map.get_surrounding_nodes(current)

        neighbours.each do |n|
            next if visited[n.join] != nil || !map.safe_point?(n)
            frontier << n
            visited[n.join] = true
            came_from[n.join] = current
        end
    end

    puts 'No possible path'
    calculate_route(start, current, came_from)
end

def calculate_route(start, goal, came_from)
    current = goal
    path = [current]

    while current != start
        current = came_from[current.join]
        path << current
    end

    path
end
