import csv
import os
from re import sub
from decimal import Decimal
file_path_all = "legislatura_todas/propostas.csv"
# file_path_all = "legislatura_todas/gastos.csv"

def get_party(name, year):
    file_path_gastos = "legislatura_" + str(year) + "/gastos_deputados_" + str(year) + ".csv"
    with open(file_path_gastos) as gastos:
        reader = csv.DictReader(gastos)
        for row in reader:
            if (row['Nome'] == name):
                return row['Partido']
        
def get_csv(year):
    file_path_status = "legislatura_" + str(year) + "/person_status_qntd_" + str(year) + ".csv"
    with open(file_path_status) as status:
        reader_status = csv.reader(status, quotechar='"')
        appended_csv = []
        next(reader_status)
        for row in reader_status:
            if (len(row) > 0):
                row.append(get_party(row[0], year))
                row.append(str(year))
                row[4] = Decimal(sub(r'[^\d.]', '', row[4]))
                appended_csv.append(row)
        return appended_csv
"""
with open(file_path_all, 'w') as file:
        writer = csv.writer(file)
        writer.writerow(["Nome","Partido","UF","Tipo_de_Despesa","Valor","Ano"])
"""

with open(file_path_all, 'w') as file:
    writer = csv.writer(file)
    writer.writerow(["Nome", "Arquivados", "Retirados", "Tramitando", "Aguardando","Total", "Partido", "Ano"])

years = range(2007, 2020)
for year in years:
    os.makedirs(os.path.dirname(file_path_all), exist_ok=True)
    with open(file_path_all, 'a') as file:
        writer = csv.writer(file)
        appended_csv = get_csv(year)
        if (year == years[0]):
            writer.writerows(appended_csv)
        else:
            writer.writerows(appended_csv)