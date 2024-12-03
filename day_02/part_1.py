file = open("input.txt")
input_lines = file.readlines()
file.close()

# parsing
input = []
for line in input_lines:
    input.append(list(map(int, line.split())))

safe_reports = 0
for report in input:
    # differences
    diffs = [a - b for a, b in zip(report, report[1:])]
    # conditions
    asc_desc = all(i >= 0 for i in diffs) or all(i <= 0 for i in diffs)
    safe_diffs = all(1 <= abs(i) <= 3 for i in diffs)

    if asc_desc and safe_diffs:
        safe_reports += 1

print(safe_reports)
