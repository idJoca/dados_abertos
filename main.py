import requests
from xml.etree import ElementTree
import csv
import sys
ano = sys.argv[2]
person_status_csv = "legislatura_" + ano + "/person_status_" + ano + ".csv"

with open(person_status_csv, 'w') as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(['Nome', 'Status'])

def get_proposicoes(name):
    url = 'https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes'
    PARAMS = {'sigla':'PL',
              'numero': '',
              'ano': ano,
              'datApresentacaoIni': '',
              'datApresentacaoFim': '',
              'parteNomeAutor': name,
              'idTipoAutor': '',
              'siglaPartidoAutor': '',
              'siglaUFAutor': '',
              'generoAutor': '',
              'codEstado': '',
              'codOrgaoEstado': '',
              'emTramitacao': ''}
    response = requests.get(url, PARAMS, stream=True)
    response.raw.decode_content = True
    events = ElementTree.iterparse(response.raw)
    situacoes = []
    if (response.status_code == 200):
        for event, elem in events:
            if (elem.tag == 'descricao'):
                situacao = elem.text.replace("\n", "").rstrip()
                situacoes.append(situacao) if (situacao != "") else None
        return situacoes
    else:
        return None

names_dict = {}
with open(sys.argv[1], 'r') as names:
    name_reader = csv.DictReader(names, delimiter=',', quotechar='"')
    for row in name_reader:
        name = row['Nome']
        names_dict[name] = name
for name in names_dict.values():
    status = get_proposicoes(name)
    if (status is not None):
        with open(person_status_csv, 'a') as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow([name, ', '.join(status)])
