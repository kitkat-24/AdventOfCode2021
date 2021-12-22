f = open("day03/input", "r")
lines = readlines(f)
close(f)

γ = ""
ϵ = ""

for i = 1:length(lines[1])
    global γ, ϵ
    ones = 0
    for j = 1:length(lines)
        ones += lines[j][i] == '1'
    end

    if ones > length(lines)/2
        γ *= "1"
        ϵ *= "0"
    else
        γ *= "0"
        ϵ *= "1"
    end
end

γf= parse(Int, γ; base=2)
ϵf = parse(Int, ϵ; base=2)

power_consumption = γf * ϵf


# Part 2

function find_ls(lines, col, type)
    if length(lines) == 1
        return parse(Int, lines[1]; base=2)
    else
        ones = 0
        zeros = 0
        for i = 1:length(lines)
            ones += lines[i][col] == '1'
            zeros += lines[i][col] == '0'
        end

        if type == "oxy"
            if ones >= zeros
                newlines = [l for l in lines if l[col] == '1']
            else
                newlines = [l for l in lines if l[col] == '0']
            end
        elseif type == "co2"
            if zeros > ones
                newlines = [l for l in lines if l[col] == '1']
            else
                newlines = [l for l in lines if l[col] == '0']
            end
        end

        return find_ls(newlines, col + 1, type)
    end
end



oxy = find_ls(lines, 1, "oxy")
co2 = find_ls(lines, 1, "co2")

life_support = oxy * co2
