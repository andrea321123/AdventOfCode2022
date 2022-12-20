module Day20

using Chain

mutable struct Node
    data::Int64
    previous::Union{Node, Nothing}
    next::Union{Node, Nothing}
end

after(n::Int, node::Node) = if n == 0 node.data else after(n -1, node.next) end

function solve(nodes::Vector{Node}, n::Int)
    zero = filter(x -> x.data == 0, nodes)[1]
    len = length(nodes)
    for _ in 1:n
        for node in nodes
            node.previous.next = node.next
            node.next.previous = node.previous
            curr = node
            steps = node.data % (len -1)
            dir = steps > 0
            for _ in 1:abs(steps)
                if dir      # Go right
                    curr = curr.next
                else        # Go left
                    curr = curr.previous
                end
            end
            if !dir
                curr = curr.previous
            end

            # Insert the node between [curr] and [curr.next]
            node.previous = curr
            node.next = curr.next
            curr.next.previous = node
            curr.next = node
        end
    end
    after(1000, zero) + after(2000, zero) + after(3000, zero)
end

function day20(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(x -> parse(Int64, x), _)
    end

    first = Node(input[begin], nothing, nothing)
    prev = first
    for i in input[begin+1:end-1]
        curr = Node(i, prev, nothing)
        prev.next = curr
        prev = curr
    end
    last = Node(input[end], prev, first)
    prev.next = last
    first.previous = last

    nodes = Vector{Node}()
    curr = first
    for _ in input
        push!(nodes, curr)
        curr = curr.next
    end
    nodes2 = deepcopy(nodes)
    foreach(x -> x.data *= 811589153, nodes2)

    println(solve(nodes, 1))
    println(solve(nodes2, 10))
end

end # module
