module Day14

using Chain
using IterTools

function solve(grid::Set{Tuple{Int, Int}}, floor::Int, part1::Bool)
    entry = (500, 0)
    count = 0
    while entry ∉ grid
        i = entry[2]
        j = entry[1]
        while true
            stopped = true
            for point in [(j, i +1), (j -1, i +1), (j +1, i +1)]
                if i == floor -1
                    if part1
                        return count
                    end
                    break
                elseif point ∉ grid
                    i = point[2]
                    j = point[1]
                    stopped = false
                    break
                end
            end
            if stopped
                push!(grid, (j, i))
                break
            end
        end

        count += 1
    end
    count
end

function day14(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, " -> "), _)
        map(x -> map(y -> split(y, ","), x), _)
        map(x -> map(y -> map(z -> parse(Int, z), y), x), _)
    end

    grid = Set{Tuple{Int, Int}}()
    for i in input
        for (a, b) in partition(i, 2, 1)
            if a[1] == b[1]
                for s in map(x -> (a[1], x), min(a[2], b[2]):max(a[2], b[2]))
                    push!(grid, s)
                end
            elseif a[2] == b[2]
                for s in map(x -> (x, a[2]), min(a[1], b[1]):max(a[1], b[1]))
                    push!(grid, s)
                end
            end
        end
    end
    floor = maximum(map(x -> maximum(map(y -> y[2], x)), input)) +2
    println(solve(deepcopy(grid), floor, true))
    println(solve(grid, floor, false))
end

end # module
