# SOC-Lab

Laboratório prático de segurança da informação, com projetos hands-on em detecção, resposta a incidentes, automação (SOAR) e gestão de identidade e acesso, utilizando Microsoft Sentinel, Microsoft Defender, Splunk, Wazuh e Microsoft Entra ID.

Cada pasta documenta um caso real do ambiente: o objetivo, o que foi feito, o resultado e o aprendizado.

## Conteúdo

## Conteúdo

- [Pipeline de Detecção e Resposta Automatizada](./pipeline-deteccao-resposta-sentinel) — fluxo completo de log até notificação automática via Sentinel
- [Integração Sentinel → Splunk](./integracao-splunk-eventhub) — exportação de dados via Event Hub para comparar KQL com SPL
- [Threat Intelligence](./threat-intelligence) — ingestão de indicadores de comprometimento (IOCs) no Sentinel
- [Identity Protection + Acesso Condicional](./identity-protection-acesso-condicional) — política de MFA baseada em risco de login
- [Enriquecimento de Reputação de IP (SOAR)](./automacao-enriquecimento-ip) — consulta automática a VirusTotal, AbuseIPDB e Shodan
- [Isolamento Automático de Dispositivo](./isolamento-automatico-dispositivo) — isolamento via Defender + notificação por e-mail
- [SOAR Playbook - Aprovação por E-mail](./soar-playbook-entra-id) — aprovação por e-mail com desabilitação automática de usuário no Entra ID
- [Regra de Correlação - Wazuh](./wazuh-correlation-rule) — regra customizada de detecção de força bruta, com troubleshooting até o disparo confirmado
- [Troubleshooting](./troubleshooting) — casos reais de diagnóstico e resolução de problemas no ambiente
