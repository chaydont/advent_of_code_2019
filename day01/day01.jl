function part1(filename)
    open(filename) do stream
        sum = 0
        line = readline(stream)
        while (!isempty(line))
            sum += max(floor(parse(Int, line) / 3) - 2, 0)
            line = readline(stream)
        end
        return sum
    end
end

function calculateFuel(n::Number)
    value = max(floor(n / 3) - 2, 0)
    return value + (value > 0 ? calculateFuel(value) : 0)
end

function part2(filename)
    open(filename) do stream
        sum = 0
        line = readline(stream)
        while (!isempty(line))
            sum += calculateFuel(parse(Int, line))
            line = readline(stream)
        end
        return sum
    end
end

println("Part 1 : ",  part1("input.txt"))
println("Part 2 : ",  part2("input.txt"))
