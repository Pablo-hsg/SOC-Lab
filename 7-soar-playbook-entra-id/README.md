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
