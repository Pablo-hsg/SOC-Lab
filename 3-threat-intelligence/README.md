# Threat Intelligence - Importação de Indicadores

## Objetivo
Praticar a ingestão de indicadores de comprometimento (IOCs) no Microsoft
Sentinel, simulando um feed de threat intelligence.

## Ambiente
- Microsoft Sentinel (tabela ThreatIntelIndicators)

## O que foi feito
1. Criação manual de um arquivo CSV com 20 indicadores fictícios de hash de
arquivo, marcados com a tag "SC200-LAB"
2. Importação desse CSV na tabela ThreatIntelIndicators do Sentinel

## Observação técnica
A tabela usada foi a ThreatIntelIndicators, e não a ThreatIntelligenceIndicator
(mais antiga) — essa última foi descontinuada em 31/07/2025. Importante ficar
atento a esse tipo de mudança de schema entre versões da plataforma, já que
documentação desatualizada ainda referencia a tabela antiga.

## Resultado
Indicadores visíveis e consultáveis na tabela ThreatIntelIndicators do
workspace, prontos para serem usados em Regras de Análise que cruzem esses
IOCs com logs de eventos reais.

## Aprendizado
Entendi como o Sentinel estrutura dados de threat intelligence e a
importância de verificar se a tabela/schema que estou usando ainda é a
atual, em vez de seguir tutoriais desatualizados.
