# Enriquecimento Automático de Reputação de IP via SOAR (Sentinel + Azure Automation)

Pipeline SOAR (Security Orchestration, Automation and Response) que enriquece automaticamente qualquer IP presente em um incidente do Microsoft Sentinel, consultando três fontes de inteligência de ameaças (VirusTotal, AbuseIPDB e Shodan/InternetDB) e gerando um veredito de risco combinado — tudo sem intervenção manual do analista.

## Diagrama da arquitetura

<img width="1125" height="867" alt="diagrama-pipeline" src="https://github.com/user-attachments/assets/49dca457-223a-4e96-bbb3-218cb7e68aca" />


Fluxo: uma Regra de Análise detecta uma condição e cria um Incidente → uma Regra de Automação escuta a criação do incidente e, se ele tiver um IP como entidade, dispara um Playbook → o Playbook extrai o IP do incidente e chama um Webhook → o Webhook aciona uma Runbook do Azure Automation, que consulta as três fontes e devolve um veredito consolidado.
