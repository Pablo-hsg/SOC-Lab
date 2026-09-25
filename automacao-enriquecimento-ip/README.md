# Enriquecimento Automático de Reputação de IP via SOAR (Sentinel + Azure Automation)

Pipeline SOAR (Security Orchestration, Automation and Response) que enriquece automaticamente qualquer IP presente em um incidente do Microsoft Sentinel, consultando três fontes de inteligência de ameaças (VirusTotal, AbuseIPDB e Shodan/InternetDB) e gerando um veredito de risco combinado — tudo sem intervenção manual do analista.

## Diagrama da arquitetura

<img width="1125" height="867" alt="diagrama-pipeline" src="https://github.com/user-attachments/assets/49dca457-223a-4e96-bbb3-218cb7e68aca" />


Fluxo: uma Regra de Análise detecta uma condição e cria um Incidente → uma Regra de Automação escuta a criação do incidente e, se ele tiver um IP como entidade, dispara um Playbook → o Playbook extrai o IP do incidente e chama um Webhook → o Webhook aciona uma Runbook do Azure Automation, que consulta as três fontes e devolve um veredito consolidado.


## Por que este projeto

Em um SOC real, analistas gastam boa parte do tempo fazendo enriquecimento manual: copiar um IP de um alerta, colar em três sites diferentes, comparar resultados e decidir se é malicioso. Esse projeto automatiza justamente essa etapa repetitiva, permitindo que o analista veja o veredito já pronto dentro do próprio incidente, reduzindo o MTTR (tempo médio de resposta) e o tempo gasto em tarefas repetitivas.


## Como funciona

1. Uma Regra de Análise detecta uma condição e cria um Incidente
2. Uma Automation Rule verifica se o incidente tem um IP e aciona o Playbook
3. O Playbook extrai o IP e chama um Webhook
4. O Webhook aciona a Runbook, que consulta VirusTotal, AbuseIPDB e Shodan em paralelo e calcula um veredito automático

Stack: Microsoft Sentinel · Azure Automation (PowerShell) · Logic Apps · VirusTotal API · AbuseIPDB API · Shodan InternetDB

## Resultado em produção



<img width="1867" height="706" alt="Captura de tela 2026-09-25 160738" src="https://github.com/user-attachments/assets/661d8d36-04d9-4065-bb02-ff241050b41b" />








<img width="1902" height="335" alt="Captura de tela 2026-09-25 161027" src="https://github.com/user-attachments/assets/904589ae-72c7-4340-b322-baa9109ccefd" />




## Código

[Ver script da Runbook](./runbook-consulta-reputacao.ps1)






