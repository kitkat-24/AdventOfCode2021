struct Line
    A::Tuple{Int, Int}
    B::Tuple{Int, Int}
    Line(A, B) = any(B .< A) ? new(B, A) : new(A, B)
end

function rook_legal(l::Line)
    return l.A[1] == l.B[1] || l.A[2] == l.B[2]
end

function max_extent(l::Vector{Line})
    m = 0
    for i = 1:length(l)
        m = max(m, max(maximum(l[i].A), maximum(l[i].B)))
    end
    return m
end


function read_input(fn)
    f = open("day05/"*fn, "r")
    lines = Vector{Line}()
    for line in readlines(f)
        a, b = string.(split(line, " -> "))
        idx_a = parse.(Int, split(a, ',')) .+ 1 # We are not 0-indexed
        idx_b = parse.(Int, split(b, ',')) .+ 1
        # x, y grow right and down, so we flip them to turn into row, col indices
        push!(lines, Line((idx_a[2], idx_a[1]), (idx_b[2], idx_b[1])))
    end
    return lines
end

function build_matrix(lines::Array{Line}, p2=false)
    n = max_extent(lines)
    m = zeros(Int, n, n)

    for line in lines
        if rook_legal(line)
            m[line.A[1]:line.B[1], line.A[2]:line.B[2]] .+= 1
        elseif p2 # the && !rook_legal is implicit since we fell thru to here
            xsign = sign(line.B[1] - line.A[1])
            ysign = sign(line.B[2] - line.A[2])
            for (x, y) = zip(line.A[1]:xsign:line.B[1], line.A[2]:ysign:line.B[2])
                m[x, y] += 1
            end
        end
    end
    return m
end

using Printf

function print_matrix(m)
    for i = 1:size(m)[1]
        for j = 1:size(m)[2]
            if m[i, j] == 0
                @printf(". ")
            else
                @printf("%d ", m[i, j])
            end
        end
        @printf("\n")
    end
end


# Part 1
lines = read_input("input")

m = build_matrix(lines)
# print_matrix(m)

a1 = sum(m .> 0)
a2 = sum(m .> 1)


# Part 2
m2 = build_matrix(lines, true)
b2 = sum(m2 .> 1)