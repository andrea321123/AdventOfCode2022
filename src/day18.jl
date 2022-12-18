module Day18

using Chain

adjacent = [[1,0,0],[-1,0,0],[0,1,0],[0,-1,0],[0,0,1],[0,0,-1]]
outside = Set{Vector{Int}}()
bounds = Vector{Int}()

function generate_outside(input::Set{Vector{Int}}, coord::Vector{Int})
    if coord ∈ outside
        return
    end

    if coord[1] < bounds[1] || coord[1] > bounds[2] ||
        coord[2] < bounds[3] || coord[2] > bounds[4] ||
        coord[3] < bounds[5] || coord[3] > bounds[6]

        push!(outside, coord)
        return
    end

    push!(outside, coord)
    for i in adjacent
        p = coord + i
        if p ∉ input
            generate_outside(input, p)
        end
    end
end

function day18(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, ","), _)
        map(x -> map(y -> parse(Int, y), x), _)
        Set
    end

    # Find the smallest cube that contains all lava droplets
    for i in 1:3
        l = map(x -> x[i], collect(input))
        push!(bounds, minimum(l) -1)
        push!(bounds, maximum(l) +1)
    end
    generate_outside(input, [bounds[1], bounds[3], bounds[5]])

    p1 = 0
    p2 = 0
    for i in input
        for j in adjacent
            block = i + j
            if block ∉ input
                p1 += 1
                if block ∈ outside
                    p2 += 1
                end
            end
        end
    end

    println(p1)
    println(p2)
end

end # module
