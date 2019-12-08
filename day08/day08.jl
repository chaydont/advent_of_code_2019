count_element(image, i, value) = count(x->x==value, image[:, i])

function part1()
    image = reshape(collect(input), 25 * 6, Int(length(input) / (25 * 6)))
    max = size(image, 1)
    max_i = 0
    for i in 1:size(image, 2)
        v = count_element(image, i, '0')
        if v < max
            max = v
            max_i = i
        end
    end
    return count_element(image, max_i, '1') * count_element(image, max_i, '2')
end

function add_layer(final, image)
    for i in 1:25
        for j in 1:6
            if (final[i, j] == '2')
                final[i, j] = image[i, j]
            end
        end
    end
    return final
end

function print_image(image)
    for i in 1:6
        for j in 1:25
            print(image[j,i], ' ')
        end
        println()
    end
end

function part2()
    image = reshape(collect(input), 25, 6, Int(length(input) / (25 * 6)))
    final = image[:, :, 1]
    for i in 1:size(image, 3)
        final = add_layer(final, image[:, :, i])
    end
    print_image(final)
end

input = readline("input.txt") |> String
println("Part 1 : ", part1())
println("Part 2 : ")
part2()