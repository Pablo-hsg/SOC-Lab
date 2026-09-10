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

## Resultado
Fluxo testado ponta a ponta: uma ação no Grupo de Recursos gera o log, o log chega
na tabela AzureActivity, a Regra de Análise cria o incidente, a Regra de Automação
aciona o Playbook, e o e-mail é enviado automaticamente, sem nenhuma etapa manual.

## Aprendizado
Entendi na prática por que a separação entre Regra de Análise (o que detectar) e
Regra de Automação (o que fazer quando detectar) existe: ela permite reagir a
incidentes em escala, sem depender de um analista clicando em cada alerta manualmente.
