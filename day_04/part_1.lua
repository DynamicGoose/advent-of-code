-- parsing
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

function Horizontal(lines)
    local count = 0
    for _, line in ipairs(lines) do
        for i = 1, #line - 3 do
            local character = string.sub(line, i, i)
            if character == "X" then
                if string.sub(line, i + 1, i + 1) == "M"
                    and string.sub(line, i + 2, i + 2) == "A"
                    and string.sub(line, i + 3, i + 3) == "S" then
                    count = count + 1
                end
            end
            if character == "S" then
                if string.sub(line, i + 1, i + 1) == "A"
                    and string.sub(line, i + 2, i + 2) == "M"
                    and string.sub(line, i + 3, i + 3) == "X" then
                    count = count + 1
                end
            end
        end
    end
    return count
end

function Vertical(lines)
    local count = 0
    for idx, line in ipairs(lines) do
        if idx <= #lines - 3 then
            for i = 1, #line do
                local character = string.sub(line, i, i)
                if character == "X" then
                    if string.sub(lines[idx + 1], i, i) == "M"
                        and string.sub(lines[idx + 2], i, i) == "A"
                        and string.sub(lines[idx + 3], i, i) == "S" then
                        count = count + 1
                    end
                end
                if character == "S" then
                    if string.sub(lines[idx + 1], i, i) == "A"
                        and string.sub(lines[idx + 2], i, i) == "M"
                        and string.sub(lines[idx + 3], i, i) == "X" then
                        count = count + 1
                    end
                end
            end
        end
    end
    return count
end

function Diagonal(lines)
    local count = 0
    for idx, line in ipairs(lines) do
        for i = 1, #line do
            local character = string.sub(line, i, i)
            if character == "X"
                and idx <= #lines - 3 then
                if string.sub(lines[idx + 1], i + 1, i + 1) == "M"
                    and string.sub(lines[idx + 2], i + 2, i + 2) == "A"
                    and string.sub(lines[idx + 3], i + 3, i + 3) == "S" then
                    count = count + 1
                end
            end
            if character == "X"
                and idx > 3 then
                if string.sub(lines[idx - 1], i + 1, i + 1) == "M"
                    and string.sub(lines[idx - 2], i + 2, i + 2) == "A"
                    and string.sub(lines[idx - 3], i + 3, i + 3) == "S" then
                    count = count + 1
                end
            end
            if character == "S"
                and idx <= #lines - 3 then
                if string.sub(lines[idx + 1], i + 1, i + 1) == "A"
                    and string.sub(lines[idx + 2], i + 2, i + 2) == "M"
                    and string.sub(lines[idx + 3], i + 3, i + 3) == "X" then
                    count = count + 1
                end
            end
            if character == "S"
                and idx > 3 then
                if string.sub(lines[idx - 1], i + 1, i + 1) == "A"
                    and string.sub(lines[idx - 2], i + 2, i + 2) == "M"
                    and string.sub(lines[idx - 3], i + 3, i + 3) == "X" then
                    count = count + 1
                end
            end
        end
    end
    return count
end

-- reading input
local input = ReadFile("input.txt")
local occurences = Horizontal(input) + Vertical(input) + Diagonal(input) -- horizontal + vertical + diagonal occurences

print(occurences)
