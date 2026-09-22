Playbook SOAR — Aprovação por e-mail + desabilitação de usuário no Entra ID

Fluxo: incidente do Sentinel dispara o playbook → e-mail de aprovação é enviado → se aprovado, a conta do usuário é desabilitada automaticamente no Entra ID.

Incidente do Sentinel dispara o playbook
Playbook envia e-mail de aprovação
Se aprovado → Update user no Entra ID, com accountEnabled = false
Se rejeitado → fluxo termina sem ação
Stack

Microsoft Sentinel (Automation Rules + Playbooks) · Azure Logic Apps · Outlook connector · Microsoft Entra ID connector · Managed Identity

O problema principal: RBAC em duas direções

O que mais travou aqui não foi lógica do fluxo, foi permissão. Existem duas roles diferentes, para direções diferentes, e as duas são necessárias:

Playbook → Sentinel: a Managed Identity do Logic App precisa da role Microsoft Sentinel Responder, para conseguir ler/atualizar o incidente.
Sentinel → Playbook: o principal de serviço Azure Security Insights (o próprio Sentinel) precisa da role Microsoft Sentinel Automation Contributor no Logic App, senão o playbook simplesmente não aparece como opção na Automation Rule — mesmo com a primeira permissão certa.

Sem a segunda, a mensagem que aparece é só um genérico "playbook indisponível", sem apontar de qual lado falta a permissão. Vale sempre checar as duas.

Para a ação de desabilitar a conta, precisou ainda de mais uma role: User Administrator no Entra ID para a mesma Managed Identity — a permissão do Sentinel não cobre alterar contas de usuário.

Outro detalhe que gerou confusão

Rodar o playbook manualmente (sem um incidente real por trás) não dispara a lógica de aprovação, porque o trigger de incidente não tem entidade/usuário para avaliar. Só funcionou de fato testando com um incidente real associado a um usuário.

Conceitos

SOAR · Managed Identity vs autenticação por usuário · RBAC bidirecional entre recursos Azure · Automation Rules vs Playbooks
