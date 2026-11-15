import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/novena_content.dart';

class NovenaData {
  static List<NovenaContent> getAllNovenas(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return [
      _getNatalNovena(l10n),
      _getCarloAcutisNovena(l10n),
      _getTeresaNovena(l10n),
      _getSagradoCoracaoNovena(l10n),
      _getConceicaoNovena(l10n),
      // Novas Novenas Adicionadas
      _getSaoJoseNovena(l10n),
      _getSaoJudasNovena(l10n),
      _getPentecostesNovena(l10n),
      _getPerpetuoSocorroNovena(l10n),
      _getSaoMiguelNovena(l10n),
      _getAlmasNovena(l10n),
      _getAparecidaNovena(l10n),
      _getFatimaNovena(l10n),
      _getMisericordiaNovena(l10n),
      _getSantoAntonioNovena(l10n),
      _getSantaRitaNovena(l10n),
      _getCristoReiNovena(l10n),
    ];
  }

  static NovenaContent getNovenaById(BuildContext context, String id) {
    final all = getAllNovenas(context);
    return all.firstWhere(
      (n) => n.id == id,
      orElse: () => all.first, // Fallback
    );
  }

  static NovenaContent _getNatalNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_natal',
      title: l10n.novenaNatalTitle,
      description: l10n.novenaNatalDesc,
      icon: Icons.child_care,
      openingPrayer: l10n.novenaNatalOpening,
      closingPrayer: l10n.novenaNatalClosing,
      prayerInstruction: l10n.novenaNatalPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaNatalDay1Title;
            meditation = l10n.novenaNatalDay1Meditation;
            break;
          case 2:
            title = l10n.novenaNatalDay2Title;
            meditation = l10n.novenaNatalDay2Meditation;
            break;
          case 3:
            title = l10n.novenaNatalDay3Title;
            meditation = l10n.novenaNatalDay3Meditation;
            break;
          case 4:
            title = l10n.novenaNatalDay4Title;
            meditation = l10n.novenaNatalDay4Meditation;
            break;
          case 5:
            title = l10n.novenaNatalDay5Title;
            meditation = l10n.novenaNatalDay5Meditation;
            break;
          case 6:
            title = l10n.novenaNatalDay6Title;
            meditation = l10n.novenaNatalDay6Meditation;
            break;
          case 7:
            title = l10n.novenaNatalDay7Title;
            meditation = l10n.novenaNatalDay7Meditation;
            break;
          case 8:
            title = l10n.novenaNatalDay8Title;
            meditation = l10n.novenaNatalDay8Meditation;
            break;
          case 9:
            title = l10n.novenaNatalDay9Title;
            meditation = l10n.novenaNatalDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getCarloAcutisNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_carlo_acutis',
      title: l10n.novenaCarloAcutisTitle,
      description: l10n.novenaCarloAcutisDesc,
      icon: Icons.computer,
      openingPrayer: l10n.novenaCarloAcutisOpening,
      closingPrayer: l10n.novenaCarloAcutisClosing,
      prayerInstruction: l10n.novenaPrayerInstruction,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaCarloAcutisDay1Title;
            meditation = l10n.novenaCarloAcutisDay1Meditation;
            break;
          case 2:
            title = l10n.novenaCarloAcutisDay2Title;
            meditation = l10n.novenaCarloAcutisDay2Meditation;
            break;
          case 3:
            title = l10n.novenaCarloAcutisDay3Title;
            meditation = l10n.novenaCarloAcutisDay3Meditation;
            break;
          case 4:
            title = l10n.novenaCarloAcutisDay4Title;
            meditation = l10n.novenaCarloAcutisDay4Meditation;
            break;
          case 5:
            title = l10n.novenaCarloAcutisDay5Title;
            meditation = l10n.novenaCarloAcutisDay5Meditation;
            break;
          case 6:
            title = l10n.novenaCarloAcutisDay6Title;
            meditation = l10n.novenaCarloAcutisDay6Meditation;
            break;
          case 7:
            title = l10n.novenaCarloAcutisDay7Title;
            meditation = l10n.novenaCarloAcutisDay7Meditation;
            break;
          case 8:
            title = l10n.novenaCarloAcutisDay8Title;
            meditation = l10n.novenaCarloAcutisDay8Meditation;
            break;
          case 9:
            title = l10n.novenaCarloAcutisDay9Title;
            meditation = l10n.novenaCarloAcutisDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getTeresaNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_teresa_lisieux',
      title: l10n.novenaTeresaTitle,
      description: l10n.novenaTeresaDesc,
      icon: Icons.local_florist,
      openingPrayer: l10n.novenaTeresaOpening,
      closingPrayer: '',
      prayerInstruction: l10n.novenaTeresaPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        
        switch (day) {
          case 1: title = l10n.novenaTeresaDay1Title; break;
          case 2: title = l10n.novenaTeresaDay2Title; break;
          case 3: title = l10n.novenaTeresaDay3Title; break;
          case 4: title = l10n.novenaTeresaDay4Title; break;
          case 5: title = l10n.novenaTeresaDay5Title; break;
          case 6: title = l10n.novenaTeresaDay6Title; break;
          case 7: title = l10n.novenaTeresaDay7Title; break;
          case 8: title = l10n.novenaTeresaDay8Title; break;
          case 9: title = l10n.novenaTeresaDay9Title; break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: '');
      }),
    );
  }

  static NovenaContent _getSagradoCoracaoNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_sagrado_coracao',
      title: l10n.novenaSagradoCoracaoTitle,
      description: l10n.novenaSagradoCoracaoDesc,
      icon: Icons.favorite,
      openingPrayer: l10n.novenaSagradoCoracaoOpening,
      closingPrayer: l10n.novenaSagradoCoracaoClosing,
      prayerInstruction: l10n.novenaSagradoCoracaoPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaSagradoCoracaoDay1Title;
            meditation = l10n.novenaSagradoCoracaoDay1Meditation;
            break;
          case 2:
            title = l10n.novenaSagradoCoracaoDay2Title;
            meditation = l10n.novenaSagradoCoracaoDay2Meditation;
            break;
          case 3:
            title = l10n.novenaSagradoCoracaoDay3Title;
            meditation = l10n.novenaSagradoCoracaoDay3Meditation;
            break;
          case 4:
            title = l10n.novenaSagradoCoracaoDay4Title;
            meditation = l10n.novenaSagradoCoracaoDay4Meditation;
            break;
          case 5:
            title = l10n.novenaSagradoCoracaoDay5Title;
            meditation = l10n.novenaSagradoCoracaoDay5Meditation;
            break;
          case 6:
            title = l10n.novenaSagradoCoracaoDay6Title;
            meditation = l10n.novenaSagradoCoracaoDay6Meditation;
            break;
          case 7:
            title = l10n.novenaSagradoCoracaoDay7Title;
            meditation = l10n.novenaSagradoCoracaoDay7Meditation;
            break;
          case 8:
            title = l10n.novenaSagradoCoracaoDay8Title;
            meditation = l10n.novenaSagradoCoracaoDay8Meditation;
            break;
          case 9:
            title = l10n.novenaSagradoCoracaoDay9Title;
            meditation = l10n.novenaSagradoCoracaoDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getConceicaoNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_conceicao',
      title: l10n.novenaConceicaoTitle,
      description: l10n.novenaConceicaoDesc,
      icon: Icons.brightness_7,
      openingPrayer: l10n.novenaConceicaoOpening,
      closingPrayer: l10n.novenaConceicaoClosing,
      prayerInstruction: l10n.novenaConceicaoPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaConceicaoDay1Title;
            meditation = l10n.novenaConceicaoDay1Meditation;
            break;
          case 2:
            title = l10n.novenaConceicaoDay2Title;
            meditation = l10n.novenaConceicaoDay2Meditation;
            break;
          case 3:
            title = l10n.novenaConceicaoDay3Title;
            meditation = l10n.novenaConceicaoDay3Meditation;
            break;
          case 4:
            title = l10n.novenaConceicaoDay4Title;
            meditation = l10n.novenaConceicaoDay4Meditation;
            break;
          case 5:
            title = l10n.novenaConceicaoDay5Title;
            meditation = l10n.novenaConceicaoDay5Meditation;
            break;
          case 6:
            title = l10n.novenaConceicaoDay6Title;
            meditation = l10n.novenaConceicaoDay6Meditation;
            break;
          case 7:
            title = l10n.novenaConceicaoDay7Title;
            meditation = l10n.novenaConceicaoDay7Meditation;
            break;
          case 8:
            title = l10n.novenaConceicaoDay8Title;
            meditation = l10n.novenaConceicaoDay8Meditation;
            break;
          case 9:
            title = l10n.novenaConceicaoDay9Title;
            meditation = l10n.novenaConceicaoDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getSaoJoseNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_sao_jose',
      title: l10n.novenaSaoJoseTitle,
      description: l10n.novenaSaoJoseDesc,
      icon: Icons.carpenter,
      openingPrayer: l10n.novenaSaoJoseOpening,
      closingPrayer: l10n.novenaSaoJoseClosing,
      prayerInstruction: l10n.novenaSaoJosePrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaSaoJoseDay1Title;
            meditation = l10n.novenaSaoJoseDay1Meditation;
            break;
          case 2:
            title = l10n.novenaSaoJoseDay2Title;
            meditation = l10n.novenaSaoJoseDay2Meditation;
            break;
          case 3:
            title = l10n.novenaSaoJoseDay3Title;
            meditation = l10n.novenaSaoJoseDay3Meditation;
            break;
          case 4:
            title = l10n.novenaSaoJoseDay4Title;
            meditation = l10n.novenaSaoJoseDay4Meditation;
            break;
          case 5:
            title = l10n.novenaSaoJoseDay5Title;
            meditation = l10n.novenaSaoJoseDay5Meditation;
            break;
          case 6:
            title = l10n.novenaSaoJoseDay6Title;
            meditation = l10n.novenaSaoJoseDay6Meditation;
            break;
          case 7:
            title = l10n.novenaSaoJoseDay7Title;
            meditation = l10n.novenaSaoJoseDay7Meditation;
            break;
          case 8:
            title = l10n.novenaSaoJoseDay8Title;
            meditation = l10n.novenaSaoJoseDay8Meditation;
            break;
          case 9:
            title = l10n.novenaSaoJoseDay9Title;
            meditation = l10n.novenaSaoJoseDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getSaoJudasNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_sao_judas',
      title: l10n.novenaSaoJudasTitle,
      description: l10n.novenaSaoJudasDesc,
      icon: Icons.shield,
      openingPrayer: l10n.novenaSaoJudasOpening,
      closingPrayer: l10n.novenaSaoJudasClosing,
      prayerInstruction: l10n.novenaSaoJudasPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaSaoJudasDay1Title;
            meditation = l10n.novenaSaoJudasDay1Meditation;
            break;
          case 2:
            title = l10n.novenaSaoJudasDay2Title;
            meditation = l10n.novenaSaoJudasDay2Meditation;
            break;
          case 3:
            title = l10n.novenaSaoJudasDay3Title;
            meditation = l10n.novenaSaoJudasDay3Meditation;
            break;
          case 4:
            title = l10n.novenaSaoJudasDay4Title;
            meditation = l10n.novenaSaoJudasDay4Meditation;
            break;
          case 5:
            title = l10n.novenaSaoJudasDay5Title;
            meditation = l10n.novenaSaoJudasDay5Meditation;
            break;
          case 6:
            title = l10n.novenaSaoJudasDay6Title;
            meditation = l10n.novenaSaoJudasDay6Meditation;
            break;
          case 7:
            title = l10n.novenaSaoJudasDay7Title;
            meditation = l10n.novenaSaoJudasDay7Meditation;
            break;
          case 8:
            title = l10n.novenaSaoJudasDay8Title;
            meditation = l10n.novenaSaoJudasDay8Meditation;
            break;
          case 9:
            title = l10n.novenaSaoJudasDay9Title;
            meditation = l10n.novenaSaoJudasDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getPentecostesNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_pentecostes',
      title: l10n.novenaPentecostesTitle,
      description: l10n.novenaPentecostesDesc,
      icon: Icons.local_fire_department,
      openingPrayer: l10n.novenaPentecostesOpening,
      closingPrayer: l10n.novenaPentecostesClosing,
      prayerInstruction: l10n.novenaPentecostesPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaPentecostesDay1Title;
            meditation = l10n.novenaPentecostesDay1Meditation;
            break;
          case 2:
            title = l10n.novenaPentecostesDay2Title;
            meditation = l10n.novenaPentecostesDay2Meditation;
            break;
          case 3:
            title = l10n.novenaPentecostesDay3Title;
            meditation = l10n.novenaPentecostesDay3Meditation;
            break;
          case 4:
            title = l10n.novenaPentecostesDay4Title;
            meditation = l10n.novenaPentecostesDay4Meditation;
            break;
          case 5:
            title = l10n.novenaPentecostesDay5Title;
            meditation = l10n.novenaPentecostesDay5Meditation;
            break;
          case 6:
            title = l10n.novenaPentecostesDay6Title;
            meditation = l10n.novenaPentecostesDay6Meditation;
            break;
          case 7:
            title = l10n.novenaPentecostesDay7Title;
            meditation = l10n.novenaPentecostesDay7Meditation;
            break;
          case 8:
            title = l10n.novenaPentecostesDay8Title;
            meditation = l10n.novenaPentecostesDay8Meditation;
            break;
          case 9:
            title = l10n.novenaPentecostesDay9Title;
            meditation = l10n.novenaPentecostesDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getPerpetuoSocorroNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_perpetuo_socorro',
      title: l10n.novenaPerpetuoSocorroTitle,
      description: l10n.novenaPerpetuoSocorroDesc,
      icon: Icons.stars,
      openingPrayer: l10n.novenaPerpetuoSocorroOpening,
      closingPrayer: l10n.novenaPerpetuoSocorroClosing,
      prayerInstruction: l10n.novenaPerpetuoSocorroPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaPerpetuoSocorroDay1Title;
            meditation = l10n.novenaPerpetuoSocorroDay1Meditation;
            break;
          case 2:
            title = l10n.novenaPerpetuoSocorroDay2Title;
            meditation = l10n.novenaPerpetuoSocorroDay2Meditation;
            break;
          case 3:
            title = l10n.novenaPerpetuoSocorroDay3Title;
            meditation = l10n.novenaPerpetuoSocorroDay3Meditation;
            break;
          case 4:
            title = l10n.novenaPerpetuoSocorroDay4Title;
            meditation = l10n.novenaPerpetuoSocorroDay4Meditation;
            break;
          case 5:
            title = l10n.novenaPerpetuoSocorroDay5Title;
            meditation = l10n.novenaPerpetuoSocorroDay5Meditation;
            break;
          case 6:
            title = l10n.novenaPerpetuoSocorroDay6Title;
            meditation = l10n.novenaPerpetuoSocorroDay6Meditation;
            break;
          case 7:
            title = l10n.novenaPerpetuoSocorroDay7Title;
            meditation = l10n.novenaPerpetuoSocorroDay7Meditation;
            break;
          case 8:
            title = l10n.novenaPerpetuoSocorroDay8Title;
            meditation = l10n.novenaPerpetuoSocorroDay8Meditation;
            break;
          case 9:
            title = l10n.novenaPerpetuoSocorroDay9Title;
            meditation = l10n.novenaPerpetuoSocorroDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getSaoMiguelNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_sao_miguel',
      title: l10n.novenaSaoMiguelTitle,
      description: l10n.novenaSaoMiguelDesc,
      icon: Icons.security,
      openingPrayer: l10n.novenaSaoMiguelOpening,
      closingPrayer: l10n.novenaSaoMiguelClosing,
      prayerInstruction: l10n.novenaSaoMiguelPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaSaoMiguelDay1Title;
            meditation = l10n.novenaSaoMiguelDay1Meditation;
            break;
          case 2:
            title = l10n.novenaSaoMiguelDay2Title;
            meditation = l10n.novenaSaoMiguelDay2Meditation;
            break;
          case 3:
            title = l10n.novenaSaoMiguelDay3Title;
            meditation = l10n.novenaSaoMiguelDay3Meditation;
            break;
          case 4:
            title = l10n.novenaSaoMiguelDay4Title;
            meditation = l10n.novenaSaoMiguelDay4Meditation;
            break;
          case 5:
            title = l10n.novenaSaoMiguelDay5Title;
            meditation = l10n.novenaSaoMiguelDay5Meditation;
            break;
          case 6:
            title = l10n.novenaSaoMiguelDay6Title;
            meditation = l10n.novenaSaoMiguelDay6Meditation;
            break;
          case 7:
            title = l10n.novenaSaoMiguelDay7Title;
            meditation = l10n.novenaSaoMiguelDay7Meditation;
            break;
          case 8:
            title = l10n.novenaSaoMiguelDay8Title;
            meditation = l10n.novenaSaoMiguelDay8Meditation;
            break;
          case 9:
            title = l10n.novenaSaoMiguelDay9Title;
            meditation = l10n.novenaSaoMiguelDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getAlmasNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_almas',
      title: l10n.novenaAlmasTitle,
      description: l10n.novenaAlmasDesc,
      icon: Icons.local_fire_department,
      openingPrayer: l10n.novenaAlmasOpening,
      closingPrayer: l10n.novenaAlmasClosing,
      prayerInstruction: l10n.novenaAlmasPrayers,
      days: List.generate(9, (index) {
        final day = index + 1;
        String title = '';
        String meditation = '';
        
        switch (day) {
          case 1:
            title = l10n.novenaAlmasDay1Title;
            meditation = l10n.novenaAlmasDay1Meditation;
            break;
          case 2:
            title = l10n.novenaAlmasDay2Title;
            meditation = l10n.novenaAlmasDay2Meditation;
            break;
          case 3:
            title = l10n.novenaAlmasDay3Title;
            meditation = l10n.novenaAlmasDay3Meditation;
            break;
          case 4:
            title = l10n.novenaAlmasDay4Title;
            meditation = l10n.novenaAlmasDay4Meditation;
            break;
          case 5:
            title = l10n.novenaAlmasDay5Title;
            meditation = l10n.novenaAlmasDay5Meditation;
            break;
          case 6:
            title = l10n.novenaAlmasDay6Title;
            meditation = l10n.novenaAlmasDay6Meditation;
            break;
          case 7:
            title = l10n.novenaAlmasDay7Title;
            meditation = l10n.novenaAlmasDay7Meditation;
            break;
          case 8:
            title = l10n.novenaAlmasDay8Title;
            meditation = l10n.novenaAlmasDay8Meditation;
            break;
          case 9:
            title = l10n.novenaAlmasDay9Title;
            meditation = l10n.novenaAlmasDay9Meditation;
            break;
        }
        return NovenaDay(dayNumber: day, title: title, meditation: meditation);
      }),
    );
  }

  static NovenaContent _getAparecidaNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_aparecida',
      title: l10n.novenaAparecidaTitle,
      description: l10n.novenaAparecidaDesc,
      icon: Icons.waves,
      openingPrayer: l10n.novenaAparecidaOpening,
      closingPrayer: l10n.novenaAparecidaClosing,
      prayerInstruction: l10n.novenaAparecidaPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaAparecidaDay1Title, meditation: l10n.novenaAparecidaDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaAparecidaDay2Title, meditation: l10n.novenaAparecidaDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaAparecidaDay3Title, meditation: l10n.novenaAparecidaDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaAparecidaDay4Title, meditation: l10n.novenaAparecidaDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaAparecidaDay5Title, meditation: l10n.novenaAparecidaDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaAparecidaDay6Title, meditation: l10n.novenaAparecidaDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaAparecidaDay7Title, meditation: l10n.novenaAparecidaDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaAparecidaDay8Title, meditation: l10n.novenaAparecidaDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaAparecidaDay9Title, meditation: l10n.novenaAparecidaDay9Meditation),
      ],
    );
  }

  static NovenaContent _getFatimaNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_fatima',
      title: l10n.novenaFatimaTitle,
      description: l10n.novenaFatimaDesc,
      icon: Icons.brightness_5,
      openingPrayer: l10n.novenaFatimaOpening,
      closingPrayer: l10n.novenaFatimaClosing,
      prayerInstruction: l10n.novenaFatimaPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaFatimaDay1Title, meditation: l10n.novenaFatimaDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaFatimaDay2Title, meditation: l10n.novenaFatimaDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaFatimaDay3Title, meditation: l10n.novenaFatimaDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaFatimaDay4Title, meditation: l10n.novenaFatimaDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaFatimaDay5Title, meditation: l10n.novenaFatimaDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaFatimaDay6Title, meditation: l10n.novenaFatimaDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaFatimaDay7Title, meditation: l10n.novenaFatimaDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaFatimaDay8Title, meditation: l10n.novenaFatimaDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaFatimaDay9Title, meditation: l10n.novenaFatimaDay9Meditation),
      ],
    );
  }

  static NovenaContent _getMisericordiaNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_misericordia',
      title: l10n.novenaMisericordiaTitle,
      description: l10n.novenaMisericordiaDesc,
      icon: Icons.water_drop,
      openingPrayer: l10n.novenaMisericordiaOpening,
      closingPrayer: l10n.novenaMisericordiaClosing,
      prayerInstruction: l10n.novenaMisericordiaPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaMisericordiaDay1Title, meditation: l10n.novenaMisericordiaDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaMisericordiaDay2Title, meditation: l10n.novenaMisericordiaDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaMisericordiaDay3Title, meditation: l10n.novenaMisericordiaDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaMisericordiaDay4Title, meditation: l10n.novenaMisericordiaDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaMisericordiaDay5Title, meditation: l10n.novenaMisericordiaDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaMisericordiaDay6Title, meditation: l10n.novenaMisericordiaDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaMisericordiaDay7Title, meditation: l10n.novenaMisericordiaDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaMisericordiaDay8Title, meditation: l10n.novenaMisericordiaDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaMisericordiaDay9Title, meditation: l10n.novenaMisericordiaDay9Meditation),
      ],
    );
  }

  static NovenaContent _getSantoAntonioNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_santo_antonio',
      title: l10n.novenaSantoAntonioTitle,
      description: l10n.novenaSantoAntonioDesc,
      icon: Icons.menu_book,
      openingPrayer: l10n.novenaSantoAntonioOpening,
      closingPrayer: l10n.novenaSantoAntonioClosing,
      prayerInstruction: l10n.novenaSantoAntonioPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaSantoAntonioDay1Title, meditation: l10n.novenaSantoAntonioDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaSantoAntonioDay2Title, meditation: l10n.novenaSantoAntonioDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaSantoAntonioDay3Title, meditation: l10n.novenaSantoAntonioDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaSantoAntonioDay4Title, meditation: l10n.novenaSantoAntonioDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaSantoAntonioDay5Title, meditation: l10n.novenaSantoAntonioDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaSantoAntonioDay6Title, meditation: l10n.novenaSantoAntonioDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaSantoAntonioDay7Title, meditation: l10n.novenaSantoAntonioDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaSantoAntonioDay8Title, meditation: l10n.novenaSantoAntonioDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaSantoAntonioDay9Title, meditation: l10n.novenaSantoAntonioDay9Meditation),
      ],
    );
  }

  static NovenaContent _getSantaRitaNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_santa_rita',
      title: l10n.novenaSantaRitaTitle,
      description: l10n.novenaSantaRitaDesc,
      icon: Icons.local_florist,
      openingPrayer: l10n.novenaSantaRitaOpening,
      closingPrayer: l10n.novenaSantaRitaClosing,
      prayerInstruction: l10n.novenaSantaRitaPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaSantaRitaDay1Title, meditation: l10n.novenaSantaRitaDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaSantaRitaDay2Title, meditation: l10n.novenaSantaRitaDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaSantaRitaDay3Title, meditation: l10n.novenaSantaRitaDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaSantaRitaDay4Title, meditation: l10n.novenaSantaRitaDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaSantaRitaDay5Title, meditation: l10n.novenaSantaRitaDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaSantaRitaDay6Title, meditation: l10n.novenaSantaRitaDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaSantaRitaDay7Title, meditation: l10n.novenaSantaRitaDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaSantaRitaDay8Title, meditation: l10n.novenaSantaRitaDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaSantaRitaDay9Title, meditation: l10n.novenaSantaRitaDay9Meditation),
      ],
    );
  }

  static NovenaContent _getCristoReiNovena(AppLocalizations l10n) {
    return NovenaContent(
      id: 'novena_cristo_rei',
      title: l10n.novenaCristoReiTitle,
      description: l10n.novenaCristoReiDesc,
      icon: Icons.workspace_premium,
      openingPrayer: l10n.novenaCristoReiOpening,
      closingPrayer: l10n.novenaCristoReiClosing,
      prayerInstruction: l10n.novenaCristoReiPrayers,
      days: [
        NovenaDay(dayNumber: 1, title: l10n.novenaCristoReiDay1Title, meditation: l10n.novenaCristoReiDay1Meditation),
        NovenaDay(dayNumber: 2, title: l10n.novenaCristoReiDay2Title, meditation: l10n.novenaCristoReiDay2Meditation),
        NovenaDay(dayNumber: 3, title: l10n.novenaCristoReiDay3Title, meditation: l10n.novenaCristoReiDay3Meditation),
        NovenaDay(dayNumber: 4, title: l10n.novenaCristoReiDay4Title, meditation: l10n.novenaCristoReiDay4Meditation),
        NovenaDay(dayNumber: 5, title: l10n.novenaCristoReiDay5Title, meditation: l10n.novenaCristoReiDay5Meditation),
        NovenaDay(dayNumber: 6, title: l10n.novenaCristoReiDay6Title, meditation: l10n.novenaCristoReiDay6Meditation),
        NovenaDay(dayNumber: 7, title: l10n.novenaCristoReiDay7Title, meditation: l10n.novenaCristoReiDay7Meditation),
        NovenaDay(dayNumber: 8, title: l10n.novenaCristoReiDay8Title, meditation: l10n.novenaCristoReiDay8Meditation),
        NovenaDay(dayNumber: 9, title: l10n.novenaCristoReiDay9Title, meditation: l10n.novenaCristoReiDay9Meditation),
      ],
    );
  }
}
