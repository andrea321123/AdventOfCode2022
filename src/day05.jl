module Day05

using Chain
using DataStructures

function day05(input::String)
    input = split(input, "\n\n")

    stacksinput = split(input[1], "\n")
    n = @chain stacksinput begin
        pop!
        filter(!isspace, _)
        length
    end
    stacks = Array{Stack{Char}}(undef, n)
    for i in 1:n
        stacks[i] = Stack{Char}()
    end
    for str in reverse(stacksinput)
        i = 2
        for k in 1:n
            if !isspace(str[i])
                push!(stacks[k], str[i])
            end
            i += 4
        end
    end

    moves = @chain String(input[2]) begin
        replace("move" => "")
        replace("from" => "")
        replace("to" => "")
        split("\n", keepempty=false)
        map(x -> split(x, " ", keepempty=false), _)
        map(x -> map(y -> parse(Int, y), x), _)
    end

    stacks1 = deepcopy(stacks)
    stacks2 = deepcopy(stacks)
    for m in moves
        tmp = Stack{Char}()
        for i in 1:m[1]
            push!(stacks1[m[3]], pop!(stacks1[m[2]]))
            push!(tmp, pop!(stacks2[m[2]]))
        end
        for i in 1:m[1]
            push!(stacks2[m[3]], pop!(tmp))
        end
    end
    println(answer(stacks1))
    println(answer(stacks2))
end

function answer(stacks::Vector{DataStructures.Stack{Char}})
    @chain stacks begin
        map(first, _)
        foldl(*, _)
    end
end

end # module
