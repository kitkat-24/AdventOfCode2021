mutable struct Board
    board::Matrix{Int}
    marked::Matrix{Bool}
end

function bingo(b::Board)
    for i = 1:5
        if all(b.marked[:, i]) || all(b.marked[i, :])
            return true
        end
    end

    return false
end

function score(b::Board)
    return sum((!s[2] ? s[1] : 0 for s in zip(b.board, b.marked)))
end

function mark!(b::Board, n::Int)
    idx = indexin(n, b.board)[1] # Returns an array even though its only finding the first instance for some baffling reason
    isnothing(idx) ? nothing : b.marked[idx] = true
end


function read_input(fn)
    f = open("day04/"*fn, "r")
    numbers = parse.(Int, split(readline(f), ','))

    boards = Vector{Board}()

    while !eof(f)
        readline(f)

        data = zeros(5, 5)

        for i = 1:5
            data[i, :] = parse.(Int, split(readline(f), ' '; keepempty=false))
        end

        append!(boards, [Board(data, falses(5, 5)),])
    end
    close(f)

    return numbers, boards
end

function play_bingo(numbers, boards)
    for num in numbers
        mark!.(boards, num)

        done = bingo.(boards)

        idx = findfirst(done)
        if !isnothing(idx)
            return score(boards[idx]) * num
        end
    end
end

function lose_bingo(numbers, boards)
    rounds = zeros(Int, length(boards))
    for num in numbers
        mark!.(boards, num)

        done = bingo.(boards)
        rounds += .!done

        if all(done)
            return score(boards[findmax(rounds)[2]]) * num
        end
    end
end



# Part 1
numbers, boards = read_input("test")
final_score = play_bingo(numbers, boards)

# Part 2
numbers, boards = read_input("input") # To reset boards
final_score = lose_bingo(numbers, boards)
