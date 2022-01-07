# Read input
f = open("day07/input")
start_positions = parse.(Int, split(readline(f), ','))
close(f)

using Statistics


# Part 1
x = median(start_positions)
fuel = sum((abs(x - i) for i in start_positions))


# Part 2
# I'm not sure how to do this one so cutely since the cost is now non-uniform
# per distance, so I'm just gonna calculate the cost of each position and
# choose the best, so it will be O(nm) where n is the number of elements and m
# is difference between the lowest and highest starting points

function cost_func(x, crabs)
    # Use summation identity for cost as a function of distance
    return sum((n*(n+1)/2 for n in abs.(crabs .- x)))
end

costs = (cost_func(i, start_positions) for i in minimum(start_positions):maximum(start_positions))
println("Part 2 solution: $(Int(minimum(costs)))")
