struct Line
    dir::Char
    length::Integer
end
Line(str::AbstractString) = Line(str[1], parse(Int, str[2:end]))

function get_input()
    open("input.txt") do stream
         Line.(split(readline(stream), ',')), Line.(split(readline(stream), ','))
    end
end

struct Segment
    row::Union{AbstractRange, Integer}
    col::Union{AbstractRange, Integer}
    step::Integer
    dir::Char
end

function Segment(pos, line, step)
    if (line.dir == 'R')
        Segment(pos[2], pos[1]:pos[1]+line.length, step, 'R')
    elseif (line.dir == 'L')
        Segment(pos[2], pos[1]-line.length:pos[1], step, 'L')
    elseif (line.dir == 'U')
        Segment(pos[2]:pos[2]+line.length, pos[1], step, 'U')
    elseif (line.dir == 'D')
        Segment(pos[2]-line.length:pos[2], pos[1], step, 'D')
    end
end

isHorizontal(a::Segment) = typeof(a.row) <: Integer

function add_line!(position, line::Line)
    if (line.dir == 'R')
        position[1] += line.length
    elseif (line.dir == 'L')
        position[1] -= line.length
    elseif (line.dir == 'U')
        position[2] += line.length
    elseif (line.dir == 'D')
        position[2] -= line.length
    end
    position
end

function get_lines_position(lines::Array{Line, 1})
    position = [0, 0]
    step = 0
    lines_position = []
    for line in lines
        push!(lines_position, Segment(position, line, step))
        step += line.length
        add_line!(position, line)
    end
    lines_position
end

function check_conflict(seg1, seg2)
    if (isHorizontal(seg1) && !isHorizontal(seg2))
        if seg1.row in seg2.row && seg2.col in seg1.col
            # println("Conflict found : $seg1 \tand $seg2 : \t", abs(seg1.row) + abs(seg2.col))
            return abs(seg1.row) + abs(seg2.col)
        end
    elseif (!isHorizontal(seg1) && isHorizontal(seg2))
        if seg1.col in seg2.col && seg2.row in seg1.row
            # println("Conflict found : $seg1 \tand $seg2 : \t", abs(seg1.col) + abs(seg2.row))
            return abs(seg1.col) + abs(seg2.row)
        end
    end
end

function check_conflict_steps(seg1, seg2)
    if (isHorizontal(seg1) && !isHorizontal(seg2))
        if seg1.row in seg2.row && seg2.col in seg1.col
            res = seg1.step + seg2.step
            if (seg1.dir == 'R')
                res += abs(seg1.col.start - seg2.col)
            elseif (seg1.dir == 'L')
                res += abs(seg1.col.stop - seg2.col)
            end
            if (seg2.dir == 'U')
                res += abs(seg2.row.start - seg1.row)
            elseif (seg2.dir == 'D')
                res += abs(seg2.row.stop - seg1.row)
            end
            # println("Conflict found : $seg1 \tand $seg2 : \t", res)
            return res
        end
    elseif (!isHorizontal(seg1) && isHorizontal(seg2))
        if seg1.col in seg2.col && seg2.row in seg1.row
            res = seg1.step + seg2.step
            if (seg2.dir == 'R')
                res += abs(seg2.col.start - seg1.col)
            elseif (seg2.dir == 'L')
                res += abs(seg2.col.stop - seg1.col)
            end
            if (seg1.dir == 'U')
                res += abs(seg1.row.start - seg2.row)
            elseif (seg1.dir == 'D')
                res += abs(seg1.row.stop - seg2.row)
            end
            # println("Conflict found : $seg1 \tand $seg2 : \t", res)
            return res
        end
    end
end

function part1()
    min = 1000
    for seg in get_lines_position(get_input()[1])
        for wire in get_lines_position(get_input()[2])
            distance = check_conflict(seg, wire)
            if (!isnothing(distance) && distance > 0 && distance < min)
                min = distance
            end
        end
    end
    return min
end

function part2()
    min = 1000000
    for seg in get_lines_position(get_input()[2])
        for wire in get_lines_position(get_input()[1])
            distance = check_conflict_steps(seg, wire)
            if (!isnothing(distance) && distance > 0 && distance < min)
                min = distance
            end
        end
    end
    return min
end

println("Part 1 : ", part1())
println("Part 2 : ", part2())
