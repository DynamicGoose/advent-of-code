from re import findall

file = open("input.txt")
input = file.read()
file.close()

instructions = findall(r"(mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\))", input)

solution = 0
mul_enabled = True
for instruction in instructions:
    match instruction[0]:
        case "do()":
            mul_enabled = True
        case "don't()":
            mul_enabled = False
        case _ if mul_enabled:
            solution += int(instruction[1]) * int(instruction[2])

print(solution)
