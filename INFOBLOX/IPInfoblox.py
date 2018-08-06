# IPInfoblox.py
# Script que solicita o próximo IP disponível, reserva no IPAM e cria os registros A e PTR
#
#   Data     -   Autor(a)    -   Descrição
# 07/09/2015 - Emerson Honda - Criação do script (pendente a criação das validações, teste do conceito
#

from __future__ import print_function
from pyinfoblox import InfobloxWAPI
import sys, argparse

# Não emitir mensagem de certificado inválido
import requests

if __name__ == "__main__":

    sIblox = "10.0.60.52"
    sWapi = "https://{0}/wapi/v1.4.2/".format(sIblox)
    sUser = "admin"
    sPwd = "infoblox"

    requests.packages.urllib3.disable_warnings()
    parser = argparse.ArgumentParser()

    parser.add_argument("-n", "--Network", action="store", dest="network")
    parser.add_argument("-e", "--Entorno", action="store", dest="entorno")
    parser.add_argument("-o", "--HostName", action="store", dest="hostname")
    parser.add_argument("-d", "--registerDNS", action="store_true", dest="registerDNS")
    results = parser.parse_args()

    infoblox = InfobloxWAPI(username=sUser, password=sPwd, wapi=sWapi)
    
    # Listar as redes disponíveis
    print("Rede solicitada: ", results.network)
    networks = infoblox.network.get(network=results.network)
    if len(networks) == 0:
        print("Network not found ", results.network)
        sys.exit(2)

    # Verificar se o hostname já existe

    # Obter o próximo IP
    nextIP = infoblox.network.function(objref=networks[0]["_ref"], _function='next_available_ip', num=1)
    sIP = nextIP["ips"][0]
    print("Próximo IP:", sIP)

    infoblox.fixedaddress.create(ipv4addr=sIP, match_client="RESERVED", name=results.hostname)

    if results.registerDNS == True:
        sTmp = sIP.split(".")
        sPTR = "{0}.{1}.{2}.{3}.in-addr.arpa".format(sTmp[3],sTmp[2],sTmp[1],sTmp[0])

        infoblox.record_a.create(ipv4addr=sIP, name=results.hostname, view="Interna")
        print("Criado registro A ", results.hostname)

        infoblox.record_ptr.create(ipv4addr=sIP, view="Interna", ptrdname=sPTR)
        print("Criado registro PTR ", sPTR)
