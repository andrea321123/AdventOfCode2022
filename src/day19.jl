module Day19

using Chain

max_needed(costs::Vector{Vector{Int}}) = [
    maximum([costs[1][1], costs[2][1], costs[3][1], costs[4][1]]),
    maximum([costs[1][2], costs[2][2], costs[3][2], costs[4][2]]),
    maximum([costs[1][3], costs[2][3], costs[3][3], costs[4][3]]),
]

solve(costs::Vector{Vector{Int}}, time::Int) =
    solve_rec(costs, max_needed(costs), [1,0,0,0], [0,0,0,0], time, 0)

function solve_rec(
    costs::Vector{Vector{Int}},
    m::Vector{Int},
    bots::Vector{Int},
    ores::Vector{Int},
    time::Int,
    target::Int
)
    if time == 0
        return ores[4]
    end
    if target == 0
        return @chain 1:3 begin
            filter(x -> bots[x] < m[x], _)
            vcat(4)
            map(x -> solve_rec(costs, m, bots, ores, time, x), _)
            maximum
        end
    end

    if length(filter(x -> x < 0, ores[1:3] - costs[target])) == 0
        new_bots = fill(0, 4)
        new_bots[target] += 1
        new_bots += bots
        return solve_rec(costs, m, new_bots, ores - vcat(costs[target], 0) + bots, time -1, 0)
    end

    solve_rec(costs, m, bots, ores + bots, time -1, target)
end

function day19(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> (x[7], x[13], x[19], x[22], x[28], x[31]), _)
        map(x -> map(y -> parse(Int, y), x), _)
        map(x -> [[x[1],0,0],[x[2],0,0],[x[3],x[4],0],[x[5],0,x[6]]], _)
    end
    
    p1 = @chain input begin
        map(x -> solve(x, 24), _)
        map(x -> x[1] * x[2], enumerate(_))
        sum
    end
    println(p1)
    p2 = @chain input[1:3] begin
        map(x -> solve(x, 32), _)
        foldl(*, _)
    end
    println(p2)
end

end # module
