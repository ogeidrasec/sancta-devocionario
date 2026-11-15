# Manual: substituir os textos provisórios das orações

Na Fase 5 foram criados 16 itens (santos, ladainhas e consagrações) com **texto de exemplo**: "[TEXTO PROVISÓRIO] Este é um texto de exemplo…". O título, o ícone, a categoria e as traduções já existem. Falta só colocar o texto original de cada oração.

Tudo se resolve editando **dois arquivos de texto**, um por idioma, e rodando um comando. Não é preciso mexer em código (exceto para incluir latim, ver o passo 5).

---

## Resumo em 6 passos

1. Abrir os dois arquivos de tradução.
2. Localizar a chave do item (`prayer<Nome>Content`).
3. Trocar o texto de exemplo pelo texto original, no formato correto.
4. Fazer o mesmo no outro idioma.
5. (Opcional) Acrescentar a versão em latim.
6. Gerar, testar e conferir no app.

---

## Onde corrigir

| Arquivo | Idioma |
|---|---|
| `lib/l10n/app_pt.arb` | Português |
| `lib/l10n/app_en.arb` | Inglês |

Abra os dois (VS Code ou outro editor de texto, **salvando sempre em UTF-8**, para os acentos ficarem corretos).

### Tabela dos itens

Procure a chave na tabela, depois procure essa chave nos dois arquivos (Ctrl+F). O título do item fica na chave com o mesmo nome terminando em `Title`.

| Item no app | Categoria | Chave do texto |
|---|---|---|
| Oração da Paz (São Francisco) | Devoções aos Santos | `prayerStFrancisPeaceContent` |
| Medalha de São Bento | Devoções aos Santos | `prayerStBenedictMedalContent` |
| Fica comigo, Senhor (São Padre Pio) | Devoções aos Santos | `prayerStPioStayContent` |
| Nada te perturbe (Santa Teresa d'Ávila) | Devoções aos Santos | `prayerStTeresaAvilaContent` |
| Tarde Te amei (Santo Agostinho) | Devoções aos Santos | `prayerStAugustineContent` |
| Oração a Santo Antônio | Devoções aos Santos | `prayerStAnthonyContent` |
| Oração a Santa Rita de Cássia | Devoções aos Santos | `prayerStRitaContent` |
| Ladainha da Humildade | Ladainhas | `prayerLitanyHumilityContent` |
| Ladainha do Preciosíssimo Sangue | Ladainhas | `prayerLitanyPreciousBloodContent` |
| Ladainha do Santíssimo Sacramento | Ladainhas | `prayerLitanyBlessedSacramentContent` |
| Ladainha dos Santos Anjos | Ladainhas | `prayerLitanyHolyAngelsContent` |
| Ladainha da Boa Morte | Ladainhas | `prayerLitanyGoodDeathContent` |
| Totus Tuus (consagração a Maria) | Consagrações | `prayerConsecTotusTuusContent` |
| Consagração a Jesus por Maria (São Luís de Montfort) | Consagrações | `prayerConsecMontfortContent` |
| Consagração ao Sagrado Coração de Jesus | Consagrações | `prayerConsecSacredHeartContent` |
| Consagração a São José | Consagrações | `prayerConsecStJosephContent` |

**Dica para achar tudo que falta:** pesquise por `TEXTO PROVISÓRIO` em `app_pt.arb` e por `PLACEHOLDER TEXT` em `app_en.arb`. Quando a pesquisa não encontrar mais nada, terminou.

---

## Passo a passo

### Passo 1: abrir o item

No `app_pt.arb`, pesquise a chave, por exemplo `prayerStFrancisPeaceContent`. A linha é assim:

```json
"prayerStFrancisPeaceContent": "[TEXTO PROVISÓRIO] Este é um texto de exemplo. Substitua-o pelo texto original de \"Oração da Paz (São Francisco)\".",
```

### Passo 2: trocar o texto

Troque **somente o que está entre as aspas depois dos dois-pontos**. Mantenha a chave, as aspas e a vírgula no final.

```json
"prayerStFrancisPeaceContent": "Senhor, fazei de mim um instrumento de vossa paz.\nOnde houver ódio, que eu leve o amor.\n...",
```

### Passo 3: regras de formatação (importante)

O arquivo é JSON. Estas regras evitam erro:

| Quero | Escrevo |
|---|---|
| Quebra de linha | `\n` |
| Linha em branco entre parágrafos | `\n\n` |
| Aspas dentro do texto | `\"` (barra antes) |
| Barra invertida | `\\` |
| Chaves `{` ou `}` | **Não usar.** O sistema de tradução entende chaves como variável. |
| Apóstrofo (d'Ávila) | Pode usar normalmente. |
| Acentos e travessão | Podem usar normalmente (arquivo em UTF-8). |

- O texto deve ficar **todo em uma linha só** do arquivo, usando `\n` para separar as linhas da oração. Não aperte Enter dentro das aspas.
- Para uma **ladainha**, cada invocação fica em uma linha usando `\n`, e os blocos separados por `\n\n`. Exemplo:

```json
"prayerLitanyHumilityContent": "Ó Jesus, manso e humilde de coração, ouvi-me.\nDo desejo de ser estimado, livrai-me, Jesus.\n...\n\nPara que os outros sejam mais amados do que eu, Jesus, dai-me a graça de o desejar.",
```

> Dica prática: escreva a oração em um editor comum, depois troque cada Enter por `\n` (Localizar e substituir) antes de colar entre as aspas.

### Passo 4: repetir no inglês

Faça o mesmo em `app_en.arb`, **com a mesma chave**. Se preencher só um idioma, o outro continua mostrando o texto de exemplo no app.

Se não tiver a tradução oficial em inglês, cole o texto original no idioma que tiver, temporariamente, e volte depois.

### Passo 5 (opcional): acrescentar o latim

Orações como a Medalha de São Bento ou o Totus Tuus ficam bonitas com o latim. Para isso:

1. Em **`app_pt.arb` e `app_en.arb`**, crie uma chave nova, logo abaixo da chave do conteúdo, com o mesmo nome terminando em `ContentLatin`:

```json
"prayerStBenedictMedalContent": "...",
"prayerStBenedictMedalContentLatin": "Crux sacra sit mihi lux,\nnon draco sit mihi dux.\n...",
```

(O mesmo texto latino nos dois arquivos.)

2. Em **`lib/data/prayer_data.dart`**, procure o item (pelo `id`, por exemplo `'st_benedict_medal'`), na seção "Fase 5", e acrescente uma linha igual à que as outras orações já têm:

```dart
      {
        'id': 'st_benedict_medal',
        'title': l10n.prayerStBenedictMedalTitle,
        'content': l10n.prayerStBenedictMedalContent,
        'contentLatin': l10n.prayerStBenedictMedalContentLatin,   // <- nova linha
        'icon': Icons.shield_outlined,
        'category': 'saints'
      },
```

Com isso, a tela da oração passa a mostrar o latim junto do texto.

### Passo 6: gerar, testar e conferir

No terminal, na pasta do projeto:

```bash
flutter gen-l10n
```

```bash
flutter test test/translations_test.dart
```

Depois rode o app (ou faça Hot Restart) e abra **Orações → categoria → oração** para ver o resultado.

O teste `translations_test.dart` confirma que as duas línguas têm as mesmas chaves, que não há chave repetida e que não sobrou texto escrito direto no código.

### Passo 7: registrar

Quando terminar uma ou várias orações, faça o commit:

```bash
git add -A
git commit -m "Textos originais das orações da Fase 5"
```

---

## Se der erro

| Sintoma | Causa provável | O que fazer |
|---|---|---|
| `flutter gen-l10n` mostra "ICU Syntax Error" ou "Unexpected token" | Há `{` ou `}` no texto | Retire as chaves do texto |
| Erro de JSON / "Expecting ',' delimiter" | Faltou vírgula no fim da linha, faltou fechar aspas, ou aspas sem `\` dentro do texto | Confira a vírgula no final e troque `"` por `\"` dentro do texto |
| Teste reclama de "chave repetida" | A mesma chave aparece duas vezes (ao copiar/colar) | Mantenha só uma linha por chave |
| Teste reclama de "chave sem tradução" | Criou uma chave (por exemplo a de latim) em um arquivo só | Crie nos dois arquivos |
| O app continua mostrando "TEXTO PROVISÓRIO" | Não rodou `flutter gen-l10n`, ou fez só Hot Reload | Rode `flutter gen-l10n` e depois Hot Restart |
| Acentos estranhos (Ã§, Ã£) | O arquivo foi salvo em outra codificação | Reabra e salve como UTF-8 |

---

## Outros textos que merecem revisão

Estes já têm texto completo, mas foram escritos de memória e precisam ser conferidos com fonte oficial (Missal, Compêndio do Catecismo, Manual de Orações aprovado). A correção é feita do mesmo jeito: editar a chave nos dois arquivos `.arb` e rodar `flutter gen-l10n`.

| Conteúdo | Prefixo das chaves |
|---|---|
| Fase 1: Ato de Contrição, Confiteor, antes e depois da Confissão e da Comunhão, Atos de Fé, Esperança e Caridade, Tantum Ergo | `prayerActContrition…`, `prayerConfiteor…`, `prayerBeforeConfession…`, `prayerAfterConfession…`, `prayerBeforeCommunion…`, `prayerAfterCommunion…`, `prayerTheologicalActs…`, `prayerTantumErgo…` |
| Fase 1: Salmos 50, 129 e 22, Magnificat | `prayerPsalm50…`, `prayerPsalm129…`, `prayerPsalm22…`, `prayerMagnificat…` |
| Fase 1: Via-Sacra, Terço da Divina Misericórdia | `prayerViaSacra…`, `prayerDivineMercyChaplet…` |
| Fase 1: Memorare, São Miguel, Eterno Descanso, Graças depois das refeições | `prayerMemorare…`, `prayerStMichael…`, `prayerEternalRest…`, `prayerGraceAfterMeals…` |
| Fase 4: novenas novas | `novenaAparecida…`, `novenaFatima…`, `novenaMisericordia…`, `novenaSantoAntonio…`, `novenaSantaRita…`, `novenaCristoRei…` |
| Fase 6: Guia da Missa (ordinária e tradicional) e Adoração | `massGuide…`, `adoration…` |

Dica: no editor, pesquise o prefixo (por exemplo `prayerPsalm50`) para ver o título, o conteúdo em português e o conteúdo em latim juntos.

Nos guias da Missa, uma linha que começa com `» ` (seta e espaço) é mostrada como latim em destaque. Mantenha esse marcador ao editar esses textos.
