# Troubleshooting - Casos Reais do Ambiente

Esta pasta documenta problemas reais enfrentados durante a operação do
laboratório e como foram investigados e resolvidos (ou não).

---

## Caso 1: Volume excessivo de ingestão por configuração de DCR

**Sintoma**
Data Collection Rule (DCR) configurada para coletar "Todos os Eventos" de
Windows Security Events gerou 4.505 eventos em poucas horas na VM de
laboratório.

**O que investiguei**
Analisei o volume de ingestão na tabela SecurityEvent e identifiquei que a
DCR estava configurada para capturar o nível mais abrangente de eventos de
segurança do Windows, sem filtro.

**Causa**
Configuração inicial da DCR usando o preset "Todos os Eventos" em vez de um
filtro mais seletivo — apropriado para testes iniciais, mas inviável para
operação contínua por custo de ingestão.

**Solução**
Alterei o filtro da DCR de "Todos os Eventos" para "Minimal", reduzindo
significativamente o volume de eventos coletados, mantendo apenas os
security events mais relevantes.


<img width="1895" height="724" alt="Captura de tela 2026-09-22 165031" src="https://github.com/user-attachments/assets/bc2a0b36-2859-404e-bd7f-358f7358d6ff" />


**Aprendizado**
Volume de ingestão em SIEM tem custo direto e escala rápido. Antes de
configurar coleta de logs em produção, é essencial dimensionar o filtro
pelo tipo de evento necessário, não pelo mais abrangente disponível.




