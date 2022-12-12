module Day12

using Chain
using Graphs

function day12(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(collect, _)
        mapreduce(permutedims, vcat, _)     # From vector of vectors to matrix
    end
    s = findfirst(x -> x == 'S', input)
    e = findfirst(x -> x == 'E', input)
    input[s] = 'a'
    input[e] = 'z'
    (n, m) = size(input)

    g = SimpleDiGraph(n * m, 0)
    for i in 1:n
        for j in 1:m
            for (h, k) in ((-1, 0), (0, 1), (1, 0), (0, -1))
                if validindex(n, m, i + h, j + k)
                    if input[i+h, j+k] - input[i, j] <= 1
                        add_edge!(
                            g,
                            linear(i, j, m),
                            linear(i+h, j+k, m)
                        )
                    end
                end
            end
        end
    end

    # Part one
    l = a_star(g, linear(s[1], s[2], m), linear(e[1], e[2], m))
    println(length(l))

    # Part two
    l = @chain input begin
        findall(x -> x == 'a', _)
        map(x -> (x[1], x[2]), _)
        map(x -> a_star(g, linear(x[1], x[2], m), linear(e[1], e[2], m)), _)
        map(length, _)
        filter(x -> x != 0, _)      # distance is 0 if destination is unreachable
        foldl(min, _)
    end
    println(l)
end

validindex(i, j, h, k) = 1 <= h <= i && 1 <= k <= j
linear(i, j, m) = m * (i -1) + j

end # module