# Identidade - Microsoft Entra ID

## Objetivo
Integrar sinais de identidade ao Sentinel e praticar autenticação centralizada
via Entra ID em máquinas virtuais, em vez de depender de contas locais.

## Ambiente
- Microsoft Entra ID
- Microsoft Sentinel
- Azure Virtual Machines

## O que foi feito
1. Conexão dos Audit Logs do Entra ID ao Sentinel, via solução "ID Microsoft
   Entra" no Content Hub
2. Criação de um usuário Entra ID dedicado
3. Instalação da extensão "Azure AD based Windows Login" na VM de laboratório
4. Atribuição da função "Início de Sessão de Administrador na Máquina
   Virtual" a esse usuário, permitindo login na VM via credenciais do Entra ID
5. Ativação de um trial do Microsoft Entra ID P2, para estudar Identity
   Protection e Conditional Access

## Observação técnica
A instalação da solução no Content Hub é um passo obrigatório antes do
conector de Audit Logs aparecer disponível — não é automático. Os Sign-in
Logs não foram ativados nesse ambiente por exigirem licença Entra ID P1/P2
dedicada ao recurso.

## Resultado
Login na VM funcionando via conta centralizada do Entra ID, e Audit Logs
do tenant visíveis nas tabelas do Sentinel, prontos para correlação com
outros eventos de segurança.

## Aprendizado
Entendi a diferença entre autenticação local (usuário da máquina) e
autenticação federada via identidade na nuvem, e por que centralizar login
via Entra ID facilita controle de acesso em ambientes com várias máquinas.
