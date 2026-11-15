# Guia: Como Adicionar uma Nova Novena

Este guia explica como adicionar uma nova novena ao aplicativo. São 3 arquivos que precisam ser modificados.

---

## Passo 1: Adicionar Textos (app_pt.arb)

**Arquivo:** `lib/l10n/app_pt.arb`

Copie o bloco template e substitua `Template` pelo nome da sua novena (ex: `NossaSenhora`, `SaoJose`):

```json
  "novenaNOMETitle": "Título da Novena",
  "novenaNOMEDesc": "Descrição breve",
  
  "novenaNOMEOpening": "Oração inicial...",
  "novenaNOMEClosing": "Oração final... (deixe vazio com \"\" se não houver)",
  "novenaNOMEPrayers": "Instruções de orações (ex: Pai-nosso, Ave-Maria e Glória).",

  "novenaNOMEDay1Title": "Título do Dia 1",
  "novenaNOMEDay1Meditation": "Meditação do Dia 1...",
  
  "novenaNOMEDay2Title": "Título do Dia 2",
  "novenaNOMEDay2Meditation": "Meditação do Dia 2...",
  
  ... (até Day9)
```

Depois execute: `flutter gen-l10n`

---

## Passo 2: Adicionar Card na Lista (novena_home_page.dart)

**Arquivo:** `lib/pages/novena_home_page.dart`

Procure o comentário `COPIE DAQUI PARA ADICIONAR NOVA NOVENA` e duplique o bloco:

```dart
const SizedBox(height: 16),
_buildNovenaCard(
  context,
  novenaId: 'nome_minusculo',           // Ex: 'nossa_senhora'
  title: l10n.novenaNOMETitle,          // Ex: l10n.novenaNossaSenhoraTitle
  description: l10n.novenaNOMEDesc,     // Ex: l10n.novenaNossaSenhoraDesc
  icon: Icons.star,                      // Escolha um ícone
),
```

**Ícones sugeridos:**
- `Icons.favorite` - coração
- `Icons.local_florist` - flor
- `Icons.church` - igreja
- `Icons.star` - estrela
- `Icons.brightness_7` - sol/luz
- `Icons.water_drop` - gota
- `Icons.favorite_border` - coração vazio

---

## Passo 3: Adicionar Conteúdo (novena_detail_page.dart)

**Arquivo:** `lib/pages/novena_detail_page.dart`

### 3.1 Adicionar Título (busque "COPIE DAQUI PARA ADICIONAR TÍTULO")

```dart
} else if (widget.novenaId == 'nome_minusculo') {
  novenaTitle = l10n.novenaNOMETitle;
```

### 3.2 Adicionar Conteúdo dos Dias (busque "COPIE DAQUI PARA ADICIONAR NOVA NOVENA")

Duplique o bloco `} else if (widget.novenaId == 'template')` e altere:

```dart
} else if (widget.novenaId == 'nome_minusculo') {
  openingPrayer = l10n.novenaNOMEOpening;
  closingPrayer = l10n.novenaNOMEClosing;
  prayerInstruction = l10n.novenaNOMEPrayers;
  
  switch (day) {
    case 1:
      dayTitle = l10n.novenaNOMEDay1Title;
      dayMeditation = l10n.novenaNOMEDay1Meditation;
      break;
    // ... repetir para dias 2-9
  }
```

---

## Resumo dos IDs

| Novena Atual | ID | Prefixo ARB |
|--------------|-----|-------------|
| Carlo Acutis | `carlo_acutis` | `novenaCarloAcutis` |
| Santa Teresinha | `teresa_lisieux` | `novenaTeresa` |
| Sagrado Coração | `sagrado_coracao` | `novenaSagradoCoracao` |
| Template | `template` | `novenaTemplate` |

---

## Dicas

1. **Sem meditação separada**: Se sua novena não tem meditação, deixe `dayMeditation = ''` (a seção não aparecerá)
2. **Sem oração final**: Use `closingPrayer = ''`
3. **Teste**: Sempre rode `flutter gen-l10n` após alterar o ARB
4. **Hot reload**: Pressione `r` no terminal para ver as mudanças

---

## Exemplo Completo: Nossa Senhora de Fátima

1. **ARB:** Adicione `novenaNossaSenhoraTitle`, `novenaNossaSenhoraDesc`, etc.
2. **Home:** `novenaId: 'nossa_senhora'`, `icon: Icons.brightness_7`
3. **Detail:** Copie bloco template e troque `template` por `nossa_senhora`
