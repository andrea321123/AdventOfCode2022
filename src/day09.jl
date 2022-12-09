module Day09

using Chain

# To simulate motions we use a state machine of the type:
# [current state], [previous knot move] => [next state], [knot move]
# States represent the relative position of previous knot compared to current
# knot, with the current knot being at the center of the following matrix:
# 1 2 3
# 4 5 6
# 7 8 9
statemachine = Dict(
    (1, "U") => (2, "UL"),
    (1, "D") => (4, " "),
    (1, "L") => (4, "UL"),
    (1, "R") => (2, " "),
    (2, "U") => (2, "U"),
    (2, "D") => (5, " "),
    (2, "L") => (1, " "),
    (2, "R") => (3, " "),
    (3, "U") => (2, "UR"),
    (3, "D") => (6, " "),
    (3, "L") => (2, " "),
    (3, "R") => (6, "UR"),
    (4, "U") => (1, " "),
    (4, "D") => (7, " "),
    (4, "L") => (4, "L"),
    (4, "R") => (5, " "),
    (5, "U") => (2, " "),
    (5, "D") => (8, " "),
    (5, "L") => (4, " "),
    (5, "R") => (6, " "),
    (6, "U") => (3, " "),
    (6, "D") => (9, " "),
    (6, "L") => (5, " "),
    (6, "R") => (6, "R"),
    (7, "U") => (4, " "),
    (7, "D") => (8, "DL"),
    (7, "L") => (4, "DL"),
    (7, "R") => (8, " "),
    (8, "U") => (5, " "),
    (8, "D") => (8, "D"),
    (8, "L") => (7, " "),
    (8, "R") => (9, " "),
    (9, "U") => (6, " "),
    (9, "D") => (8, "DR"),
    (9, "L") => (8, " "),
    (9, "R") => (6, "DR"),

    # Part 2
    (1, "UL") => (1, "UL"),
    (1, "UR") => (2, "U"),
    (1, "DL") => (4, "L"),
    (1, "DR") => (5, " "),
    (2, "UL") => (2, "UL"),
    (2, "UR") => (2, "UR"),
    (2, "DL") => (4, " "),
    (2, "DR") => (6, " "),
    (3, "UL") => (2, "U"),
    (3, "UR") => (3, "UR"),
    (3, "DL") => (5, " "),
    (3, "DR") => (6, "R"),
    (4, "UL") => (4, "UL"),
    (4, "UR") => (2, " "),
    (4, "DL") => (4, "DL"),
    (4, "DR") => (8, " "),
    (5, "UL") => (1, " "),
    (5, "UR") => (3, " "),
    (5, "DL") => (7, " "),
    (5, "DR") => (9, " "),
    (6, "UL") => (2, " "),
    (6, "UR") => (6, "UR"),
    (6, "DL") => (8, " "),
    (6, "DR") => (6, "DR"),
    (7, "UL") => (4, "L"),
    (7, "UR") => (5, " "),
    (7, "DL") => (7, "DL"),
    (7, "DR") => (8, "D"),
    (8, "UL") => (4, " "),
    (8, "UR") => (6, " "),
    (8, "DL") => (8, "DL"),
    (8, "DR") => (8, "DR"),
    (9, "UL") => (5, " "),
    (9, "UR") => (6, "R"),
    (9, "DL") => (8, "D"),
    (9, "DR") => (9, "DR")
)

move_to_increment(move::String) = Dict(
    "U" => (0, 1),
    "D" => (0, -1),
    "L" => (-1, 0),
    "R" => (1, 0),
    " " => (0, 0),
    "UL" => (-1, 1),
    "UR" => (1, 1),
    "DL" => (-1, -1),
    "DR" => (1, -1)
)[move]

function day09(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> (String(x[1]), parse(Int, x[2])), _)
    end

    len = 10
    states = fill(5, len)
    xcoords = zeros(len)
    ycoords = zeros(len)
    history1 = Set()
    history2 = Set()
    push!(history1, (0, 0))
    push!(history2, (0, 0))

    for i in input
        for _ in 1:i[2]
            move = i[1]

            # 1 is head, [len] is tail
            for j in 2:len
                if move != " "
                    (states[j], move) = statemachine[(states[j], move)] 
                    
                    (xincrement, yincrement) = move_to_increment(move)
                    xcoords[j] += xincrement
                    ycoords[j] += yincrement
                end
            end
            push!(history1, (xcoords[2], ycoords[2]))
            push!(history2, (xcoords[len], ycoords[len]))
        end
    end
    println(length(history1))
    println(length(history2))
end

end # module
