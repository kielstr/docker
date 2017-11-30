import csv
cases = []

with open('helpers/fixtures/data.csv') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        cases.append(row)
