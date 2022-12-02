module AdventOfCode2022

# Include file for related day
function includeday(day::String)
    include(joinpath(@__DIR__, "day$day.jl"))
end

# Read input file for related day
function readinput(day::String)
    file = open(joinpath(@__DIR__, "../input/day$day.txt"))
    input = read(file, String)
    close(file)
    input  
end

days = 1:0
for day in days
    includeday(lpad(day, 2, "0"))
end

end # module
