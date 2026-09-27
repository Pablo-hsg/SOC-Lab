# Pipeline de Detecção e Resposta Automatizada - Microsoft Sentinel

## Objetivo
Construir um pipeline completo de detecção e resposta dentro do Microsoft Sentinel,
simulando o fluxo real de um SOC: da geração do log até a notificação automática,
sem intervenção manual.

## Ambiente
- Microsoft Sentinel (workspace Microsoft-Sentinel-Workspace)
- Azure Monitor (Log de Atividades e Configurações de Diagnóstico)
- Logic Apps (Playbook)

## O que foi feito
1. Criação de um Grupo de Recursos como alvo de monitoramento
2. Configuração do Log de Atividades do Azure para capturar eventos desse grupo
3. Criação de uma Configuração de Diagnóstico, enviando os logs para a tabela AzureActivity no Sentinel
4. Criação de uma Regra de Análise, para gerar um incidente sempre que uma condição específica ocorrer na tabela AzureActivity
5. Criação de uma Regra de Automação, vinculada à Regra de Análise, para disparar uma ação automaticamente quando o incidente é criado
6. Criação de um Playbook (Logic App) que envia um e-mail automático assim que o incidente é aberto

## Evidências


### Regra de Análise

<img width="572" height="793" alt="Captura de tela 2026-09-22 154924" src="https://github.com/user-attachments/assets/75e4af76-5684-43cc-9229-43c46d7d7edb" />






Regra `Deteccao-AzureActivity-GrupoRecursos`, mapeada em MITRE ATT&CK (Defense Evasion / T1578) e com a query KQL que detecta a criação do grupo de recursos.


### Regra de Automação

<img width="1054" height="571" alt="Captura de tela 2026-09-22 154853" src="https://github.com/user-attachments/assets/037f9c93-7442-4fb9-9ada-d0a8bc4c5442" />

Regra de automação disparada quando o incidente é criado, com a condição filtrando pelo nome da Regra de Análise e a ação executando o Playbook.


## Resultado
Fluxo testado ponta a ponta: uma ação no Grupo de Recursos gera o log, o log chega
na tabela AzureActivity, a Regra de Análise cria o incidente, a Regra de Automação
aciona o Playbook, e o e-mail é enviado automaticamente, sem nenhuma etapa manual.

## Aprendizado
Entendi na prática por que a separação entre Regra de Análise (o que detectar) e
Regra de Automação (o que fazer quando detectar) existe: ela permite reagir a
incidentes em escala, sem depender de um analista clicando em cada alerta manualmente.
