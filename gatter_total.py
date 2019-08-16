import csv
total_csv = []

with open("legislatura_todas/gastos.csv") as gastos:
    reader = csv.DictReader(gastos)
    for row in reader:
        if (row['Tipo_de_Despesa'] == 'Total'):
            total_csv.append(row)
with open("legislatura_todas/gastos.csv", 'w') as gastos:
    writer = csv.DictWriter(gastos, fieldnames=reader.fieldnames)
    writer.writeheader()
    writer.writerows(total_csv)
