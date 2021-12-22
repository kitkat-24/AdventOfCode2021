# Read input
f = open("day06/input")
startfish = parse.(Int, split(readline(f), ','))
close(f)


# Part 1
days = 80
fish = copy(startfish)
for i = 1:days
    n = length(fish)
    for j = 1:n
        fish[j] -= 1
        if fish[j] == -1
            push!(fish, 8) # New fish
            fish[j] = 6 # Wrapping
        end
    end
end

# print(fish)
length(fish)



# Part 2
# Time to get smart and memoize shit.
#
# Each fish can be thought of as a potential number of fish with X days left
# until the end of the simulation, i.e. the starting fish have 256 days left,
# their children will have 253 or 252 or smth like that. So we define a function
# that will follow a fish down to the end the sim, saving the fish count
# for a fish at that "depth" so we don't repeat work, then we can solve out all
# the other fish with just a hashmap access.
#
# The trick lies in the fish spawn timer, since not all start equally. The
# answer, I believe, is just to say that a day 0 fish with a timer of 3 is a
# fish with value 256 + 3 = 259

days = 256
fict = Dict{Tuple{Int32, Int32}, Int128}()

function fish_search(d::Int, c::Int)
    global fict

    v = get(fict, (d, c), nothing)
    if v !== nothing
        return v
    else
        if d <= c
            fict[(d, c)] = 1
            return 1
        end

        if c == 0
            r = fish_search(d-1, 6) + fish_search(d-1, 8)
        else
            r = fish_search(d-1, c-1)
        end
        fict[(d, c)] = r
        return r
    end
end

output = [fish_search(days, c) for c in startfish]
sum(output)