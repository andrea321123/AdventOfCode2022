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

days = 1:9
for day in days
    includeday(lpad(day, 2, "0"))
end

day01() = Day01.day01(readinput("01"))
day02() = Day02.day02(readinput("02"))
day03() = Day03.day03(readinput("03"))
day04() = Day04.day04(readinput("04"))
day05() = Day05.day05(readinput("05"))
day06() = Day06.day06(readinput("06"))
day07() = Day07.day07(readinput("07"))
day08() = Day08.day08(readinput("08"))
day09() = Day09.day09(readinput("09"))

end # module
