# Proposta de melhorias — AppSancta

Base: leitura do código em `lib/` (não executei o app em dispositivo). Itens marcados *[verificar]* dependem de teste no aparelho.

## 0. Bypass do premium (já implementado)

`lib/providers/subscription_provider.dart`: constante `kPremiumBypass`.

- Libera o premium na inicialização, **sem consultar internet nem RevenueCat**. A loja é carregada em segundo plano só para a tela de compra ficar pronta, e as falhas são ignoradas.
- Padrão: **ligado em debug/profile, desligado em release**.
- Para forçar em qualquer build: `--dart-define=PREMIUM_BYPASS=true`.
- Para testar o paywall real: `--dart-define=PREMIUM_BYPASS=false`.
- O mock que liberava o premium quando "Restaurar compras" dava erro foi removido. Esse caminho só libera enquanto o bypass estiver ligado.
- A `PaywallPage` não foi alterada. Ela segue pronta e é acionada quando o bypass está desligado.

Antes de publicar, ainda faltam as chaves reais do RevenueCat e as URLs reais de Termos e Privacidade. Hoje elas apontam para um GitHub placeholder.

## 1. Diagnóstico: o que dificulta o uso diário

### A. Navegação e estrutura (maior impacto)
1. **Dois conceitos de "home" convivem.** O app usa `MainScaffold` com 5 abas, mas `HomePage`, `AppDrawer`, `PlaceholderPage` e `PlanningPage` ainda estão no projeto e referenciados. Há telas duplicadas: `ExaminationHomePage` e `ExaminationTab`, `DevotionalHomePage` e `OracoesPage`. Isso confunde o usuário e a manutenção.
2. **Nomes e ícones das abas não batem com o conteúdo.** O Jardim da Alma usa o rótulo `moreTitle` ("Mais") com ícone de parque. As Novenas usam uma flor (`local_florist`). O Rosário usa um ícone de aspas (`format_quote`). Quem chega pela primeira vez não adivinha o que cada aba faz.
3. **Cinco abas com a mesma importância.** A ação mais frequente do dia (rezar o que está planejado) fica dentro de Jardim > Hoje, sem atalho a partir da abertura do app.
4. **"Em breve" visível ao usuário** (`comingSoon`, jaculatórias) sinaliza app inacabado.

### B. Primeiro uso e rotina
5. **Falta onboarding.** O app abre direto no paywall ou nas abas, sem explicar o Jardim, as novenas ou o exame, e sem passo de permissão de notificação com contexto. Hoje a permissão é pedida em `MainScaffold.initState`, sem explicação.
6. **Splash lento.** Há no mínimo 2 s de espera, depois 0,5 s de fade, depois 1 s de transição. Na tela principal ainda há 1,1 s + 0,2 s + 0,8 s de fade artificial (`_shouldBuild`, `_isVisible`). São cerca de 5 s até usar o app, todo dia. O `rescheduleAllReminders` também roda no caminho da abertura.
7. **Sem tela "Hoje" que centralize.** Falta um painel único com: tempo litúrgico e santo do dia, orações pendentes, novena em andamento, próximo lembrete e atalho para o terço do dia (os mistérios mudam conforme o dia da semana).
8. **Rosário.** Sem escolha automática do mistério do dia como padrão visível, contador de contas, modo de leitura sem distração nem opção de manter a tela acesa *[verificar]*.

### C. Lembretes e notificações
9. O fluxo de criar lembrete tem muitas opções (4 tipos × 4 recorrências × período do dia × dia da semana/mês), com `reminder_edit_dialog` de 700 linhas. Falta um caminho de 2 toques ("lembrar todo dia às 7h").
10. **Notificações após reiniciar o aparelho.** Os lembretes só são reagendados quando o app é aberto. O relatório já cita a falta de receiver de boot *[verificar no AndroidManifest]*. Sem isso, o lembrete falha justamente para quem usa a rotina diária.
11. Permissão de alarme exato no Android 12+ e otimização de bateria não são orientadas ao usuário.

### D. Confissão e privacidade
12. **Senha:** guardada como SHA-256 simples, sem salt, no SharedPreferences (`auth_service.dart`). Para dados tão sensíveis, o ideal é salt + derivação lenta (PBKDF2/Argon2) e armazenamento em `flutter_secure_storage`.
13. **"Recuperar acesso" apaga os dados?** Pelo texto de aviso, sim. Falta oferecer biometria (`local_auth`) e travar o app ao ir para segundo plano.
14. **Backup:** é manual (exportar/importar arquivo) e não é criptografado, embora contenha pecados. Falta proteger com a senha do usuário e lembrar o backup periodicamente. A sincronização entre aparelhos é inexistente.

### E. Qualidade visual e acessibilidade
15. **Sem tema escuro.** O app é de uso noturno (exame de consciência, orações da noite), e a única opção é o tema claro.
16. **Acessibilidade zero:** nenhuma ocorrência de `Semantics`. Não verifiquei escala de fonte nem contraste. Para um público que inclui idosos, falta um ajuste de tamanho de fonte nos textos de oração.
17. **Textos longos:** orações, novenas e litanias são exibidos como texto corrido. Falta barra de rolagem/progresso, aumento de fonte e "marcar como rezada" no final.
18. **Pontos fracos de UX do paywall:** o botão diz `paywallStartTrial`, mas não há garantia de que a oferta tenha período de teste. Falta mostrar o preço real, os benefícios claros e um "continuar grátis" limitado, se fizer sentido comercial.

### F. Engenharia
19. **Código morto e lixo no projeto:** pastas `Backup/` dentro de `lib/`, dezenas de `analysis_*.txt` e `build_log*.txt` na raiz, `antigravity-awesome-skills`, `brain`, `.agent`. Não há git.
20. **Cobertura de testes mínima** (2 arquivos) e `Provider.of(context)` sem `Selector` em telas grandes (ex.: `hoje_tab.dart` escuta 4 providers inteiros e reconstrói tudo a cada mudança).
21. **Carregamento duplicado:** `HomePage` recarrega `confession`, `prayer` e `settings`, que já foram carregados no Splash.
22. Strings de conteúdo (novenas) em ARB com mais de 1.800 linhas por idioma e `app_localizations*.dart` com cerca de 16 mil linhas geradas. Funciona, mas é pesado de manter. Conteúdo longo em JSON/assets seria mais simples.

## 2. Proposta em fases

### Fase 1 — Polimento rápido (1–2 semanas)
- Remover telas legadas e a pasta `Backup/`; criar repositório git (com `.gitignore` para os `analysis_*`/`build_log*`).
- Cortar o tempo de abertura: splash de ~0,8 s, sem delays artificiais no `MainScaffold`, reagendar lembretes em segundo plano.
- Renomear abas e trocar ícones: **Hoje · Orações · Novenas · Terço · Exame**.
- Esconder tudo o que for "Em breve".
- Receiver de boot + orientação de bateria/alarme exato.
- Tema escuro e ajuste de tamanho de fonte nas telas de oração.

### Fase 2 — Uso diário (2–4 semanas)
- Nova aba **Hoje**: tempo litúrgico, orações pendentes, novena ativa, próximo lembrete, terço do dia com um toque.
- Onboarding de 3 telas (escolha de intenções → horários → permissão de notificação com explicação).
- Criar lembrete com "atalhos" ("Manhã 7h", "Noite 21h") e deixar o modo avançado atrás de "Mais opções".
- Terço: mistério do dia pré-selecionado, contador de contas, tela sempre acesa.
- Marcar oração como rezada ao final de qualquer texto de oração.

### Fase 3 — Confiança e retenção (4–6 semanas)
- Confissão: biometria, bloqueio automático, senha com salt/KDF e `flutter_secure_storage`.
- Backup criptografado e lembrete de backup; opcionalmente exportação para a nuvem do usuário.
- Revisar o paywall (preço real, período de teste, restaurar compras, termos/privacidade reais). Integração real do RevenueCat com chaves e entitlement `premium`.
- Testes: lógica do calendário litúrgico, `ReminderService` (cálculo de próxima data) e migração do banco.
- Acessibilidade: `Semantics`, contraste, escala de fonte até 200%.

## 3. Prioridade sugerida

| # | Item | Impacto | Esforço |
|---|------|---------|---------|
| 1 | Cortar delays de abertura | Alto | Baixo |
| 2 | Limpar telas duplicadas e renomear abas | Alto | Baixo |
| 3 | Receiver de boot e orientação de notificações | Alto | Médio |
| 4 | Aba "Hoje" + onboarding | Alto | Médio |
| 5 | Tema escuro e fonte ajustável | Médio | Médio |
| 6 | Segurança da senha, biometria e backup criptografado | Alto | Médio |
| 7 | Lembretes simplificados | Médio | Médio |
| 8 | Testes e acessibilidade | Médio | Médio |

Posso começar pela Fase 1 se você quiser. Os itens 1 e 2 são seguros e rápidos de fazer.

---

## Roteiro de conteúdo e Jardim (fases)

1. **Fase 1 – Orações essenciais** (feita): Sacramentos (Ato de Contrição, Confiteor, antes/depois da Confissão e da Comunhão, Atos de Fé/Esperança/Caridade, Tantum Ergo), Salmos (50, 129, 22, Magnificat), Devoções (Via-Sacra, Terço da Misericórdia), Memorare, São Miguel, Eterno Descanso, Graças depois das refeições.
2. **Fase 2 – "Fui à missa"** (feita): botão em Hoje, registro no banco/backup/relatório, flor dourada no Jardim, efeito (pétalas + vibração).
3. **Fase 3 – Mapa de calor como jardim** (feita): canteiros, broto→flor, rosa/lírio/vela/flor dourada, faixas de intensidade fixas, legenda maior, detalhes do dia.
4. **Fase 4 – Novenas do calendário** (feita): Aparecida, Fátima, Misericórdia, Santo Antônio, Santa Rita, Cristo Rei, Advento (O Antífonas) e sugestão de início no tempo certo.
5. **Fase 5 – Santos, ladainhas e consagrações** (estrutura feita; textos provisórios, ver TEXTOS_PROVISORIOS.md): Santo Antônio, São Bento, São Francisco, Santa Rita, Padre Pio etc.; ladainhas do Sangue, Sacramento, Anjos, Humildade, Boa Morte; consagrações.
6. **Fase 6 – Funções extras** (feita, exceto biografia do santo do dia): intenções de oração, guia da missa e da adoração, santo do dia, cores litúrgicas no Jardim.

---

## Roteiro 2 (terço, aba Hoje, criação de orações, textos e ícones)

1. **Fase 1 – Terço × Rosário** (feita): "Terço completo" ao fim de cada terço; Rosário completo = 3 terços (modo tradicional) ou 4 (modo atual), por dia; progresso na tela do Terço; registro "Rosário completo" automático (e desfeito se um terço for apagado).
2. **Fase 2 – Textos no padrão tradicional** (feita): revisar todas as orações (Glória, "Ó meu Jesus…" de Fátima, Pai-Nosso, Ave-Maria, etc.) no catálogo e na tela do terço, em português e inglês.
3. **Fase 3 – Ícones católicos** (feita): trocar ícones sem relação com a fé (meditação de pernas cruzadas, lótus/"spa") por símbolos católicos.
4. **Fase 4 – Aba Hoje** (feita): reorganizar os registros (orações, novenas, penitência, missa) em seções claras.
5. **Fase 5 – Criar/adicionar oração** (feita): unificar o fluxo do "+" em Hoje, do Calendário e dos Lembretes.

---

## Roteiro 3 (Calendário e Lembretes)

1. **Fase 1 – Calendário: visual e leitura do dia** (feita): grade em cartão com legenda, dia escolhido/hoje distintos, botão "Hoje", arrastar troca de mês, registro do dia unificado (oração, terço, novena, missa, confissão) com atalhos de adicionar/marcar. O registro agora usa o mesmo componente da aba Hoje (`day_record.dart`).
2. **Fase 2 – Calendário: panorama** (feita): resumo do mês (dias com oração, missas, confissões), próximos eventos (festas, novenas e confissão planejada) e toque na festa/novena para detalhes.
3. **Fase 3 – Lembretes: organização** (feita): resumo e lista no estilo do app, agrupados por tipo, textos corrigidos (ex.: "Abstinence" em português), estado vazio coerente.
4. **Fase 4 – Lembretes: criação e ajustes** (feita): janela de edição mais simples, cartão do calendário litúrgico e da saúde das notificações reorganizados.
