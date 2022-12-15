module Day15

using Chain

function day15(input::String)
    input = @chain input begin
        replace("Sensor at x=" => "")
        replace(", y=" => " ")
        replace(": closest beacon is at x=" => ";")
        split("\n", keepempty=false)
        map(x -> split(x, ";"), _)
        map(x -> map(y -> split(y, " "), x), _)
        map(x -> map(y -> map(z -> parse(Int, z), y), x), _)
        map(x -> map(y -> (y[1], y[2]), x), _)
        map(x -> (x[1][1], x[1][2], distance(x[1], x[2]), x[2][1], x[2][2]), _)
    end

    grid = Set{Tuple{Int, Int, Int}}()
    beacons = Set{Tuple{Int, Int}}()
    for (x, y, dist, _, _) in input
        for h in -dist:dist
            push!(grid, (x + abs(h) - dist, x + dist - abs(h), y + h))
        end
    end

    for (_, _, _, x, y) in input
        push!(beacons, (x, y))
    end

    y = 2000000
    y_beacons = filter(b -> b[2] == y, beacons)
    p1 = @chain grid begin
        filter(x -> x[3] == y, _)
        map(x -> x[1]:x[2], collect(_))
        foldl(union, _)
        filter(x -> (x, y) ∉ y_beacons, _)
        length
    end
    println(p1)

    println("Part 2 not solved")
end

distance(p1::Tuple{Int, Int}, p2::Tuple{Int, Int}) =
    abs(p1[1] - p2[1]) + abs(p1[2] - p2[2])

end # module
