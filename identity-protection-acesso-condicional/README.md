# Identity Protection + Acesso Condicional Baseado em Risco

Política de Acesso Condicional que exige MFA automaticamente quando o Microsoft Entra Identity Protection detecta um login de risco médio ou alto.

## Diagrama da arquitetura


<img width="1082" height="315" alt="Captura de tela 2026-09-27 110617" src="https://github.com/user-attachments/assets/3032b3e1-3e8b-4653-8514-955894a51fc6" />


## Como funciona

1. Identity Protection avalia cada login usando sinais de risco da Microsoft (IP anônimo, credencial vazada, viagem impossível, etc.)
2. A política de Acesso Condicional verifica se o risco calculado é Médio ou Alto
3. Se sim, exige MFA antes de liberar o acesso
4. Se não, o acesso segue normalmente

Stack: Microsoft Entra ID · Identity Protection · Acesso Condicional

## Resultado em produção

Política testada em modo "Somente relatório" por período real, sem falsos positivos nos logins legítimos, e depois ativada:


<img width="1238" height="68" alt="Captura de tela 2026-09-27 110809" src="https://github.com/user-attachments/assets/14b893f0-cb9a-491a-abd3-fa8c4be02176" />


Exemplos de eventos de início de sessão em que a política de Acesso Condicional não seria aplicada se estivesse ativada.


<img width="809" height="483" alt="Captura de tela 2026-09-27 111109" src="https://github.com/user-attachments/assets/fb5afcf6-6007-4618-8396-0e63f9eeb7ac" />


Conta break-glass (`Pablo Henrique`) mantida excluída da política, conforme boa prática de segurança.                                                      
