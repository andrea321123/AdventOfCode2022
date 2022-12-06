module Day06

using IterTools

function day06(input::String)
    println(unique(input, 4))
    println(unique(input, 14))
end

function unique(input::String, n::Int)
    i = n
    for w in partition(input, n, 1)
        if length(Set(w)) == n
            return i
        end
        i += 1
    end
end

end # module
