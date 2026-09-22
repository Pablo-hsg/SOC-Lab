# Playbook SOAR — Aprovação por e-mail + desabilitação de usuário no Entra ID

Fluxo: incidente do Sentinel dispara o playbook → e-mail de aprovação é enviado → se aprovado, a conta do usuário é desabilitada automaticamente no Entra ID.

1. Incidente do Sentinel dispara o playbook
2. Playbook envia e-mail de aprovação
3. Se aprovado → `Update user` no Entra ID, com `accountEnabled = false`
4. Se rejeitado → fluxo termina sem ação

## Stack

Microsoft Sentinel (Automation Rules + Playbooks) · Azure Logic Apps · Outlook connector · Microsoft Entra ID connector · Managed Identity

## Visão geral dos recursos

### Fluxo do playbook

<img width="844" height="590" alt="Captura de tela 2026-09-22 144940" src="https://github.com/user-attachments/assets/b9341851-ac7d-4950-a193-f95a23783f98" />

Estrutura do Logic App no designer: trigger de incidente do Sentinel, envio do e-mail de aprovação e a condição que decide entre desabilitar a conta ou encerrar sem ação.

### Mapa de recursos do resource group

<img width="1643" height="441" alt="Captura de tela 2026-09-22 144744" src="https://github.com/user-attachments/assets/049cdf7b-76a7-492a-8812-938e06b1b0ed" />

Workbooks e soluções do Sentinel conectados ao workspace de um lado; os playbooks (Logic Apps) e suas API connections do outro — incluindo tentativas de teste que ficaram no ambiente (`PLAYBOOK-TESTE-PABLO`).

## O problema principal: RBAC em duas direções

Duas roles diferentes, para direções diferentes — as duas são necessárias:

- **Playbook → Sentinel**: Managed Identity do Logic App precisa de `Microsoft Sentinel Responder`, pra ler/atualizar o incidente.
- **Sentinel → Playbook**: o principal `Azure Security Insights` precisa de `Microsoft Sentinel Automation Contributor` no Logic App — sem isso, o playbook nem aparece como opção na Automation Rule.
- Pra desabilitar a conta, a Managed Identity também precisa de `User Administrator` no Entra ID.

## Detalhe importante

Rodar o playbook manualmente (sem incidente real) não dispara a aprovação — o trigger precisa de um usuário/entidade pra avaliar. Só testa de fato associando a um incidente real.

## Conceitos

SOAR · Managed Identity vs autenticação por usuário · RBAC bidirecional · Automation Rules vs Playbooks
