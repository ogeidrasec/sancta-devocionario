# Plano de publicação — Sancta Devocionário Católico (Play Store e, depois, App Store)

Legenda: **[EU]** = posso fazer no código/arquivos do projeto · **[VOCÊ]** = precisa da sua conta, documento, decisão ou aparelho.
Valores e regras das lojas mudam; confira cada item na página oficial antes de agir.

## Situação atual do projeto (o que encontrei)
| Item | Estado | Impacto |
|---|---|---|
| Assinatura do release | Usa a chave de **debug** (`android/app/build.gradle.kts`) | A Play Store **recusa**. Precisa de chave própria |
| Chaves do RevenueCat | `goog_placeholder_key` / `appl_placeholder_key` | Com placeholders, o premium fica **liberado para todos** (`kPremiumBypass`). Liga sozinho a cobrança quando as chaves reais entram |
| Versão | `1.0.0+1` | Ok para a primeira versão |
| ID do aplicativo | `br.com.sancta.devocionario` | **Definido em 15/11/2026. Não muda depois de publicar** |
| Nome na loja | Manifesto diz "Sancta Devocionário"; o app se chama "Sancta Devocionário Católico" | Padronizar |
| Permissões | `SCHEDULE_EXACT_ALARM`, notificações, boot, vibração, wake lock | A Play exige justificativa para alarmes exatos (ver Fase 2) |
| Política de privacidade / termos | Não encontrei | **Obrigatório** nas duas lojas |
| Tela de compra (paywall) | Existe (`paywall_page.dart`) | Revisar exigências das lojas (Fase 3) |

---

## Fase 0 — Decisões de negócio (antes de qualquer coisa) [VOCÊ]
1. **O que é grátis e o que é pago.** Recomendo *freemium*: orações essenciais, terço, exame básico e lembretes grátis; premium com recursos extras (novenas completas, Guia da Missa, jardim/heatmap, backup, temas, etc.). App 100% bloqueado converte pouco, porque ninguém paga sem conhecer.
2. **Preço (sugestão para o Brasil):** mensal **R$ 9,90**, anual **R$ 79,90** (~33% de desconto, ajuda a reter) e **7 dias de teste grátis**. O plano anual costuma render mais receita por usuário. Dá para ajustar por país depois.
3. **Quem é o vendedor:** pessoa física ou CNPJ (MEI serve para começar). Isso afeta imposto, conta de pagamento e o nome que aparece na loja. Converse com um contador sobre o enquadramento da receita de assinaturas.
4. **Nome público e e-mail de suporte** (aparecem na loja).
5. **Conteúdo e direitos.** Veja a Fase 1, item "Conteúdo": é o maior risco jurídico de um app religioso pago.

Conta de receita (ordem de grandeza, sem promessa): a Google fica com 15% das assinaturas. Com 1.000 assinantes a R$ 9,90/mês, entram cerca de R$ 8.400/mês antes de imposto. Em apps freemium, em geral só uma pequena parte dos usuários paga (da ordem de 2% a 5%), então o número de downloads importa tanto quanto o preço.

---

## Fase 1 — App pronto para release (técnico) [EU, com revisão sua]
1. **Assinatura de release**: gerar o *upload keystore*, criar `android/key.properties` (fora do Git) e configurar o `build.gradle.kts`. Usar *Play App Signing*. [EU monto a configuração; **VOCÊ guarda o keystore e a senha em lugar seguro, com cópia**. Perder a chave de upload dá muito trabalho para recuperar.]
2. **Desligar o bypass do premium**: com as chaves reais do RevenueCat o bypass já desliga. Acrescentar um teste/guarda que **falhe o build de release** se ainda houver placeholder. [EU]
3. **Versão e nome**: padronizar "Sancta Devocionário Católico" no manifesto, no iOS e nas lojas; definir regra de versionamento. [EU]
4. **Ícone e splash** nas resoluções certas (ícone adaptativo no Android). [EU confiro; arte final **VOCÊ**]
5. **Permissões**: avaliar trocar `SCHEDULE_EXACT_ALARM` por alarmes aproximados. Se mantiver, preencher a declaração na Play explicando que o lembrete de oração é o recurso central. [EU analiso e ajusto]
6. **Redução e ofuscação** (R8) e conferência de tamanho do pacote. Gerar `.aab` e testar o release real (não só debug). [EU]
7. **Teste em aparelho real**, que ainda não foi feito: abertura, vibração, pétalas, lembretes tocando com o app fechado e após reiniciar o celular, bateria/otimização (Xiaomi, Samsung etc.), rolagem, textos grandes. [VOCÊ, com roteiro que eu preparo]
8. **Backup e perda de dados**: lembretes ainda fora do backup; avisar o usuário o que acontece ao trocar de celular. [EU]
9. **Conteúdo**: confirmar a origem e a licença de cada texto (orações, Missal, Bíblia, textos escritos de memória, cantos, imagens, fontes). Textos litúrgicos de edições atuais (Missal Romano, CNBB, traduções da Bíblia) costumam ter **direitos autorais**. Prefira domínio público, versões livres ou autorização escrita. Considere revisão de um sacerdote ou leitor católico qualificado. [VOCÊ, com a lista que eu gero]

## Fase 2 — Pacote jurídico e de privacidade [VOCÊ, com minhas minutas]
1. **Política de privacidade** em uma URL pública (pode ser uma página no GitHub Pages ou site simples). O Exame de Consciência guarda dados sensíveis. Deixe claro que ficam **só no aparelho**, que não são enviados, como funciona a senha, o backup e como apagar tudo. Se usar RevenueCat ou analytics, dizer que o ID de compra é tratado por eles. [EU redijo a minuta; você revisa]
2. **Termos de uso** (assinatura, renovação automática, cancelamento, reembolso conforme a loja). [EU minuta]
3. **Formulário "Segurança dos dados"** da Play (Data safety): o que o app coleta/compartilha. [EU preencho a tabela; VOCÊ envia]
4. **Classificação indicativa** (questionário): conteúdo sobre pecados/penitência deve ser informado de forma honesta. Público: geral, **não** direcionado a crianças.
5. **Declaração de permissões** (alarmes exatos, notificações).
6. **Exclusão de dados**: o app já apaga tudo no aparelho. Como não há conta, a exigência de exclusão de conta não se aplica; descrever isso nas respostas.

## Fase 3 — Monetização (RevenueCat + Play Billing) [VOCÊ no painel, EU no código]
1. Criar a conta na **Google Play Console** (taxa única de **US$ 25**, verificação de identidade; contas pessoais novas passam por exigências extras de teste, ver Fase 5).
2. Criar o app na Play Console e **subir um primeiro `.aab`** para a faixa de teste interno (a Play só libera criar assinaturas depois disso).
3. Criar os produtos de assinatura (mensal, anual), com períodos de teste e preços por país.
4. Criar a conta no **RevenueCat** (gratuito até um faturamento mensal considerável), ligar à Play com a credencial de serviço, criar o *entitlement* `premium` e a *offering* com os dois pacotes.
5. Colocar a **chave pública real do Android** no app. [EU]
6. **Paywall conforme as regras das lojas** [EU]: mostrar preço e período claramente, informar teste grátis e renovação automática, botão **Restaurar compras**, links para Termos e Privacidade, como cancelar. Garantir que o app grátis seja realmente utilizável.
7. **Testar compras** com contas de teste de licença (*license testers*): compra, cancelamento, renovação, reembolso, restaurar em outro aparelho, estado sem internet. [VOCÊ e EU]

## Fase 4 — Ficha na loja (Store listing) [VOCÊ com textos meus]
- Título (até 30 caracteres), descrição curta (80), descrição longa (4.000), em **português e inglês**. [EU escrevo]
- Ícone 512×512, imagem de destaque 1024×500, **screenshots** de celular (mínimo 2; recomendo 6–8). Eu já gero capturas pelo teste de screenshots; ajustamos para a loja. [EU]
- Categoria: *Estilo de vida* ou *Livros e referências*. E-mail de contato e URL da política.
- Evitar frases que prometam "perdão de pecados" ou resultados espirituais garantidos e não usar nomes/marcas de terceiros sem permissão.

## Fase 5 — Testes obrigatórios e lançamento [VOCÊ]
1. **Teste interno** (você e poucos amigos) para validar o fluxo de compra.
2. **Teste fechado**: contas pessoais novas na Play costumam precisar de um grupo mínimo de testadores (hoje, em geral **12 pessoas por 14 dias seguidos**) antes de pedir produção. Confirme a regra vigente na Play Console. Comece a recrutar cedo (grupo da paróquia, amigos, pastorais).
3. Corrigir o que os testadores acharem. Verificar *pre-launch report* da Play (crashes em aparelhos variados).
4. **Pedir acesso à produção**, subir o `.aab` final e iniciar a **liberação gradual** (por exemplo 10%, depois 50%, depois 100%).
5. A primeira revisão pode levar de poucos dias a cerca de uma semana.

## Fase 6 — Depois do lançamento
- Monitorar falhas (Play Console → Android vitals; considerar Firebase Crashlytics se aceitar o ponto de privacidade).
- Responder avaliações, publicar atualizações regulares (calendário litúrgico, novas novenas).
- Medir: instalações, conversão para teste grátis, conversão para pago, cancelamentos (RevenueCat mostra).
- Aquisição: paróquias, pastorais, redes católicas, Instagram/YouTube, parceria com influenciadores católicos, ASO (palavras-chave: terço, novena, exame de consciência, missa).
- Ajustar preço e plano anual conforme os números.

## Fase 7 — App Store (Apple), depois do Android estável
| Requisito | Detalhe |
|---|---|
| Conta | Apple Developer Program, cerca de **US$ 99/ano** |
| Computador | Compilar e enviar exige **macOS + Xcode**. Sem Mac, dá para usar CI na nuvem (ex.: Codemagic, GitHub Actions macOS) |
| Assinaturas | Criadas no App Store Connect; ligar ao RevenueCat com a chave `appl_` e a chave de API da App Store |
| Comissão | Programa *Small Business* reduz a comissão da Apple a 15% para quem fatura até US$ 1 mi/ano |
| Revisão | Mais rigorosa: paywall com preço e renovação claros, botão restaurar, política de privacidade, "rótulos de privacidade", permissões com texto de justificativa |
| Ajustes de código [EU] | Revisar `ios/` (Info.plist, ícones, notificações, textos de permissão), testar lembretes locais no iOS, ajustar vibração e pétalas |
| Testes | TestFlight com testadores antes de lançar |

---

## Ordem sugerida e prazos aproximados
1. **Semana 1:** Fase 0 (decisões) + Fase 1 (assinatura, nomes, bypass, permissões) + abrir a conta Play (verificação demora).
2. **Semana 2:** Fase 2 (privacidade/termos) + Fase 3 (RevenueCat, produtos, paywall).
3. **Semana 3:** Fase 4 (ficha) + teste interno e início do teste fechado.
4. **Semanas 4–5:** teste fechado (período mínimo exigido) e correções.
5. **Semana 6:** produção com liberação gradual.
6. **Depois:** iOS (Fase 7).

## Riscos que merecem atenção
- **Direitos autorais dos textos litúrgicos** (Fase 1, item 9). É o ponto que pode impedir a venda.
- **Chave de assinatura perdida** ou o **ID do app** errado: não têm volta fácil.
- **Alarmes exatos** podem ser recusados pela Play sem boa justificativa.
- **Premium liberado por engano** se alguém lançar com placeholders (por isso o guarda do build).
- **Dados sensíveis do Exame**: manter tudo local e comunicar isso com clareza.
- **Expectativa de receita**: o retorno costuma crescer devagar; planeje atualizações e divulgação contínuas.

## Próximo passo sugerido
Posso iniciar a **Fase 1 [EU]** agora: configurar a assinatura de release, padronizar o nome, avaliar as permissões, criar o guarda contra placeholders no build de release e gerar o `.aab` de teste. Para isso preciso só de duas respostas: **o nome público** (Sancta Devocionário Católico?) e **o que será grátis e o que será premium**.
