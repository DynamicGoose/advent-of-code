function ReadFile(file)
    local arr = {}
    local handle = assert(io.open(file, "r"))
    local value = handle:read("*line")
    while value do
        table.insert(arr, value)
        value = handle:read("*line")
    end
    return arr
end

function Diagonal(input)
    local total = 0
    for idx, line in ipairs(input) do
        for i = 1, #line do
            local character = string.sub(line, i, i)
            if character == "M" and idx <= #input - 2 then
                if string.sub(input[idx + 1], i + 1, i + 1) == "A"
                    and string.sub(input[idx + 2], i + 2, i + 2) == "S"
                    and ((string.sub(input[idx + 2], i, i) == "M"
                            and string.sub(input[idx], i + 2, i + 2) == "S")
                        or (string.sub(input[idx + 2], i, i) == "S"
                            and string.sub(input[idx], i + 2, i + 2) == "M")) then
                    total = total + 1
                end
            end
            if character == "S" and idx <= #input - 2 then
                if string.sub(input[idx + 1], i + 1, i + 1) == "A"
                    and string.sub(input[idx + 2], i + 2, i + 2) == "M"
                    and ((string.sub(input[idx + 2], i, i) == "S"
                            and string.sub(input[idx], i + 2, i + 2) == "M")
                        or (string.sub(input[idx + 2], i, i) == "M"
                            and string.sub(input[idx], i + 2, i + 2) == "S")) then
                    total = total + 1
                end
            end
        end
    end
    return total
end

local input = ReadFile("../inputs/04.txt")
local occurences = Diagonal(input)

print(occurences)
