from re import findall

file = open("../inputs/03.txt")
input = file.read()
file.close()

instructions = findall(r"mul\((\d{1,3}),(\d{1,3})\)", input)

solution = sum(int(x) * int(y) for x, y in instructions)

print(solution)
