import csv
import requests
import codecs
import subprocess
import os
import threading

def get_spendings(year):
    url = 'https://www.camara.leg.br/transparencia/api/download/tabelaComparativa.csv'
    PARAMS = {'deputado': '',
              'ano': year,
              'mes': '',
              'partido': '',
              'estado': ''}
    while True:
        response = requests.get(url, PARAMS, stream=True)
        response.raw.decode_content = True    
        iterator = response.iter_lines()
        whole_csv = []
        unique_csv = []
        if (response.status_code == 200):
            spendings = csv.reader(codecs.iterdecode(iterator, 'ISO-8859-1'), delimiter=";", quotechar='"')
            for row in spendings:
                whole_csv.append(row)
                try:
                    if not any(row[0] in sublist for sublist in unique_csv):
                        unique_csv.append(row)
                except GeneratorExit:
                    pass
            return whole_csv, unique_csv
        else:
            continue

# From 2007 to 2019 (end point not included)
years = range(2013, 2020)
for year in years:
    print(year)
    whole_csv, unique_csv = get_spendings(year)
    whole_csv_name = 'legislatura_' + str(year) + '/gastos_deputados_' + str(year) + '.csv'
    unique_csv_name = 'legislatura_' + str(year) + '/nomes_deputados_' + str(year) + '.csv'
    os.makedirs(os.path.dirname(whole_csv_name), exist_ok=True)
    with open(whole_csv_name, 'w') as whole_spendings_table:
        writer = csv.writer(whole_spendings_table)
        writer.writerows(whole_csv)
    with open(unique_csv_name, 'w') as whole_names_table:
        writer = csv.writer(whole_names_table)
        writer.writerows(unique_csv)
    subprocess.run("python main.py " + unique_csv_name + " " + str(year))
    