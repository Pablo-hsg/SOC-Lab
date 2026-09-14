# Regra de correlação para força bruta (Wazuh)

Criei uma regra de correlação no Wazuh pra detectar tentativas repetidas de login falho via sudo/PAM. Já tinha feito algo parecido no Sentinel com KQL, esse é o mesmo conceito em outra ferramenta.

## Ambiente

- Wazuh Manager rodando em servidor Linux dedicado (Server + Dashboard)
- Agente instalado numa VM Ubuntu 24.04, status Active
- Fluxo: Agent → Manager → Indexer → Dashboard

## O que fiz

Primeiro simulei tentativas de sudo com senha errada pra confirmar que o agente estava coletando os eventos certo. Deu tudo certo, gerou os eventos nível 5 esperados (PAM: User login failed, Failed attempt to run sudo).

Só que a instalação padrão do Wazuh não vem com regra de correlação pra força bruta. Cada tentativa falha fica registrada isolada, sem nenhum alerta juntando tudo. Então escrevi essa regra em `local_rules.xml`:

```xml
<rule id="100002" level="10" frequency="8" timeframe="120">
  <if_matched_group>authentication_failed</if_matched_group>
  <description>Multiple authentication failures - possible brute force attack</description>
  <mitre>
    <id>T1110</id>
  </mitre>
  <group>authentication_failures,</group>
</rule>
```

Se 8 eventos do grupo `authentication_failed` acontecerem em 120 segundos, gera um alerta nível 10, com a técnica MITRE T1110 (Brute Force) já anexada.

## O disparo não veio de primeira

Rodei o teste e não disparou nada, mesmo os eventos de base estando certos. Fui atrás do porquê:

1. Expandi um dos eventos no Dashboard pra conferir se ele realmente pertencia ao grupo `authentication_failed`. Pertencia, então o grupo não era o problema.
2. Usei o `wazuh-logtest` pra testar a regra isolada, fora do ambiente real, e conseguir ver o que estava acontecendo por dentro.
3. Reparei no campo `firedtimes` da saída, que ia subindo a cada evento (1, 2, 3... até 7). No oitavo, apareceu a regra 100002 disparando, com level 10 e o mitre.id T1110.

Then descobri que o problema não era a regra em si, era só eu não ter chegado no oitavo evento ainda dentro da mesma janela de tempo.

## Disco cheio no meio do processo

Em outro momento dessa sessão, o disco do Wazuh Manager encheu (o módulo vulnerability-detection consumiu uns 18GB sozinho). Isso derrubou o Indexer, que derrubou o Manager, que fez o Agent ficar caindo e reconectando toda hora. Resolvi parando o manager, apagando o cache do módulo, e desabilitando ele de vez no ossec.conf pra não repetir.

Aprendi na marra que num SIEM, se qualquer parte do pipeline (Agent, Manager, Indexer, Dashboard) trava, tudo trava junto, e às vezes sem erro claro na tela.

## O que o Wazuh não tem

Diferente do Sentinel, o Wazuh não tem uma aba de "Incidente" com status, atribuição, fechamento de caso. Ele só gera o alerta e para por aí. Pra ter esse fluxo de gestão de caso, normalmente conecta outra ferramenta em cima, tipo TheHive ou algum SOAR.

## O que eu mudaria numa próxima vez

- Variar os logs simulados (timestamp, PID) em vez de repetir a linha idêntica, pra ficar mais parecido com um ataque real
- Testar com o timeframe/frequency ajustado com base em uso real, não só um número que fiz no chute
- Conectar isso com uma ferramenta de gestão de caso pra fechar o ciclo completo

## Relacionado

Mesma técnica (T1110, força bruta) já trabalhada em [`1-pipeline-sentinel`](../1-pipeline-sentinel), lá com regra em KQL no Sentinel.
