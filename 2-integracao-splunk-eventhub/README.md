# Integração Sentinel → Splunk via Event Hub

## Objetivo
Exportar dados de segurança do Microsoft Sentinel para o Splunk Enterprise,
para comparar KQL com SPL sobre os mesmos dados reais e praticar
administração multi-ferramenta (não depender de uma única plataforma de SIEM).

## Ambiente
- Microsoft Sentinel
- Azure Event Hubs
- Splunk Enterprise (instalação local)
- Splunk Add-on for Microsoft Cloud Services

## O que foi feito
1. Criação de um Grupo de Recursos dedicado, isolado do resto do ambiente,
   para controlar o custo da integração separadamente
2. Configuração de um alerta de orçamento (budget alert) nesse grupo, para
   monitorar o gasto da integração
3. Criação de um namespace e um Hub de Eventos dentro dele
4. Criação de uma Regra de Exportação de Dados no Sentinel, apontando a
   tabela SecurityEvent para o Hub de Eventos
5. Instalação do Splunk Add-on for Microsoft Cloud Services no Splunk local
6. Configuração do índice de recebimento no Splunk

## Resultado
Eventos reais de segurança da VM chegando no Splunk, pesquisáveis com
`index=main sourcetype="mscs:azure:eventhub"`. O índice correto era `main`,
e não `default` como veio configurado inicialmente no formulário — precisei
corrigir isso durante o processo.

## Aprendizado
Entendi que a exportação de dados no Sentinel fica em Configurações > Regras
de Exportação, não junto das Tabelas — não é óbvio à primeira vista. Também
aprendi a importância de isolar recursos por Grupo de Recursos dedicado
quando o objetivo é controlar custo de um experimento específico.
