module Day11

using DataStructures
using Chain

mutable struct Monkey
    items::Queue{Int}
    operation::Bool    # + if true, * if false
    operand::Int
    test::Int
    testtrue::Int
    testfalse::Int
    interactions::Int
end

function Monkey(in)
    q = Queue{Int}()
    for i in map(x -> parse(Int, x), split(in[1], " ", keepempty=false))
        enqueue!(q, i)
    end
    operation = split(in[2], " ")
    if operation[2] == "old"
        operation = (operation[1], "-1")
    end

    Monkey(
        q,
        operation[1] == "+",
        parse(Int, operation[2]),
        parse(Int, in[3]),
        parse(Int, in[4]) + 1,
        parse(Int, in[5]) + 1,
        0
    )
end

function solve(monkeys::Vector{Monkey}, p1::Bool, mod::Int, iter::Int)
    for _ in 1:iter
        for i in 1:length(monkeys)
            while(!isempty(monkeys[i].items))
                item = dequeue!(monkeys[i].items)
                operand = monkeys[i].operand
                if monkeys[i].operation
                    item += if operand == -1 item else operand end
                else
                    item *= if operand == -1 item else operand end
                end

                if p1
                    item = floor(item / 3)
                end

                if item % monkeys[i].test == 0
                    enqueue!(monkeys[monkeys[i].testtrue].items, item % mod)
                else
                    enqueue!(monkeys[monkeys[i].testfalse].items, item % mod)
                end

                monkeys[i].interactions += 1
            end
        end
    end
    foldl(*, sort(map(x -> x.interactions, monkeys), rev=true)[1:2])
end

function day11(input::String)
    input = @chain input begin
        replace(r"Monkey .:\n" => "")
        replace("  Starting items: " => "")
        replace("," => " ")
        replace("  Operation: new = old " => "")
        replace("  Test: divisible by " => "")
        replace("    If true: throw to monkey " => "")
        replace("    If false: throw to monkey " => "")
        split("\n\n", keepempty=false)
        map(x -> split(x, "\n"), _)
        map(Monkey, _)
    end

    input2 = deepcopy(input)
    mod = foldl(*, map(x -> x.test, input))
    println(solve(input, true, mod, 20))
    println(solve(input2, false, mod, 10000))

end

end # module
