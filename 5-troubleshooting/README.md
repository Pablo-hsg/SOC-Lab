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

**Aprendizado**
Volume de ingestão em SIEM tem custo direto e escala rápido. Antes de
configurar coleta de logs em produção, é essencial dimensionar o filtro
pelo tipo de evento necessário, não pelo mais abrangente disponível.

---

## Caso 2: Falha persistente de RDP sem causa identificada

**Sintoma**
Máquina virtual apresentou falha de conexão RDP (código de erro 0x204) de
forma persistente.

**O que investiguei**
Verifiquei, em ordem: serviço TermService rodando, porta 3389 em escuta,
regras de firewall, configuração de NLA (Network Level Authentication) e a
chave de registro fDenyTSConnections (confirmada em 0, ou seja, RDP
habilitado). Reiniciei a VM por completo após cada verificação.

**Causa**
Não identificada. Nenhum dos pontos de diagnóstico padrão revelou a origem
do problema.

**Solução**
Após diagnóstico extenso sem resultado, decidi recriar a VM do zero
(apagando disco, interface de rede, IP público e NSG antigos) em vez de
continuar investigando indefinidamente. A nova VM, criada com a mesma
configuração de rede, teve o RDP funcionando normalmente desde o primeiro
boot.

**Aprendizado**
Nem todo problema tem causa raiz identificável dentro de um tempo razoável.
Saber reconhecer quando recriar do zero é mais eficiente do que continuar
depurando é também uma decisão técnica válida — especialmente em ambiente
de laboratório, onde o custo de recriar é baixo.

---

## Caso 3: VM associada ao tenant errado

**Sintoma**
Uma VM do laboratório estava onboarded no Microsoft Defender apontando para
o Organization ID de um tenant antigo, e não do tenant principal em uso.

**O que investiguei**
Ao revisar o Device Inventory do Defender, notei que o dispositivo aparecia
vinculado a um tenant que não era mais utilizado, e não havia mais acesso
disponível a esse tenant antigo para fazer o offboarding oficial por lá.

**Causa**
A VM havia sido originalmente onboarded usando uma chave de deployment
gerada no tenant antigo, antes da migração para o tenant principal.

**Solução**
Apaguei a VM afetada e recriei do zero no grupo de recursos correto,
reaproveitando a chave de deployment do Defender já gerada no tenant
principal, e removi o registro fantasma do dispositivo antigo no Device
Inventory.

**Aprendizado**
Ao trabalhar com múltiplos tenants, é essencial confirmar qual identidade
organizacional está sendo usada antes de rodar qualquer script de
onboarding, um erro nesse ponto só aparece bem depois, quando já é mais
trabalhoso de corrigir.
