# Revisão dos textos do app

Lista gerada a partir de `lib/l10n/app_pt.arb` com os textos de 120 caracteres ou mais (326 textos; o inglês, `app_en.arb`, segue as mesmas chaves). Nenhum deles tinha fonte confirmada.

Não é parecer jurídico. Em caso de dúvida sobre um texto, troque por uma versão sabidamente livre ou peça licença a quem publicou.

## Como revisar

1. Comece pelas seções de **prioridade 1** (risco maior), depois a 2 e por fim a 3, que pode ser confirmada em bloco.
2. Em cada linha, troque `☐` por uma decisão e preencha a fonte:
   - `✅` fica como está (diga a fonte: livro e edição, site, "domínio público", "escrito por mim").
   - `✏️` trocar o texto (me diga por qual, ou peça que eu busque uma versão em domínio público).
   - `🗑️` remover do app.
3. Me devolva o arquivo (ou só as linhas com ✏️ e 🗑️) que eu aplico as mudanças.

**Regra prática:** o texto original de um santo ou de um documento antigo costuma ser domínio público (autor morto há mais de 70 anos). O problema costuma ser a **tradução** ou a **edição** moderna de onde o texto foi copiado (livros de editoras, sites, a tradução oficial da CNBB).

## Resumo

| Seção | Prioridade | Textos | O que fazer |
|---|---|---|---|
| [Bíblia e textos do Missal (português)](#salmo) | 1 | 10 | Salmos, Magnificat e Evangelhos dos mistérios luminosos: diga de qual Bíblia vieram (livre: a tradução do Pe. Antônio Pereira de Figueiredo; a de Matos Soares, †1957, só entra em domínio público em 2028). O Confiteor está na tradução oficial do Missal (CNBB), que tem direitos. |
| [Ladainhas (português)](#ladainha) | 1 | 11 | Dizer de onde veio a tradução; o latim é domínio público. |
| [Novenas](#novena) | 1 | 136 | Dizer de onde veio cada novena (livro, site, paróquia). Revise por novena, não por linha. |
| [Mistérios do terço (oferecimentos e resumos)](#misterio) | 2 | 20 | Confirme se foram escritos para o app ou copiados de um livro ou site. |
| [Consagrações e orações de santos (português)](#santos) | 2 | 32 | O original costuma ser livre; confira a tradução. |
| [Orações tradicionais (português)](#tradicional) | 3 | 22 | Pai-Nosso, Ave-Maria, Credo etc.: textos de uso comum. Confirme em bloco. |
| [Textos em latim](#latim) | 3 | 33 | Liturgia e orações antigas: domínio público. Confirme em bloco. |
| [Textos escritos para o app](#proprio) | 3 | 62 | Ajuda, explicações, guia do app, página de apoio. Confirme em bloco. |

<a id="salmo"></a>
## Bíblia e textos do Missal (português) — prioridade 1

Salmos, Magnificat e Evangelhos dos mistérios luminosos: diga de qual Bíblia vieram (livre: a tradução do Pe. Antônio Pereira de Figueiredo; a de Matos Soares, †1957, só entra em domínio público em 2028). O Confiteor está na tradução oficial do Missal (CNBB), que tem direitos.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ✏️ trocado | `luminous1Full` |  | Então veio Jesus da Galileia ter com João ao Jordão, para ser batizado… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `luminous2Full` |  | E, ao terceiro dia, fizeram-se umas bodas em Caná da Galileia; e estav… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `luminous3Full` |  | E, depois que João foi entregue à prisão, veio Jesus para a Galileia, … | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `luminous4Full` |  | E, seis dias depois, Jesus tomou consigo a Pedro, a Tiago e a João, e … | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `luminous5Full` |  | No primeiro dia dos pães asmos, quando sacrificavam a Páscoa, pergunta… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerConfiteorContent` | Confiteor (Confesso a Deus) | Eu, pecador, confesso a Deus todo-poderoso, à bem-aventurada sempre Vi… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerPsalm50Content` | Salmo 50 (Miserere) | Tem piedade de mim, ó Deus, segundo a tua grande misericórdia. E segun… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerPsalm129Content` | Salmo 129 (De Profundis) | Das profundezas clamei a vós, Senhor; Senhor, escutai a minha voz. Est… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerPsalm22Content` | Salmo 22 (O Senhor é meu pastor) | O Senhor me governa, e nada me faltará: em um lugar de pastos ali me c… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerMagnificatContent` | Magnificat | A minha alma glorifica o Senhor, e o meu espírito se alegrou por extre… | Texto trocado por você em 15/11/2026. |

<a id="ladainha"></a>
## Ladainhas (português) — prioridade 1

Dizer de onde veio a tradução; o latim é domínio público.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `litanyLorettoContent` | Ladainha de Nossa Senhora (Lauretana) | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `litanySacredHeartContent` | Ladainha do Sagrado Coração de Jesus | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `litanyAllSaintsContent` | Ladainha de Todos os Santos | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `litanyStJosephContent` | Ladainha de São José | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `litanyHolyNameContent` | Ladainha do Santíssimo Nome de Jesus | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `litanySevenSorrowsContent` | Coroa de Nossa Senhora das Dores | Deus, vinde em meu auxílio. Senhor, apressai-Vos em me socorrer. Pai N… |  |
| ☐ | `prayerLitanyHumilityContent` | Ladainha da Humildade | Ó Jesus, manso e humilde de coração, ouvi-me. Do desejo de ser estimad… |  |
| ☐ | `prayerLitanyPreciousBloodContent` | Ladainha do Preciosíssimo Sangue | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `prayerLitanyBlessedSacramentContent` | Ladainha do Santíssimo Sacramento | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `prayerLitanyHolyAngelsContent` | Ladainha dos Santos Anjos | Senhor, tende piedade de nós. Cristo, tende piedade de nós. Senhor, te… |  |
| ☐ | `prayerLitanyGoodDeathContent` | Ladainha da Boa Morte | Senhor Jesus, Deus de bondade e Pai de misericórdia, apresento-me dian… |  |

<a id="novena"></a>
## Novenas — prioridade 1

Dizer de onde veio cada novena (livro, site, paróquia). Revise por novena, não por linha.

| Decisão | Novena | Textos | Começo do primeiro texto | Observação / fonte |
|---|---|---|---|---|
| ✏️ trocada (11 textos) | Novena a São Carlo Acutis (`novenaCarloAcutis…`) | 11 | Ó Deus eterno e misericordioso, que manifestais a vossa glór… | Recente: provavelmente tem direitos. |
| ☐ | Novena das Rosas (`novenaTeresa…`) | 7 | Santíssima Trindade, Pai, Filho e Espírito Santo, eu Vos agr… |  |
| ☐ | Novena ao Sagrado Coração (`novenaSagradoCoracao…`) | 11 | Lembrai-vos, ó dulcíssimo Jesus, que nunca se ouviu dizer qu… |  |
| ☐ | Novena à Imaculada Conceição (`novenaConceicao…`) | 11 | Vinde, Espírito Santo, enchei o coração dos vossos fiéis e a… |  |
| ☐ | Novena de Natal (`novenaNatal…`) | 9 | DEUS NOS DEU SEU FILHO UNIGÊNITO POR SALVADOR Eu te constitu… | S. Afonso (†1787) é livre; confira a tradução. |
| ☐ | Novena a São José (`novenaSaoJose…`) | 12 | Para alcançar graças e a proteção de São José, pai nutrício … |  |
| ☐ | Novena a São Judas Tadeu (`novenaSaoJudas…`) | 10 | Oração: São Judas glorioso, apóstolo fiel e mártir de Jesus … |  |
| ☐ | Novena de Pentecostes (`novenaPentecostes…`) | 9 | Vinde, Espírito Santo! Enchei os corações dos Vossos fiéis e… |  |
| ☐ | Novena a N. S. do Perpétuo Socorro (`novenaPerpetuoSocorro…`) | 8 | Ó Santíssima Virgem Maria, que para inspirar-nos confiança d… | Se veio dos Redentoristas, tem direitos. |
| ☐ | Novena a São Miguel Arcanjo (`novenaSaoMiguel…`) | 8 | São Miguel Arcanjo, defendei-nos no combate; sede o nosso re… |  |
| ☐ | Novena pelas Almas do Purgatório (`novenaAlmas…`) | 10 | Senhor meu Jesus Cristo, Redentor nosso, que Vos dignastes d… |  |
| ☐ | Novena a Nossa Senhora Aparecida (`novenaAparecida…`) | 9 | Ó Virgem Imaculada, Mãe de Deus e minha Mãe, Senhora Apareci… | Se veio do site do Santuário ou da CNBB, tem direitos. |
| ☐ | Novena a Nossa Senhora de Fátima (`novenaFatima…`) | 5 | Ó Virgem de Fátima, Mãe do Céu, que viestes ao mundo para pe… |  |
| ☐ | Novena da Divina Misericórdia (`novenaMisericordia…`) | 4 | Começa na Sexta-feira Santa e termina no sábado antes da Fes… | Do Diário de S. Faustina: confira a tradução. |
| ☐ | Novena a Santo Antônio (`novenaSantoAntonio…`) | 4 | Glorioso Santo Antônio, doutor do Evangelho e amigo dos pobr… |  |
| ☐ | Novena a Santa Rita de Cássia (`novenaSantaRita…`) | 4 | Santa Rita, advogada das causas impossíveis, que levastes a … |  |
| ☐ | Novena a Cristo Rei (`novenaCristoRei…`) | 4 | Solenidade de Nosso Senhor Jesus Cristo, Rei do Universo, no… |  |

<details><summary>Todas as chaves das novenas</summary>

- **Novena a São Carlo Acutis**: `novenaCarloAcutisOpening`, `novenaCarloAcutisClosing`, `novenaCarloAcutisDay1Meditation`, `novenaCarloAcutisDay2Meditation`, `novenaCarloAcutisDay3Meditation`, `novenaCarloAcutisDay4Meditation`, `novenaCarloAcutisDay5Meditation`, `novenaCarloAcutisDay6Meditation`, `novenaCarloAcutisDay7Meditation`, `novenaCarloAcutisDay8Meditation`, `novenaCarloAcutisDay9Meditation`
- **Novena das Rosas**: `novenaTeresaOpening`, `novenaTeresaPrayers`, `novenaTeresaDay1Title`, `novenaTeresaDay3Title`, `novenaTeresaDay4Title`, `novenaTeresaDay7Title`, `novenaTeresaDay9Title`
- **Novena ao Sagrado Coração**: `novenaSagradoCoracaoOpening`, `novenaSagradoCoracaoClosing`, `novenaSagradoCoracaoDay1Meditation`, `novenaSagradoCoracaoDay2Meditation`, `novenaSagradoCoracaoDay3Meditation`, `novenaSagradoCoracaoDay4Meditation`, `novenaSagradoCoracaoDay5Meditation`, `novenaSagradoCoracaoDay6Meditation`, `novenaSagradoCoracaoDay7Meditation`, `novenaSagradoCoracaoDay8Meditation`, `novenaSagradoCoracaoDay9Meditation`
- **Novena à Imaculada Conceição**: `novenaConceicaoOpening`, `novenaConceicaoClosing`, `novenaConceicaoDay1Meditation`, `novenaConceicaoDay2Meditation`, `novenaConceicaoDay3Meditation`, `novenaConceicaoDay4Meditation`, `novenaConceicaoDay5Meditation`, `novenaConceicaoDay6Meditation`, `novenaConceicaoDay7Meditation`, `novenaConceicaoDay8Meditation`, `novenaConceicaoDay9Meditation`
- **Novena de Natal**: `novenaNatalDay1Meditation`, `novenaNatalDay2Meditation`, `novenaNatalDay3Meditation`, `novenaNatalDay4Meditation`, `novenaNatalDay5Meditation`, `novenaNatalDay6Meditation`, `novenaNatalDay7Meditation`, `novenaNatalDay8Meditation`, `novenaNatalDay9Meditation`
- **Novena a São José**: `novenaSaoJoseDesc`, `novenaSaoJoseOpening`, `novenaSaoJoseClosing`, `novenaSaoJoseDay1Meditation`, `novenaSaoJoseDay2Meditation`, `novenaSaoJoseDay3Meditation`, `novenaSaoJoseDay4Meditation`, `novenaSaoJoseDay5Meditation`, `novenaSaoJoseDay6Meditation`, `novenaSaoJoseDay7Meditation`, `novenaSaoJoseDay8Meditation`, `novenaSaoJoseDay9Meditation`
- **Novena a São Judas Tadeu**: `novenaSaoJudasOpening`, `novenaSaoJudasClosing`, `novenaSaoJudasDay1Meditation`, `novenaSaoJudasDay2Meditation`, `novenaSaoJudasDay3Meditation`, `novenaSaoJudasDay5Meditation`, `novenaSaoJudasDay6Meditation`, `novenaSaoJudasDay7Meditation`, `novenaSaoJudasDay8Meditation`, `novenaSaoJudasDay9Meditation`
- **Novena de Pentecostes**: `novenaPentecostesOpening`, `novenaPentecostesClosing`, `novenaPentecostesDay1Meditation`, `novenaPentecostesDay4Meditation`, `novenaPentecostesDay5Meditation`, `novenaPentecostesDay6Meditation`, `novenaPentecostesDay7Meditation`, `novenaPentecostesDay8Meditation`, `novenaPentecostesDay9Meditation`
- **Novena a N. S. do Perpétuo Socorro**: `novenaPerpetuoSocorroOpening`, `novenaPerpetuoSocorroClosing`, `novenaPerpetuoSocorroDay2Meditation`, `novenaPerpetuoSocorroDay3Meditation`, `novenaPerpetuoSocorroDay6Meditation`, `novenaPerpetuoSocorroDay7Meditation`, `novenaPerpetuoSocorroDay8Meditation`, `novenaPerpetuoSocorroDay9Meditation`
- **Novena a São Miguel Arcanjo**: `novenaSaoMiguelOpening`, `novenaSaoMiguelClosing`, `novenaSaoMiguelDay1Meditation`, `novenaSaoMiguelDay4Meditation`, `novenaSaoMiguelDay5Meditation`, `novenaSaoMiguelDay6Meditation`, `novenaSaoMiguelDay7Meditation`, `novenaSaoMiguelDay9Meditation`
- **Novena pelas Almas do Purgatório**: `novenaAlmasOpening`, `novenaAlmasClosing`, `novenaAlmasDay1Meditation`, `novenaAlmasDay2Meditation`, `novenaAlmasDay3Meditation`, `novenaAlmasDay4Meditation`, `novenaAlmasDay5Meditation`, `novenaAlmasDay6Meditation`, `novenaAlmasDay7Meditation`, `novenaAlmasDay9Meditation`
- **Novena a Nossa Senhora Aparecida**: `novenaAparecidaOpening`, `novenaAparecidaClosing`, `novenaAparecidaDay1Meditation`, `novenaAparecidaDay2Meditation`, `novenaAparecidaDay3Meditation`, `novenaAparecidaDay4Meditation`, `novenaAparecidaDay5Meditation`, `novenaAparecidaDay7Meditation`, `novenaAparecidaDay9Meditation`
- **Novena a Nossa Senhora de Fátima**: `novenaFatimaOpening`, `novenaFatimaClosing`, `novenaFatimaDay1Meditation`, `novenaFatimaDay3Meditation`, `novenaFatimaDay6Meditation`
- **Novena da Divina Misericórdia**: `novenaMisericordiaDesc`, `novenaMisericordiaOpening`, `novenaMisericordiaClosing`, `novenaMisericordiaDay2Meditation`
- **Novena a Santo Antônio**: `novenaSantoAntonioOpening`, `novenaSantoAntonioClosing`, `novenaSantoAntonioDay4Meditation`, `novenaSantoAntonioDay9Meditation`
- **Novena a Santa Rita de Cássia**: `novenaSantaRitaOpening`, `novenaSantaRitaClosing`, `novenaSantaRitaDay1Meditation`, `novenaSantaRitaDay6Meditation`
- **Novena a Cristo Rei**: `novenaCristoReiDesc`, `novenaCristoReiOpening`, `novenaCristoReiClosing`, `novenaCristoReiDay1Meditation`

</details>

<a id="misterio"></a>
## Mistérios do terço (oferecimentos e resumos) — prioridade 2

Confirme se foram escritos para o app ou copiados de um livro ou site.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `joyful1Full` |  | Nós vos oferecemos, Senhor Jesus, esta primeira dezena, em honra de vo… |  |
| ☐ | `joyful2Full` |  | Nós vos oferecemos, Senhor Jesus, esta segunda dezena, em honra da Vis… |  |
| ☐ | `joyful3Full` |  | Nós vos oferecemos, Senhor Jesus, esta terceira dezena, em honra de vo… |  |
| ☐ | `joyful4Full` |  | Nós vos oferecemos, Senhor Jesus, esta quarta dezena, em honra de voss… |  |
| ☐ | `joyful5Full` |  | Nós vos oferecemos, Senhor Jesus, esta quinta dezena, em honra de voss… |  |
| ☐ | `sorrowful1Short` |  | Pedimos, por este mistério e pela intercessão de Maria, a contrição de… |  |
| ☐ | `sorrowful1Full` |  | Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios d… |  |
| ☐ | `sorrowful2Full` |  | Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios do… |  |
| ☐ | `sorrowful3Full` |  | Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios d… |  |
| ✏️ trocado | `sorrowful4Full` |  | Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios dol… | Texto trocado por você em 15/11/2026. |
| ☐ | `sorrowful5Full` |  | Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios dol… |  |
| ☐ | `glorious1Full` |  | Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios g… |  |
| ☐ | `glorious2Full` |  | Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios gl… |  |
| ☐ | `glorious3Full` |  | Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios g… |  |
| ☐ | `glorious4Full` |  | Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios glo… |  |
| ✏️ trocado | `glorious5Full` |  | Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios glo… | Texto trocado por você em 15/11/2026. |
| ☐ | `luminous1Short` |  | Jesus é batizado por João no Rio Jordão. O céu se abre, o Espírito San… |  |
| ✏️ trocado | `luminous3Short` |  | Jesus percorre a Galileia pregando o Evangelho e chamando à conversão:… | Texto trocado por você em 15/11/2026. |
| ☐ | `luminous4Short` |  | No Monte Tabor, Jesus se transfigura diante de Pedro, Tiago e João. Se… |  |
| ☐ | `luminous5Short` |  | Na Última Ceia, Jesus institui a Eucaristia, dando-nos seu Corpo e San… |  |

<a id="santos"></a>
## Consagrações e orações de santos (português) — prioridade 2

O original costuma ser livre; confira a tradução.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `prayerSpiritualCommunionContent` | Comunhão Espiritual | Creio, meu Jesus, que estais presente no Santíssimo Sacramento. Amo-Vo… |  |
| ☐ | `prayerSelfOfferingContent` | Oferecimento de Si Mesmo | Tomai, Senhor, e recebei toda a minha liberdade, a minha memória, o me… |  |
| ☐ | `prayerVeniCreatorContent` | Vinde Espírito Santo | Vinde Espírito Santo, enchei os corações dos vossos fiéis e acendei ne… |  |
| ☐ | `prayerBeforeWorkContent` | Antes do Trabalho | Ofereço-Vos, ó meu Deus, o trabalho que vou iniciar; dignai-Vos abenço… |  |
| ☐ | `prayerStudiesContent` | Antes dos Estudos | Criador inefável, Vós que sois a verdadeira fonte da luz e da sabedori… |  |
| ☐ | `prayerStJosephContent` | São José | A vós, São José, recorremos em nossa tribulação e, depois de ter implo… |  |
| ☐ | `prayerStThereseContent` | Santa Teresinha | Ó Santa Teresinha do Menino Jesus, modelo de humildade, de confiança e… |  |
| ✏️ trocado | `prayerGuadalupeContent` | N. Sra. de Guadalupe | Ó Nossa Senhora de Guadalupe, Rosa Mística, intercedei pela Santa Igre… | Texto trocado por você em 15/11/2026. |
| ✏️ trocado | `prayerCarloAcutisContent` | São Carlo Acutis | Senhor Deus, que cumulastes de graças o coração do jovem São Carlo Acu… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerSalveContent` | Salve Rainha | Infinitas graças vos damos, Soberana Rainha, pelos benefícios que todo… |  |
| ☐ | `prayerOfferingContent` | Oferecimento do Terço | Divino Jesus, eu Vos ofereço este terço que vou rezar, contemplando os… |  |
| ☐ | `threeHailMarysContent` | 3 Ave-Marias | Maria, Mãe de Jesus e minha Mãe, defendei-me do Maligno em vida e na h… |  |
| ☐ | `prayerAfterConfessionContent` | Depois da Confissão | Obrigado, Senhor, pelo perdão que me concedestes. Ajudai-me a cumprir … |  |
| ☐ | `prayerBeforeCommunionContent` | Antes da Comunhão | Senhor Jesus, creio que estais verdadeiramente presente na Eucaristia,… |  |
| ☐ | `prayerAfterCommunionContent` | Depois da Comunhão | Jesus, meu Senhor e meu Deus, agradeço-Vos por Vos dardes a mim neste … |  |
| ☐ | `prayerTheologicalActsContent` | Atos de Fé, Esperança e Caridade | Ato de Fé Meu Deus, creio firmemente em tudo o que a Santa Igreja Cató… |  |
| ☐ | `prayerTantumErgoContent` | Tantum Ergo | Veneremos, prostrados, tão grande Sacramento; e o antigo rito dê lugar… | Tradução em versos: diga de onde veio (o latim é livre). |
| ☐ | `prayerViaSacraContent` | Via-Sacra | Em cada estação, diz-se: V. Nós vos adoramos, Senhor Jesus Cristo, e v… | Confira de onde vieram as meditações das estações. |
| ✏️ trocado | `prayerDivineMercyChapletContent` | Terço da Divina Misericórdia | Faz-se o Sinal da Cruz e reza-se, opcionalmente: Expirastes, Jesus, ma… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerStMichaelContent` | Oração a São Miguel Arcanjo | São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio cont… |  |
| ☐ | `prayerGraceAfterMealsContent` | Graças depois das refeições | Agradecemos-vos, Deus todo-poderoso, todos os vossos benefícios, vós q… |  |
| ☐ | `prayerStFrancisPeaceContent` | Oração da Paz (São Francisco) | Senhor, fazei-me instrumento de vossa paz. Onde houver ódio, que eu le… | Texto de 1912, de autor anônimo: livre; confira a tradução. |
| ☐ | `prayerStBenedictMedalContent` | Medalha de São Bento | A Cruz Sagrada seja a minha luz, Não seja o dragão meu guia. Retira-te… |  |
| ✏️ trocado | `prayerUniversalClementContent` | Oração Universal (Papa Clemente XI) | Creio, Senhor, mas fazei que eu creia com mais firmeza; espero, mas fa… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerStTeresaAvilaContent` | Nada te perturbe (Santa Teresa d'Ávila) | Nada te perturbe, Nada te espante, Tudo passa. Deus não muda. A paciên… |  |
| ☐ | `prayerStAugustineContent` | Tarde Te amei (Santo Agostinho) | Tarde Te amei, ó Beleza tão antiga e tão nova, tarde Te amei! Eis que … |  |
| ☐ | `prayerStAnthonyContent` | Oração a Santo Antônio | Ó Santo Antônio, o mais afável e bondoso dos santos, vosso amor a Deus… |  |
| ☐ | `prayerStRitaContent` | Oração a Santa Rita de Cássia | Ó poderosa e gloriosa Santa Rita de Cássia, eis a vossos pés uma alma … |  |
| ☐ | `prayerConsecTotusTuusContent` | Totus Tuus (consagração a Maria) | Totus Tuus ego sum, et omnia mea tua sunt. Sou todo vosso, ó Maria, e … |  |
| ☐ | `prayerConsecMontfortContent` | Consagração a Jesus por Maria (São Luís … | Ó Sabedoria Eterna e Encarnada! Ó amabilíssimo e adorável Jesus, verda… | S. Luís de Montfort (†1716) é livre; confira a tradução. |
| ☐ | `prayerConsecSacredHeartContent` | Consagração ao Sagrado Coração de Jesus | Eu dou e consagro ao Sagrado Coração de Nosso Senhor Jesus Cristo a mi… |  |
| ☐ | `prayerConsecStJosephContent` | Consagração a São José | Ó glorioso São José, a vós recorremos em nossa tribulação e, depois de… |  |

<a id="tradicional"></a>
## Orações tradicionais (português) — prioridade 3

Pai-Nosso, Ave-Maria, Credo etc.: textos de uso comum. Confirme em bloco.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `reportFinalPrayer` |  | "Acuso-me destes pecados, de todos os que não me lembro e dos de minha… |  |
| ☐ | `reportActOfContrition` |  | Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor m… |  |
| ☐ | `confessionMethodAltPrayer` |  | "Meu Deus, porque sois infinitamente bom e amável, tenho muita pena po… |  |
| ☐ | `prayerPaterNosterContent` | Pai Nosso | Pai Nosso, que estais no Céu, santificado seja o vosso Nome; venha a n… |  |
| ☐ | `prayerAnimaChristiContent` | Alma de Cristo | Alma de Cristo, santificai-me. Corpo de Cristo, salvai-me. Sangue de C… |  |
| ☐ | `prayerAveMariaContent` | Ave Maria | Ave Maria, cheia de graça, o Senhor é convosco; bendita sois vós entre… |  |
| ☐ | `prayerCredoContent` | Credo | Creio em Deus Pai Todo-Poderoso, Criador do céu e da terra; e em Jesus… |  |
| ☐ | `prayerMorningContent` | Oração da Manhã | Pai Nosso... Ave Maria... Credo... Oferecimento do Dia: Eu Vos adoro, … |  |
| ☐ | `prayerNightContent` | Oração da Noite | Pai Nosso... Ave Maria... Credo... Ação de Graças: Eu Vos adoro, meu D… |  |
| ☐ | `prayerAngelusContent` | O Angelus | ℣. O Anjo do Senhor anunciou a Maria. ℟. E ela concebeu do Espírito Sa… |  |
| ☐ | `prayerReginaCaeliContent` | Rainha do Céu (Regina Caeli) | ℣. Rainha do Céu, alegrai-vos, aleluia. ℟. Porque Aquele que mereceste… |  |
| ☐ | `prayerGuardianAngelContent` | Santo Anjo da Guarda | Santo Anjo do Senhor, meu zeloso guardador, se a ti me confiou a pieda… |  |
| ☐ | `temptationStep2Prayer` |  | • Jesus e Maria, eu vos amo, salvai almas. • Meu Jesus, misericórdia! … |  |
| ☐ | `temptationStep3Prayer` |  | São Miguel Arcanjo, defendei-nos no combate; sede nosso refúgio contra… |  |
| ☐ | `temptationStep4Prayer` |  | Lembrai-Vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que alg… |  |
| ☐ | `temptationStep7Prayer` |  | • Senhor, eu creio! Ajudai a minha incredulidade. • Mãe Santíssima, nã… |  |
| ☐ | `temptationStep8Prayer` |  | Ó minha Senhora e minha Mãe, eu me ofereço todo a vós e, em prova de m… |  |
| ☐ | `prayerGloriaContent` | Glória | Glória ao Pai, ao Filho e ao Espírito Santo. Como era no princípio, ag… |  |
| ☐ | `prayerFatimaContent` | Oração de Fátima | Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as alma… |  |
| ☐ | `prayerActContritionContent` | Ato de Contrição | Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor m… |  |
| ☐ | `prayerBeforeConfessionContent` | Antes da Confissão | Vinde, Espírito Santo, iluminai a minha consciência para que eu reconh… |  |
| ☐ | `prayerMemorareContent` | Lembrai-vos (Memorare) | Lembrai-vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que alg… |  |

<a id="latim"></a>
## Textos em latim — prioridade 3

Liturgia e orações antigas: domínio público. Confirme em bloco.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `prayerPaterNosterContentLatin` |  | Pater noster, qui es in caelis, sanctificetur nomen tuum. Adveniat reg… |  |
| ☐ | `prayerAnimaChristiContentLatin` |  | Anima Christi, sanctifica me. Corpus Christi, salva me. Sanguis Christ… |  |
| ☐ | `prayerSpiritualCommunionContentLatin` |  | Credo, mi Iesu, te in Sanctissimo Sacramento praesentem esse. Amo te s… |  |
| ☐ | `prayerSelfOfferingContentLatin` |  | Suscipe, Domine, universam meam libertatem. Accipe memoriam, intellect… |  |
| ☐ | `prayerAveMariaContentLatin` |  | Ave Maria, gratia plena, Dominus tecum. Benedicta tu in mulieribus, et… |  |
| ☐ | `prayerCredoContentLatin` |  | Credo in Deum Patrem omnipotentem, Creatorem caeli et terrae. Et in Ie… |  |
| ☐ | `prayerVeniCreatorContentLatin` |  | Veni, Sancte Spiritus, reple tuorum corda fidelium, et tui amoris in e… |  |
| ☐ | `prayerGloriaContentLatin` |  | Gloria Patri, et Filio, et Spiritui Sancto. Sicut erat in principio, e… |  |
| ☐ | `prayerSalveContentLatin` |  | Infinitas gratias tibi agimus, suprema Regina, pro beneficiis quae quo… |  |
| ✏️ trocado | `prayerConfiteorContentLatin` |  | Confiteor Deo omnipotenti, beatae Mariae semper Virgini, beato Michael… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerTantumErgoContentLatin` |  | Tantum ergo Sacramentum veneremur cernui: et antiquum documentum novo … |  |
| ☐ | `prayerPsalm50ContentLatin` |  | Miserere mei, Deus, secundum magnam misericordiam tuam. Et secundum mu… |  |
| ☐ | `prayerPsalm129ContentLatin` |  | De profundis clamavi ad te, Domine; Domine, exaudi vocem meam. Fiant a… |  |
| ✏️ trocado | `prayerPsalm22ContentLatin` |  | Dominus regit me, et nihil mihi deerit: in loco pascuae ibi me colloca… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerMagnificatContentLatin` |  | Magnificat anima mea Dominum, et exsultavit spiritus meus in Deo salut… |  |
| ☐ | `prayerMemorareContentLatin` |  | Memorare, o piissima Virgo Maria, non esse auditum a saeculo, quemquam… |  |
| ☐ | `prayerStMichaelContentLatin` |  | Sancte Michael Archangele, defende nos in proelio; contra nequitiam et… |  |
| ☐ | `prayerStFrancisPeaceContentLatin` |  | Domine, fac me servum pacis tuae. Ubi odium est, ibi caritatem afferam… |  |
| ☐ | `prayerStBenedictMedalContentLatin` |  | Crux sacra sit mihi lux, non draco sit mihi dux. Vade retro, Satana! N… |  |
| ✏️ trocado | `prayerUniversalClementContentLatin` |  | Credo, Domine, sed credam firmius; spero, sed sperem securius; amo, se… | Texto trocado por você em 15/11/2026. |
| ☐ | `prayerStTeresaAvilaContentLatin` |  | Nihil te perturbet, nihil te terreat, omnia transeunt. Deus non mutatu… |  |
| ☐ | `prayerStAugustineContentLatin` |  | Sero te amavi, pulchritudo tam antiqua et tam nova, sero te amavi! Et … |  |
| ☐ | `prayerStAnthonyContentLatin` |  | O beate Antoni, sanctorum mitissime, cuius caritas in Deum ac proximum… |  |
| ☐ | `prayerStRitaContentLatin` |  | O potens et gloriosa Sancta Rita, ecce ad pedes tuos afflicta anima, q… |  |
| ☐ | `prayerLitanyHumilityContentLatin` |  | Iesu, mitis et humilis corde, exaudi me. A desiderio aestimandi, liber… |  |
| ☐ | `prayerLitanyPreciousBloodContentLatin` |  | Kyrie, eleison. Christe, eleison. Kyrie, eleison. Christe, audi nos. C… |  |
| ☐ | `prayerLitanyBlessedSacramentContentLatin` |  | Kyrie, eleison. Christe, eleison. Kyrie, eleison. Christe, audi nos. C… |  |
| ☐ | `prayerLitanyHolyAngelsContentLatin` |  | Kyrie, eleison. Christe, eleison. Kyrie, eleison. Christe, audi nos. C… |  |
| ☐ | `prayerLitanyGoodDeathContentLatin` |  | Domine Iesu, Deus bonitatis et Pater misericordiarum, contrito et humi… |  |
| ☐ | `prayerConsecTotusTuusContentLatin` |  | Totus Tuus ego sum, et omnia mea tua sunt. Accipio te in mea omnia, o … |  |
| ☐ | `prayerConsecMontfortContentLatin` |  | O Aeterna et Incarnata Sapientia! O dulcissime et adorabilis Iesu, ver… |  |
| ☐ | `prayerConsecSacredHeartContentLatin` |  | Ego me totum trado et consecro Sacratissimo Cordi Domini nostri Iesu C… |  |
| ☐ | `prayerConsecStJosephContentLatin` |  | Ad te, beate Ioseph, in tribulatione nostra confugimus, atque, implora… |  |

<a id="proprio"></a>
## Textos escritos para o app — prioridade 3

Ajuda, explicações, guia do app, página de apoio. Confirme em bloco.

| Decisão | Chave | Título | Começo do texto | Observação / fonte |
|---|---|---|---|---|
| ☐ | `recoverAccessWarning` |  | ATENÇÃO: os itens marcados no exame, o histórico de confissões e as da… |  |
| ☐ | `preparatoryPrayerContent` | Oração Preparatória | Senhor, iluminai-me para que eu possa ver os meus pecados, e dai-me a … |  |
| ☐ | `whyConfessContent` | Por que se Confessar? | A Confissão é um Sacramento instituído por Jesus Cristo para nos recon… |  |
| ☐ | `psychBenefitsContent` | Benefícios Psicológicos | Estudos científicos demonstram diversos benefícios psicológicos da con… |  |
| ☐ | `saintsWordsContent` | Palavras dos Santos | "Aquele que se confessa em lágrimas recebe o perdão em alegria." — São… | Citações de santos: curtas e com autoria, risco baixo. |
| ☐ | `tipsContent` | Dicas para Ansiosos e Tímidos | Se você sente ansiedade ou vergonha ao confessar: 1. **Prepare-se com … |  |
| ☐ | `secrecyContent` | O Sigilo Sacramental | O Segredo da Confissão é ABSOLUTO e INVIOLÁVEL. O padre está proibido,… |  |
| ☐ | `priestAttitudeContent` | A Atitude do Sacerdote | O padre manterá a mesma atitude acolhedora, não importa o pecado. **Po… |  |
| ☐ | `reportWarningContent` | ATENÇÃO: Recomendações Importantes | • Por respeito ao Sacramento e ao sacerdote, recomenda-se copiar este … |  |
| ☐ | `dailyExamStep1Desc` | Ação de Graças | Coloque-se na presença de Deus. Agradeça por todos os benefícios receb… |  |
| ☐ | `dailyExamStep2Desc` | Pedido de Luz | Peça ao Espírito Santo a graça de conhecer os seus pecados e de rejeit… |  |
| ☐ | `dailyExamStep3Desc` | Exame do Dia | Percorra as horas do seu dia, desde o levantar até agora. Examine seus… |  |
| ☐ | `dailyExamStep4Desc` | Contrição | Peça perdão a Deus pelas faltas cometidas. Sinta dor por ter ofendido … |  |
| ☐ | `confessionMethodStep4` |  | Em seguida, o penitente se acusa de seus pecados. (Use o guia gerado p… |  |
| ☐ | `temptationStep1Desc` | Reconheça a Tentação | A tentação é um perigo real para a alma. Reconheça-a imediatamente e n… |  |
| ☐ | `temptationStep5Desc` | A Fuga é Vitória | Na tentação da impureza, a vitória consiste na fuga. Não lute corpo a … |  |
| ☐ | `temptationStep6Desc` | Mude o Ambiente | Dicas práticas para fugir da tentação: • Mude de pensamento: ocupe a m… |  |
| ☐ | `temptationStep7Desc` | Rompa o Cerco | Jaculatórias para quando o desânimo ataca. Não desista! Deus permite a… |  |
| ☐ | `backupProtectBody` | Proteger o backup com senha? | O backup contém dados sensíveis, como o registro de pecados. Com uma s… |  |
| ☐ | `novenaPrayedBefore` |  | {count, plural, =1{Você já rezou esta novena 1 vez} other{Você já rezo… |  |
| ☐ | `gardenGrowthHint` |  | Sem oração, o gramado do dia fica seco e amarelado; a cada oração ele … |  |
| ☐ | `gardenSemantics` |  | {count, plural, =0{Jardim da Alma: nenhum dia com oração no último ano… |  |
| ☐ | `massGuideTipsBody` | Antes de ir | Chegue alguns minutos antes e desligue o celular. Para comungar, estej… |  |
| ☐ | `massGuidePart1Body` | 1. Ritos iniciais | Canto de entrada, sinal da cruz e saudação. No ato penitencial, peça p… |  |
| ☐ | `massGuidePart2Body` | 2. Liturgia da Palavra | Primeira leitura, Salmo responsorial e, aos domingos, segunda leitura.… |  |
| ☐ | `massGuidePart3Body` | 3. Liturgia Eucarística | Apresentação do pão e do vinho, Oração Eucarística com o Santo e a con… |  |
| ☐ | `examClearBody` | Limpar as marcações? | {count, plural, =1{O item marcado no exame será desmarcado.} other{Os … |  |
| ☐ | `massGuideTradTipsBody` | Antes de ir | A Missa tradicional é celebrada com o Missal Romano de 1962. Procure s… |  |
| ☐ | `massGuideTradPart1Body` | 1. Ao pé do altar | O sacerdote e os ministros se preparam com o sinal da cruz e o Salmo 4… |  |
| ☐ | `massGuideTradPart2Body` | 2. Intróito, Kyrie e Glória | O Intróito é o canto de entrada. Segue o Kyrie, súplica de misericórdi… |  |
| ☐ | `massGuideTradPart3Body` | 3. Epístola, Gradual e Evangelho | Lê-se a Epístola, canta-se o Gradual (e o Aleluia) e proclama-se o Eva… |  |
| ☐ | `massGuideTradPart4Body` | 4. Sermão, Credo e Ofertório | Depois do sermão, nos domingos e festas, reza-se o Credo (genuflexão e… |  |
| ☐ | `massGuideTradPart5Body` | 5. Prefácio, Sanctus e Cânon | O Prefácio abre a grande oração de ação de graças. Após o Sanctus, o s… |  |
| ☐ | `massGuideTradPart6Body` | 6. Pai-Nosso, Agnus Dei e Comunhão | O sacerdote canta o Pai-Nosso, o povo responde ao final. Segue o Agnus… |  |
| ☐ | `massGuideTradPart7Body` | 7. Ritos finais e Último Evangelho | Depois da oração final, o sacerdote despede o povo e dá a bênção. A Mi… |  |
| ☐ | `supportStory` |  | Este aplicativo é gratuito e continuará sendo. Ele nasceu também de um… |  |
| ☐ | `nudgeBody` | Um pedido dos noivos | Este app é gratuito e nasceu para ajudar nas despesas do nosso casamen… |  |
| ☐ | `tourWelcomeBody` | Bem-vindo! Vamos conhecer o app? | Em poucos passos você vai ver onde fica cada coisa: o plano do dia, as… |  |
| ☐ | `tourGardenBody` | Jardim da Alma | Cada quadradinho é um dia. Ele vai ficando mais verde conforme você re… |  |
| ☐ | `tourTodayBody` | Hoje | Aqui ficam as orações do seu plano para hoje, separadas por manhã, mei… |  |
| ☐ | `tourAddBody` | Adicionar ao plano | Use o botão + para colocar no seu plano uma oração, uma novena ou o te… |  |
| ☐ | `tourCalendarBody` | Calendário | Veja o que você rezou em cada dia, as Missas, confissões e novenas, al… |  |
| ☐ | `tourRemindersBody` | Lembretes | Todos os avisos do app em um só lugar: orações, novenas, confissão e o… |  |
| ☐ | `tourMenuBody` | Menu | Aqui ficam Sobre o Projeto, este Guia do app (para rever quando quiser… |  |
| ☐ | `tourPrayersBody` | Orações | Todas as orações do app, organizadas por categoria. No topo aparece a … |  |
| ☐ | `tourNovenasBody` | Novenas | Uma novena é uma oração de nove dias seguidos. Aqui ficam as novenas t… |  |
| ☐ | `tourRosaryBody` | Santo Terço | O terço guiado: o app mostra cada oração na hora certa, para você reza… |  |
| ☐ | `tourExamBody` | Exame de consciência | O coração do app para a confissão. Examine a consciência com calma, ma… |  |
| ☐ | `tourEndBody` | Pronto! | Você pode rever este guia quando quiser, no menu (as três linhas no ca… |  |
| ☐ | `onbProjectBody` | Gratuito, feito com amor | O Sancta é gratuito e sem anúncios. Foi feito por um casal que está se… |  |
| ☐ | `onbProjectBodyStore` |  | O Sancta é gratuito e sem anúncios. Foi feito por um casal que está se… |  |
| ☐ | `onbReadyBody` | Tudo pronto! | Quer um passeio rápido pela tela? O guia mostra onde fica cada coisa. … |  |
| ☐ | `afterTourBody` | Sobre este app | O Sancta foi criado para ajudar a pagar as despesas do meu casamento, … |  |
| ☐ | `afterTourBodyStore` |  | O Sancta foi criado para que os católicos rezem bem e vivam a fé a cad… |  |
| ☐ | `tourNovenaSearchBody` | Encontre a sua novena | Digite o nome do santo ou da devoção. A busca aceita erros de digitaçã… |  |
| ☐ | `tourNovenaStartBody` | Iniciar e acompanhar | Toque numa novena para ler a oração de cada dia. Em Iniciar Novena voc… |  |
| ☐ | `tourRosaryProgressBody` | Seu Rosário de hoje | Cada bolinha é um terço rezado hoje. Quatro terços (com os mistérios l… |  |
| ☐ | `tourRosaryTodayBody` | Mistérios do dia | O app já escolhe os mistérios do dia da semana. Toque no cartão para r… |  |
| ☐ | `tourExamHeaderBody` | Suas confissões | Aqui você registra a última confissão e planeja a próxima. O app avisa… |  |
| ☐ | `tourExamJornadaBody` | Jornada de Confissão | Um caminho passo a passo para quem quer se preparar bem: oração, exame… |  |
| ☐ | `tourExamSectionsBody` | Examine por categorias | Percorra as categorias, como os Mandamentos e os pecados capitais, e t… |  |
| ☐ | `tourExamGuideBody` | Gerar o guia | Quando terminar, toque em Gerar guia: o app monta um resumo organizado… |  |

## Fora desta lista

- **Itens do exame de consciência** (lista de pecados por categoria), em `lib/models/categoria.dart`: confirme se foram escritos para o app ou tirados de um exame publicado.
- **Imagens** de `lib/imgs/` (8 arquivos) e o **ícone**: diga a origem (foto própria, banco de imagens livre, IA e qual ferramenta).
- Textos curtos (menos de 120 caracteres), como títulos e jaculatórias, não foram listados: o risco é muito baixo.
