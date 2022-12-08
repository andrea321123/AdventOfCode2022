module Day08

using Chain

function part1(input::Vector{Vector{Int}}, n::Int)
    visibles = Set{Tuple{Int, Int}}()
    for z in 1:n
        im = [[z], collect(1:n), [z], collect(reverse(1:n))]
        jm = [collect(1:n), [z], collect(reverse(1:n)), [z]]
        for (iv, jv) in zip(im, jm)
            max = -1
            for i in iv
                for j in jv
                    if input[i][j] > max
                        max = input[i][j]
                        push!(visibles, (i, j))
                    end
                end
            end
        end
    end
    length(visibles)
end

function part2(input::Vector{Vector{Int}}, n::Int)
    max = 0
    for i in collect(1:n)
        for j in collect(1:n)
            # Up, right, down, left
            im = [collect(reverse(1:i-1)), [i], collect(i+1:n), [i]]
            jm = [[j], collect(j+1:n), [j], collect(reverse(1:j-1))]
            prod = 1
            for (iv, jv) in zip(im, jm)
                height = input[i][j]
                exit = false
                count = 0
                for h in iv
                    for k in jv
                        count += 1
                        if input[h][k] >= height
                            exit = true
                            break
                        end
                    end
                    if exit
                        break
                    end
                end
                prod *= count
            end
            if prod > max
                max = prod
            end
        end
    end
    max
end

function day08(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(collect, _)
        map(x -> map(y -> parse(Int, y), x), _)
    end
    n = length(input)       # Input is a square matrix

    println(part1(input, n))
    println(part2(input, n))
end

end # module
