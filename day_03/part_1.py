from re import findall

file = open("input.txt")
input = file.read()
file.close()

instructions = findall(r"mul\((\d{1,3}),(\d{1,3})\)", input)

solution = sum(int(x) * int(y) for x, y in instructions)

print(solution)
