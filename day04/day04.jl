
function isGrowing(password)
    password = password |> collect
    last_letter = password |> popfirst!
    for letter in password
        if letter < last_letter
            return false
        end
        last_letter = letter
    end
    return true
end

function hasDouble(password)
    password = password |> collect
    last_letter = password |> popfirst!
    for letter in password
        if letter == last_letter
            return true
        end
        last_letter = letter
    end
    return false
end

function hasExactlyDouble(password)
    rep = 1
    password = password |> collect
    last_letter = password |> popfirst!
    for letter in password
        if letter == last_letter
            rep += 1
        elseif rep == 2
            return true
        else
            rep = 1
        end
        last_letter = letter
    end
    return rep == 2
end

function part1(str)
    input = parse.(Int, split(str, '-'))
    res = 0
    for i in input[1]:input[2]
        if (isGrowing(string(i)) && hasDouble(string(i)))
            res += 1
        end
    end
    return res
end

function part2(str)
    input = parse.(Int, split(str, '-'))
    res = 0
    for i in input[1]:input[2]
        if (isGrowing(string(i)) && hasExactlyDouble(string(i)))
            res += 1
        end
    end
    return res
end


println("Part 1 : ", part1("138241-674034"))
println("Part 2 : ", part2("138241-674034"))
