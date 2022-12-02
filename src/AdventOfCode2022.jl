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

days = 1:2
for day in days
    includeday(lpad(day, 2, "0"))
end

day01() = Day01.day01(readinput("01"))
day02() = Day02.day02(readinput("02"))

day02()

end # module
