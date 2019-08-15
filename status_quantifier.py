import csv

years = range(2007, 2020)
for year in years:
    person_status_path = "legislatura_" + str(year) + "/person_status_" + str(year) + ".csv"
    person_status_qntd_path = "legislatura_" + str(year) + "/person_status_qntd_" + str(year) + ".csv"
    with open(person_status_path) as person_status_csv:
        name_reader = csv.DictReader(person_status_csv, delimiter=',', quotechar='"')
        counted_csv = [["Nome", "Arquivados", "Retirados", "Tramitando", "Aguardando", "Total"]]
        for row in name_reader:
            total, arquivados, retirados, tramitando, aguardando = [0] * 5
            for status in row['Status'].rsplit(','):
                if (status == 'A Proposicao procurada nao existe'):
                    pass
                elif (status == 'Arquivada'):
                    arquivados += 1
                    total += 1
                elif (status == 'Retirado pelo Autor'):
                    retirados += 1
                    total += 1
                elif (status.find("Tramitando") != -1):
                    tramitando += 1
                    total += 1
                elif (status.find("Aguardando") != -1):
                    aguardando += 1
                    total += 1
            counted_csv.append([row['Nome'], arquivados, retirados, tramitando, aguardando, total])
    with open(person_status_qntd_path, 'w') as person_status_qntd_csv:
        writer = csv.writer(person_status_qntd_csv)
        writer.writerows(counted_csv)
        