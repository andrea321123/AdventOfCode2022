module Day01

using Chain

part1(input::Array{Int}) = maximum(input)

function part2(input::Array{Int})
    @chain input begin
        sort(rev=true)
        resize!(3)
        sum
    end
end

function day01(input::String)
    input = @chain input begin
        split("\n\n")
        map(x -> split(x, "\n", keepempty=false), _)
        map(x -> map(y -> parse(Int, y), x), _)
        map(sum, _)
    end

    println(part1(input))
    println(part2(input))
end

end # module
