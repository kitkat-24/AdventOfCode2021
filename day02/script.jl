f = open("day02/input.txt", "r")
lines = readlines(f)
close(f)

h = 0
d = 0 # Horizontal pos and depth
for line in lines
    motion, magnitude = split(line, " ")

    if motion == "forward"
        global h += parse(Int, magnitude)
    elseif motion == "up"
        global d -= parse(Int, magnitude)
    else
        global d += parse(Int, magnitude)
    end
end

# Part 1 answer
h*d


# Part 2

h = 0
d = 0 # Horizontal pos and depth
aim = 0
for line in lines
    motion, magnitude = split(line, " ")

    if motion == "forward"
        global h += parse(Int, magnitude)
        global d += aim*parse(Int, magnitude)
    elseif motion == "up"
        global aim -= parse(Int, magnitude)
    else
        global aim += parse(Int, magnitude)
    end
end

h*d