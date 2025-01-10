def save(report):
    # differences
    diffs = [a - b for a, b in zip(report, report[1:])]
    # conditions
    asc_desc = all(i >= 0 for i in diffs) or all(i <= 0 for i in diffs)
    safe_diffs = all(1 <= abs(i) <= 3 for i in diffs)

    if asc_desc and safe_diffs:
        return True

file = open("../inputs/02.txt")
input_lines = file.readlines()
file.close()

# parsing
input = []
for line in input_lines:
    input.append(list(map(int, line.split())))

safe_reports = 0
for report in input:
    if save(report):
        safe_reports += 1
    else:
        for i in range(len(report)):
            bad_levels = report[:i] + report[i + 1 :]
            if save(bad_levels):
                safe_reports += 1
                break

print(safe_reports)
