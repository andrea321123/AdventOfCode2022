module Day21

using Chain

function parse_input(x)
    if length(x) == 2
        return (x[1], parse(Int, x[2]))
    end
    return (x[1], x[2], x[3], x[4])
end

function day21(input::String)
    input = @chain input begin
        replace(":" => "")
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(parse_input, _)
    end

    numbers = filter(x -> length(x) == 2, input)
    ops = filter(x -> length(x) != 2, input)

    values = Dict{String, Int}()
    foreach(x -> values[x[1]] = x[2], numbers)

    i = 1
    while length(ops) != 0
        if ops[i][2] in keys(values) && ops[i][4] in keys(values)
            new = 0
            if ops[i][3] == "+"
                new = values[ops[i][2]] + values[ops[i][4]]
            elseif ops[i][3] == "-"
                new = values[ops[i][2]] - values[ops[i][4]]
            elseif ops[i][3] == "*"
                new = values[ops[i][2]] * values[ops[i][4]]
            elseif ops[i][3] == "/"
                new = values[ops[i][2]] / values[ops[i][4]]
            end
            values[ops[i][1]] = new
            deleteat!(ops, i)
        end

        i = if i >= length(ops) 1 else i + 1 end
    end
    println(values["root"])

    println("Part 2 not solved")
end

end # module
