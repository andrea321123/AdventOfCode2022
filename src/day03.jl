module Day03

using Chain
using IterTools

function part1(input::Array{String})
    sum = 0
    for str in input
        halflength = floor(Int64, lastindex(str) / 2)
        str1 = str[begin:halflength]
        str2 = str[halflength + 1:end]
        sum += priority(pop!(strtoset(str1) ∩ strtoset(str2)))
    end
    sum
end

function part2(input::Array{String})
    sum = 0
    for t in partition(input, 3, 3)
        sum += priority(pop!(t[1] ∩ t[2] ∩ t[3]))
    end
    sum
end

function day03(input::String)
    input = map(x -> String(x), split(input, "\n", keepempty=false))

    println(part1(input))
    println(part2(input))
end

function priority(c::Char)
    offset = if isuppercase(c) 'A' - 26 else 'a' end
    c - offset + 1
end

function strtoset(s::String)
    set = Set()
    for i in s
        push!(set, i)
    end
    set
end

end # module
