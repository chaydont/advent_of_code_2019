function readinput()
    ret = Dict()
    open("input.txt") do stream
        line = readline(stream)
        while !isempty(line)
            a, b = split(line, ')')
            if haskey(ret, a)
                push!(ret[a], b)
            else
                ret[a] = [b]
            end
            line = readline(stream)
        end
    end
    return ret
end

function count_orbits(current, n)
    ret = 0
    if !haskey(map, current)
        return n
    end
    for object in map[current]
        ret += count_orbits(object,n+1)
    end
    return ret + n
end

function lookfor(name, current, depth)
    if !haskey(map, current)
        return nothing
    elseif name in map[current]
        return depth
    end
    for object in map[current]
        a = lookfor(name, object, depth+1)
        if !isnothing(a)
            return a
        end
    end
end

function search_common_point(current)
    if !haskey(map, current)
        return nothing
    end
    for object in map[current]
        if !isnothing(lookfor("YOU", object, 0)) && !isnothing(lookfor("SAN", object, 0))
            return search_common_point(object)
        end
    end
    return lookfor("SAN", current, 0) + lookfor("YOU", current, 0)
end

function part1()
    count_orbits("COM", 0)
end

function part2()
    search_common_point("COM")
end

map = readinput()
println("Part 1 : ", part1())
println("Part 2 : ", part2())