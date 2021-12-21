# Read input
f = open("day01/input.txt", "r")
lines = readlines(f)
close(f)

data = parse.(Float64, lines)


# Part 1 answer
sum(diff(data) .> 0)


# Part 2
d2 = sum.(zip(data[1:end-2], data[2:end-1], data[3:end]))
sum(diff(d2) .> 0)