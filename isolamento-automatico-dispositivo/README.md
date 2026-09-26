# Resposta Automatizada: Isolamento de Dispositivo (Sentinel + Defender)

Pipeline SOAR que isola automaticamente uma máquina comprometida no Microsoft Defender for Endpoint quando um incidente com entidade Host é criado no Sentinel, e notifica o analista por e-mail.

## Diagrama da arquitetura



<img width="1335" height="540" alt="Captura de tela 2026-09-26 184824" src="https://github.com/user-attachments/assets/b02c1439-7630-4b7e-9ba5-754a6fce08b6" />


## Como funciona

1. Incidente criado no Sentinel com entidade Host
2. Regra de Automação dispara o Playbook
3. Playbook obtém o host, consulta o Defender e isola a máquina (Full)
4. Analista recebe e-mail automático com o host isolado

Stack: Microsoft Sentinel · Logic Apps · Microsoft Defender for Endpoint · Managed Identity · Outlook

## Resultado em produção

Arquitetura Playbook

<img width="346" height="723" alt="Captura de tela 2026-09-26 185656" src="https://github.com/user-attachments/assets/e765bc33-eea5-4535-8696-de0224826ea7" />



Dispositivo Isolado

<img width="1394" height="308" alt="Captura de tela 2026-09-26 185423" src="https://github.com/user-attachments/assets/272e133a-fa4b-4a1e-8210-1d98c787f6bf" />




Notificação por e-mail

<img width="649" height="418" alt="Captura de tela 2026-09-26 190007" src="https://github.com/user-attachments/assets/3fb1c9a0-a63c-4c1c-b85a-b412d94a3e2a" />

