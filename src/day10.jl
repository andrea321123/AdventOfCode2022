module Day10

using Chain

function day10(input::String)
    input = @chain input begin
        replace("addx" => "noop\nadd")
        replace("noop" => "noop 0")
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> (x[1], parse(Int, x[2])), _)
    end

    sum = 0
    trigger = 20
    cycle = 1
    x = 1 
    (i, j) = (0, 0)
    (width, height) = (40, 6)
    display = fill(' ', (height, width))
    while cycle <= length(input)
        if cycle == trigger
            trigger += 40
            sum += x * cycle
        end 
        
        if j ∈ (x-1, x, x+1)
            display[i+1, j+1] = '#'
        end
        j += 1
        if j == width
            j = 0
            i += 1
        end

        if input[cycle][1] == "add"
            x += input[cycle][2]
        end
        
        cycle += 1
    end
    println(sum)

    for i in 1:height
        for j in 1:width
            print(display[i, j])
        end
        println()
    end
end

end # module
