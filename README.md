# SOC-Lab

Laboratório prático de operações de segurança (SOC), construído em ambiente
Azure com Microsoft Sentinel, Microsoft Defender, Splunk e Microsoft Entra ID.

Cada pasta documenta um caso real do ambiente: o objetivo, o que foi feito,
o resultado e o aprendizado.

## Conteúdo

- [1. Pipeline de Detecção e Resposta Automatizada](./1-pipeline-sentinel) —
  fluxo completo de log até notificação automática via Sentinel

- [2. Integração Sentinel → Splunk](./2-integracao-splunk-eventhub) —
  exportação de dados via Event Hub para comparar KQL com SPL

- [3. Threat Intelligence](./3-threat-intelligence) —
  ingestão de indicadores de comprometimento (IOCs) no Sentinel

- [4. Identidade - Entra ID](./4-identity-entra-id) —
  integração de sinais de identidade e login centralizado em VM

- [5. Troubleshooting](./5-troubleshooting) —
  casos reais de diagnóstico e resolução de problemas no ambiente

## Contexto

Estudo prático voltado à certificação Microsoft SC-200 (Security Operations
Analyst) e à formação como analista Blue Team / SOC.
