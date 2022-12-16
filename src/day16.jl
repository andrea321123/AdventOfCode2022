module Day16

using Chain

function solve(
    graph::Dict{String, Tuple{Int, Vector{String}}},
    current::String,
    released::Int,
    minutes::Int,
    opened::Set{String},
    rate::Int,
    prev::Set{String}
)
    released += rate

    # Early exit condition
    if minutes <= 0
        return released
    end

    v = []
    for node in graph[current][2]
        if node ∉ prev
            prevcopy = copy(prev)
            push!(prevcopy, current)
            new = solve(
                graph,
                node,
                released,
                minutes -1,
                copy(opened),
                rate,
                prevcopy
            )
            push!(v, new)
        end
    end

    if current ∉ opened && graph[current][1] != 0
        released += rate
        push!(opened, current)
        minutes -= 1
        
        if (minutes > 0)
            for node in graph[current][2]
                newprev = Set{String}()
                push!(newprev, current)
                new = solve(
                    graph,
                    node,
                    released,
                    minutes -1,
                    copy(opened),
                    rate + graph[current][1],
                    newprev
                )
                push!(v, new)
            end
        end
    end
    return max(released, if !isempty(v) maximum(v) else 0 end)
end

function day16(input::String)
    input = @chain input begin
        replace("Valve " => "")
        replace(" has flow rate=" => " ")
        replace("tunnels" => "tunnel")
        replace("leads" => "lead")
        replace("valves" => "valve")
        replace("; tunnel lead to valve " => " ")
        replace("," => "")
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> map(y -> String(y), x), _)
        map(x -> (x[1], (parse(Int, x[2]), x[3:end])), _)
        Dict
    end

    p1 = solve(
        input,
        "AA",
        0,
        30,
        Set{String}(),
        0,
        Set{String}()
    )
    println(p1)

    println("Part 2 not solved")
end

end # module
