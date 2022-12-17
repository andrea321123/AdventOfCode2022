module Day17

function solve(
    directions::Vector{Char},
    rocks::Vector{Vector{Vector{Int}}},
    height::Vector{Int},
    top::Vector{Int},
    n::Int
)
    direction = 1
    ldirections = length(directions)
    rock = 1
    lrocks = length(rocks)
    grid = Set{Vector{Int}}(map(x -> [0, x], 0:7))
    p1 = 0

    for _ in 1:n
        topcoord = [p1-height[rock]-3, 2+top[rock]]
        stop = false
        while !stop
            # Jet of gas
            prev = copy(topcoord)
            if directions[direction] == '<'
                topcoord += [0, -1]
            else
                topcoord += [0, 1]
            end
            for b in rocks[rock]
                coord = b + topcoord
                if coord ∈ grid || coord[2] ∈ [0, 8]
                    topcoord = prev
                    break
                end
            end

            # Fall 1 unit
            prev = copy(topcoord)
            topcoord += [1, 0]
            for b in rocks[rock]
                if b + topcoord ∈ grid
                    stop = true
                    topcoord = prev
                    break
                end
            end
            if stop
                p1 = min(p1, topcoord[1])
                for b in rocks[rock]
                    push!(grid, topcoord + b)
                end
            end
            
            # Update direction
            direction += 1
            if direction > ldirections
                direction = 1
            end
        end

        # Update rock
        rock += 1
        if rock > lrocks
            rock = 1
        end
    end

    -p1
end

function day17(input::String)
    input = collect(input)
    pop!(input)

    rocks = [
        [[0, 0], [0, 1], [0, 2], [0, 3]],               # -
        [[0, 0], [1, -1], [1, 0], [1, 1], [2, 0]],      # +
        [[0, 0], [1, 0], [2, 0], [2, -1], [2, -2]],     # L
        [[0, 0], [1, 0], [2, 0], [3, 0]],               # |
        [[0, 0], [0, 1], [1, 0], [1, 1]]                # o
    ]
    height = [1, 3, 3, 4, 2]
    top = [1, 2, 3, 1, 1]

    println(solve(input, rocks, height, top, 2022))
    println(solve(input, rocks, height, top, 10^12))
end

end # module
