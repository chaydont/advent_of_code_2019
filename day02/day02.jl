read_input(filename) = [parse(Int, i) for i in split(String(read(filename)), ",")]

function execute_code(code, arg1, arg2)
    code[2] = arg1
    code[3] = arg2
    for i in 1:4:length(code)
        if (code[i] == 1)
            code[code[i+3]+1] = code[code[i+1]+1] + code[code[i+2]+1]
        elseif (code[i] == 2)
            code[code[i+3]+1] = code[code[i+1]+1] * code[code[i+2]+1]
        elseif (code[i] == 99)
            return code
        else
           @error "Something when wrong"
        end
    end
end

function part1(filename) 
    code = read_input(filename)
    return execute_code(code, 12, 2)[1]
end

function part2(filename)
    code = read_input(filename)
    init_code = deepcopy(code)
    for i in 1:99
        for j in 1:99
            code = execute_code(code, i, j)
            if (code[1] == 19690720)
                return i*100 + j
            end
            code = deepcopy(init_code)
        end
    end
end


println("Part 1 : ",  part1("input.txt"))
println("Part 2 : ",  part2("input.txt"))