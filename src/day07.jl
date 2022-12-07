module Day07

using Chain

struct Fs
    name::String
    isdir::Bool
    size::Int
    children::Dict{String, Fs}
    father::Union{Fs, Nothing}
end

function sizes(fs::Fs)
    subdirs = Vector{Int}()
    if !fs.isdir
        return (fs.size, subdirs)
    else
        sum = 0
        rec = map(sizes, values(fs.children))
        for i in rec
            sum += i[1]
            subdirs = vcat(subdirs, i[2])
        end
        return (sum, push!(subdirs, sum))
    end
end

part1(v::Vector{Int}) = sum(filter(x -> x <= 100000, v))

part2(v::Vector{Int}, rootsize::Int) = begin
    unused = 70000000 - rootsize
    needed = 30000000
    sort!(v)[findfirst(x -> x >= needed - unused, v)]
end

function day07(input::String)
    input = map(x-> split(x, " "), split(input, "\n", keepempty=false))
    popfirst!(input)    # We know it's "$ cd /"

    root = Fs("/", true, 0, Dict{String, Fs}(), nothing)
    current = root
    for i in input
        if i[1] == "\$"
            if i[2] == "cd"
                if i[3] == ".."
                    current = current.father
                else
                    current = current.children[i[3]]
                end
            end         # We can ignore ls instruction
        elseif i[1] == "dir"
            push!(current.children, i[2] => Fs(i[2], true, 0, Dict{String, Fs}(), current))
        else
            push!(current.children, i[2] => Fs(i[2], false, parse(Int, i[1]), Dict{String, Fs}(), current))
        end
    end

    s = sizes(root)
    println(part1(s[2]))
    println(part2(s[2], s[1]))
end

end # module
