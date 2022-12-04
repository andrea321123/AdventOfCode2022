module Day04

using Chain

function part1(input::Vector{Vector{Int64}})
    cnt = 0
    for i in input
        if i[1] <= i[3] && i[2] >= i[4] || i[3] <= i[1] && i[4] >= i[2]
            cnt += 1
        end
    end
    cnt
end

function part2(input::Vector{Vector{Int64}})
    cnt = 0
    for i in input
        if i[1] <= i[3] && i[3] <= i[2] <= i[4] ||
                i[3] <= i[1] <= i[4] && i[2] >= i[4] ||
                i[3] <= i[1] <= i[2] <= i[4] ||
                i[1] <= i[3] <= i[4] <= i[2]
            cnt += 1
        end
    end
    cnt
end

function day04(input::String)
    input = @chain input begin
        replace("," => " ")
        replace("-" => " ")
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> map(y -> parse(Int64, y), x), _)
    end

    println(part1(input))
    println(part2(input))
end

end # module
