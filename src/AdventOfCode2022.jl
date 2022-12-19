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

days = 1:19
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
day10() = Day10.day10(readinput("10"))
day11() = Day11.day11(readinput("11"))
day12() = Day12.day12(readinput("12"))
day13() = Day13.day13(readinput("13"))
day14() = Day14.day14(readinput("14"))
day15() = Day15.day15(readinput("15"))
day16() = Day16.day16(readinput("16"))
day17() = Day17.day17(readinput("17"))
day18() = Day18.day18(readinput("18"))
day19() = Day19.day19(readinput("19"))

end # module
