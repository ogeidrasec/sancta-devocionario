# Plano: app gratuito com doações (F-Droid primeiro)

Objetivo: app **gratuito**, sem bloqueios, com pedido discreto de **doação ou oração** para ajudar nas despesas do casamento. Primeiro no **F-Droid** (e em um APK no GitHub); a Play Store depois.

## Pontos importantes antes de começar
- **O F-Droid só aceita apps de código aberto.** O código precisa ficar **público** (GitHub, GitLab, Codeberg), com uma licença livre (GPL-3.0 é a mais comum; MIT/Apache também servem). Qualquer pessoa poderá ver e copiar o código. Os textos e imagens também precisam poder ser distribuídos (ver `TEXTOS_ORIGEM.md`).
- **O F-Droid não aceita bibliotecas não livres.** O `purchases_flutter` (RevenueCat / Google Play Billing) precisa sair. Como o app passa a ser gratuito, ele sai junto com o paywall e o "premium".
- **O F-Droid compila o app ele mesmo** a partir do código e assina com a chave dele. A sua chave de upload continua servindo para o APK do GitHub e para a Play.
- **Doações no F-Droid:** são permitidas. A ficha do app tem campos próprios para links de doação (Liberapay, Open Collective, Bitcoin etc.).
- **Play Store e App Store:** as regras de pagamento das duas costumam **proibir pedir doação por link externo (PIX, cartão, cripto)** para pessoa física, liberando só para instituições de caridade reconhecidas ou via pagamento da própria loja. Por isso o plano prevê uma **chave** para esconder os links de doação na versão das lojas e deixar só o pedido de oração. Confira a política vigente antes de publicar lá.
- **Privacidade do PIX:** use uma **chave aleatória** ou um e-mail próprio para o app, **nunca o CPF**. A chave fica visível para todos que abrirem a página.

## Estrutura das doações (para você só preencher)
Um único arquivo, `lib/config/donation_config.dart`, com cada forma de doação **opcional**: o que ficar vazio não aparece no app.

| Forma | Para quem | Como aparece no app |
|---|---|---|
| **PIX** | Brasil | Chave com botão "copiar", **QR Code** e "PIX copia e cola", gerados no próprio aparelho (sem internet) |
| **Cartão** | Internacional | Botão para a página no **Ko-fi** (cartão e PayPal): ko-fi.com/sanctadevocionario ✅. Funciona com qualquer plataforma por link |
| **Cripto** | Internacional | Endereço de cada moeda que você quiser (ex.: Bitcoin, USDT/Ethereum), com QR e botão "copiar" |
| **Oração** | Todos | "Vou rezar pelos noivos": um botão que registra a promessa e agradece (sem dinheiro envolvido) |

O Buy Me a Coffee **não aceita PIX**. Por isso o PIX fica separado e o Buy Me a Coffee cuida do cartão.

## Fases
**Fase 1 — Menu reorganizado** ✅
- Guia da Missa, Adoração Eucarística e Intenções saíram do menu lateral e foram para a aba **Orações**, numa seção "Guias e devoções".
- O menu lateral ficou só com **Sobre o Projeto** e **Configurações**.
- Corrigido: o cabeçalho do menu estourava a altura com o nome novo, mais longo.

**Fase 2 — App 100% gratuito e página "Apoie o projeto"** ✅
- Remover paywall, "premium" e RevenueCat; tudo liberado.
- Criar `donation_config.dart` (com placeholders) e a página **Apoie o projeto**: a história do projeto (casamento), PIX, cartão, cripto e oração.
- Acesso pela página **Sobre o Projeto** (o menu continua com dois itens).
- Chave de build para esconder os links de pagamento na versão das lojas.

**Fase 3 — Lembrete gentil de tempos em tempos** ✅
- Um cartão discreto na aba **Hoje**, que nunca aparece durante uma oração, o terço ou o Exame.
- Regras: não aparece nos primeiros 3 dias de uso; depois, 1 dia por mês (desde 19/11/2026; antes era a cada 14 dias).
- Botões **Apoiar**, **Vou rezar por vocês** e **Agora não**. Quem disser que já apoiou não vê o cartão por 90 dias.

**Fase 4 — Boas-vindas** ✅
- Refazer a apresentação do primeiro uso: o que o app faz, privacidade (tudo fica no celular), o projeto do casamento, a permissão de notificações e o atalho para o guia.

**Fase 5 — Guia de uso dentro do app** ✅ (feito antes da Fase 4: tour guiado, pelo menu › Guia do app)
- Página **Como usar**, por aba (Hoje, Calendário, Lembretes, Orações, Terço, Novenas, Exame), com explicações curtas.
- Acesso pelas boas-vindas e por **Sobre o Projeto**; atalho "?" opcional nas abas.

**Fase 6 — Publicação no F-Droid e no GitHub** (preparada; veja PUBLICACAO_FASE6.md)
- Escolher a licença e publicar o repositório.
- Conferir que nenhuma dependência é não livre.
- Ficha do app no formato do F-Droid (descrições, capturas, links de doação).
- APK assinado no GitHub Releases.
- Pedido de inclusão no `fdroiddata` (o F-Droid revisa e compila; costuma levar semanas).

## O que preciso de você (pode ser aos poucos)
1. **Chave PIX** (aleatória ou e-mail) e o **nome do recebedor** como aparece no banco.
2. ~~Link do Ko-fi~~ ✅ (ko-fi.com/sanctadevocionario)
3. **Moedas cripto**: Bitcoin ✅ (bc1q…zk4e); outras moedas, se quiser.
4. Um **texto curto sobre o casamento** (nomes, data, se quiser), ou eu escrevo um rascunho.
5. A **licença** do código (sugiro GPL-3.0).
