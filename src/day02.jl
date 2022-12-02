module Day02

# X: rock
# Y: paper
# Z: scissors
function part1(input::Array{SubString{String}})
    points = Dict(
        "A X" => 1 + 3,
        "A Y" => 2 + 6,
        "A Z" => 3 + 0,
        "B X" => 1 + 0,
        "B Y" => 2 + 3,
        "B Z" => 3 + 6,
        "C X" => 1 + 6,
        "C Y" => 2 + 0,
        "C Z" => 3 + 3,
    )

    sum(map(x -> points[x], input))
end

# X: lose
# Y: draw
# Z: win
function part2(input::Array{SubString{String}})
    points = Dict(
        "A X" => 3 + 0,
        "A Y" => 1 + 3,
        "A Z" => 2 + 6,
        "B X" => 1 + 0,
        "B Y" => 2 + 3,
        "B Z" => 3 + 6,
        "C X" => 2 + 0,
        "C Y" => 3 + 3,
        "C Z" => 1 + 6,
    )

    sum(map(x -> points[x], input))
end

# A: rock
# B: paper
# C: scissors
function day02(input::String)
    input = split(input, "\n", keepempty=false)

    println(part1(input))
    println(part2(input))
end

end # module
