import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/luta_tentacoes_page.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';

class PrayerData {
  static MysteryType getTodaysMystery() {
    final weekday = DateTime.now().weekday;
    switch (weekday) {
      case DateTime.monday:
      case DateTime.thursday:
        return MysteryType.joyful;
      case DateTime.tuesday:
      case DateTime.friday:
        return MysteryType.sorrowful;
      case DateTime.wednesday:
      case DateTime.saturday:
      case DateTime.sunday:
        return MysteryType.glorious;
      default:
        return MysteryType.joyful;
    }
  }

  /// Título de uma oração do plano no idioma atual. O título salvo no banco pode
  /// estar em outro idioma (ou ser o texto padrão em português); se a oração vem
  /// do catálogo, usa o título do catálogo.
  static String localizedPlanTitle(BuildContext context, Map<String, String> prayer) {
    final id = prayer['prayerId'] ?? prayer['id'];
    final fromCatalog = id == null ? null : getPrayerById(context, id);
    return (fromCatalog?['title'] as String?) ?? prayer['title'] ?? '';
  }

  /// Título de um registro de oração no idioma atual (o registro guarda o texto do
  /// idioma em que foi feito; se a oração é do catálogo, usa o título atual).
  static String localizedLogTitle(BuildContext context, Map<String, String> log) {
    final id = log['prayerId'];
    final fromCatalog = (id == null || id.isEmpty) ? null : getPrayerById(context, id);
    return (fromCatalog?['title'] as String?) ?? log['title'] ?? '';
  }

  static Map<String, dynamic>? getPrayerById(BuildContext context, String id) {
    final allPrayers = getAllPrayers(context);
    try {
      return allPrayers.firstWhere((p) => p['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> getAllPrayers(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      // --- Orações Principais ---
      {
        'id': 'sign_cross',
        'title': l10n.prayerSignCrossTitle,
        'content': l10n.prayerSignCrossContent,
        'contentLatin': l10n.prayerSignCrossContentLatin,
        'icon': Icons.add,
        'category': 'main'
      },
      {
        'id': 'pater_noster',
        'title': l10n.prayerPaterNosterTitle,
        'content': l10n.prayerPaterNosterContent,
        'contentLatin': l10n.prayerPaterNosterContentLatin,
        'icon': Icons.church,
        'category': 'main'
      },
      {
        'id': 'ave_maria',
        'title': l10n.prayerAveMariaTitle,
        'content': l10n.prayerAveMariaContent,
        'contentLatin': l10n.prayerAveMariaContentLatin,
        'icon': Icons.favorite,
        'category': 'main'
      },
      {
        'id': 'gloria',
        'title': l10n.prayerGloriaTitle,
        'content': l10n.prayerGloriaContent,
        'contentLatin': l10n.prayerGloriaContentLatin,
        'icon': Icons.light_mode,
        'category': 'main'
      },
      {
        'id': 'credo',
        'title': l10n.prayerCredoTitle,
        'content': l10n.prayerCredoContent,
        'contentLatin': l10n.prayerCredoContentLatin,
        'icon': Icons.verified,
        'category': 'main'
      },
      {
        'id': 'salve_rainha',
        'title': l10n.prayerSalveTitle,
        'content': l10n.prayerSalveContent,
        'contentLatin': l10n.prayerSalveContentLatin,
        'icon': Icons.star,
        'category': 'main'
      },
      {
        'id': 'guardian_angel',
        'title': l10n.prayerGuardianAngelTitle,
        'content': l10n.prayerGuardianAngelContent,
        'contentLatin': l10n.prayerGuardianAngelContentLatin,
        'icon': Icons.security,
        'category': 'main'
      },
      {
        'id': 'veni_creator',
        'title': l10n.prayerVeniCreatorTitle,
        'content': l10n.prayerVeniCreatorContent,
        'contentLatin': l10n.prayerVeniCreatorContentLatin,
        'icon': Icons.local_fire_department,
        'category': 'main'
      },
      {
        'id': 'maria_imaculada',
        'title': l10n.prayerMariaImaculadaTitle,
        'content': l10n.prayerMariaImaculadaContent,
        'contentLatin': l10n.prayerMariaImaculadaContentLatin,
        'icon': Icons.nightlight_round,
        'category': 'main',
        'defaultTime': 'night'
      },
      {
        'id': 'maria_imaculada_morning',
        'title': l10n.prayerMariaImaculadaMorningTitle,
        'content': l10n.prayerMariaImaculadaMorningContent,
        'contentLatin': l10n.prayerMariaImaculadaMorningContentLatin,
        'icon': Icons.wb_sunny,
        'category': 'main',
        'defaultTime': 'morning'
      },
      {
        'id': 'anima_christi',
        'title': l10n.prayerAnimaChristiTitle,
        'content': l10n.prayerAnimaChristiContent,
        'contentLatin': l10n.prayerAnimaChristiContentLatin,
        'icon': Icons.water_drop,
        'category': 'main'
      },
      {
        'id': 'spiritual_communion',
        'title': l10n.prayerSpiritualCommunionTitle,
        'content': l10n.prayerSpiritualCommunionContent,
        'contentLatin': l10n.prayerSpiritualCommunionContentLatin,
        'icon': Icons.church,
        'category': 'main'
      },
      {
        'id': 'self_offering',
        'title': l10n.prayerSelfOfferingTitle,
        'content': l10n.prayerSelfOfferingContent,
        'contentLatin': l10n.prayerSelfOfferingContentLatin,
        'icon': Icons.volunteer_activism,
        'category': 'main'
      },

      // --- Orações Diárias ---
      {
        'id': 'morningOffering', // Matches AppState ID
        'title': l10n.prayerMorningTitle,
        'content': l10n.prayerMorningContent,
        'icon': Icons.wb_sunny,
        'category': 'daily'
      },
      {
        'id': 'angelus', // Matches AppState ID
        'title': l10n.prayerAngelusTitle,
        'content': l10n.prayerAngelusContent,
        'icon': Icons.notifications_active, // Bell icon for Angelus
        'category': 'daily'
      },
      {
        'id': 'prayerReginaCaeli',
        'title': l10n.prayerReginaCaeliTitle,
        'content': l10n.prayerReginaCaeliContent,
        'icon': Icons.workspace_premium,
        'category': 'daily'
      },
      {
        'id': 'nightPrayer', // Matches AppState ID
        'title': l10n.prayerNightTitle,
        'content': l10n.prayerNightContent,
        'icon': Icons.nights_stay,
        'category': 'daily'
      },
      {
        'id': 'prayerStudies',
        'title': l10n.prayerStudiesTitle,
        'content': l10n.prayerStudiesContent,
        'icon': Icons.school,
        'category': 'daily'
      },
      {
        'id': 'prayerBeforeWork',
        'title': l10n.prayerBeforeWorkTitle,
        'content': l10n.prayerBeforeWorkContent,
        'icon': Icons.work,
        'category': 'daily'
      },
      {
        'id': 'prayerMeals',
        'title': l10n.prayerMealsTitle,
        'content': l10n.prayerMealsContent,
        'contentLatin': l10n.prayerMealsContentLatin,
        'icon': Icons.restaurant,
        'category': 'daily'
      },

      // --- Devoções aos Santos ---
      {
        'id': 'st_joseph',
        'title': l10n.prayerStJosephTitle,
        'content': l10n.prayerStJosephContent,
        'icon': Icons.handyman,
        'category': 'saints'
      },
      {
        'id': 'st_therese',
        'title': l10n.prayerStThereseTitle,
        'content': l10n.prayerStThereseContent,
        'icon': Icons.local_florist,
        'category': 'saints'
      },
      {
        'id': 'guadalupe',
        'title': l10n.prayerGuadalupeTitle,
        'content': l10n.prayerGuadalupeContent,
        'icon': Icons.public,
        'category': 'saints'
      },
      {
        'id': 'carlo_acutis',
        'title': l10n.prayerCarloAcutisTitle,
        'content': l10n.prayerCarloAcutisContent,
        'icon': Icons.computer,
        'category': 'saints'
      },

      // --- Jaculatórias ---
      {
        'id': 'jac_sacred_heart',
        'title': l10n.jaculatoriaSacredHeartTitle,
        'content': l10n.jaculatoriaSacredHeartContent,
        'icon': Icons.favorite,
        'category': 'jaculatorias'
      },
      {
        'id': 'jac_meek_heart',
        'title': l10n.jaculatoriaMeekHeartTitle,
        'content': l10n.jaculatoriaMeekHeartContent,
        'icon': Icons.favorite_border,
        'category': 'jaculatorias'
      },
      {
        'id': 'jac_mary_salvation',
        'title': l10n.jaculatoriaMarySalvationTitle,
        'content': l10n.jaculatoriaMarySalvationContent,
        'icon': Icons.volunteer_activism,
        'category': 'jaculatorias'
      },
      {
        'id': 'jac_holy_family',
        'title': l10n.jaculatoriaHolyFamilyTitle,
        'content': l10n.jaculatoriaHolyFamilyContent,
        'icon': Icons.family_restroom,
        'category': 'jaculatorias'
      },
      {
        'id': 'jac_immaculate',
        'title': l10n.jaculatoriaImmaculateConceptionTitle,
        'content': l10n.jaculatoriaImmaculateConceptionContent,
        'icon': Icons.star,
        'category': 'jaculatorias'
      },
      {
        'id': 'jac_mercy',
        'title': l10n.jaculatoriaMercyTitle,
        'content': l10n.jaculatoriaMercyContent,
        'icon': Icons.water_drop,
        'category': 'jaculatorias'
      },

      // --- Ladainhas ---
      {
        'id': 'litany_loretto',
        'title': l10n.litanyLorettoTitle,
        'content': l10n.litanyLorettoContent,
        'icon': Icons.star,
        'category': 'litanies'
      },
      {
        'id': 'litany_sacred_heart',
        'title': l10n.litanySacredHeartTitle,
        'content': l10n.litanySacredHeartContent,
        'icon': Icons.favorite,
        'category': 'litanies'
      },
      {
        'id': 'litany_all_saints',
        'title': l10n.litanyAllSaintsTitle,
        'content': l10n.litanyAllSaintsContent,
        'icon': Icons.people,
        'category': 'litanies'
      },
      {
        'id': 'litany_st_joseph',
        'title': l10n.litanyStJosephTitle,
        'content': l10n.litanyStJosephContent,
        'icon': Icons.handyman,
        'category': 'litanies'
      },
      {
        'id': 'litany_holy_name',
        'title': l10n.litanyHolyNameTitle,
        'content': l10n.litanyHolyNameContent,
        'icon': Icons.brightness_7,
        'category': 'litanies'
      },
      {
        'id': 'litany_seven_sorrows',
        'title': l10n.litanySevenSorrowsTitle,
        'content': l10n.litanySevenSorrowsContent,
        'icon': Icons.water_drop,
        'category': 'litanies'
      },

      // --- Special Items (Navigation) ---
      {
        'id': 'daily_examination', // Matches AppState ID
        'title': l10n.catExameDiarioTitle,
        'content': '', // No content, uses route
        'icon': Icons.today,
        'route': (context) => const ExameDiarioPage(prayerId: 'daily_examination'),
        'category': 'special'
      },
      {
        'id': 'full_examination',
        'title': l10n.examinationTitle, // "Exame de Consciência"
        'content': '',
        'icon': Icons.assignment,
        'category': 'special'
      },
      {
        'id': 'rosary', // Matches AppState ID
        'title': l10n.rosaryTitle,
        'content': '', // No content, uses route
        'icon': Icons.radio_button_checked,
        'route': (context) => RosaryPrayerPage(mysteryType: getTodaysMystery()),
        'category': 'special'
      },
      {
        'id': 'rosary_joyful',
        'title': l10n.mysteryJoyfulTitle,
        'content': '',
        'icon': Icons.radio_button_checked,
        'route': (context) => const RosaryPrayerPage(mysteryType: MysteryType.joyful),
        'category': 'special'
      },
      {
        'id': 'rosary_sorrowful',
        'title': l10n.mysterySorrowfulTitle,
        'content': '',
        'icon': Icons.radio_button_checked,
        'route': (context) => const RosaryPrayerPage(mysteryType: MysteryType.sorrowful),
        'category': 'special'
      },
      {
        'id': 'rosary_glorious',
        'title': l10n.mysteryGloriousTitle,
        'content': '',
        'icon': Icons.radio_button_checked,
        'route': (context) => const RosaryPrayerPage(mysteryType: MysteryType.glorious),
        'category': 'special'
      },
      {
        'id': 'luta_tentacoes',
        'title': l10n.temptationFightTitle,
        'content': '',
        'icon': Icons.shield,
        'route': (context) => const LutaTentacoesPage(prayerId: 'luta_tentacoes'),
        'category': 'special'
      },
      {
        'id': 'threeHailMarys',
        'title': l10n.threeHailMarysTitle,
        'content': l10n.threeHailMarysContent,
        'icon': Icons.favorite,
        'category': 'daily'
      },

      // --- Fase 1: sacramentos, salmos, devoções e orações essenciais ---
      {
        'id': 'act_contrition',
        'title': l10n.prayerActContritionTitle,
        'content': l10n.prayerActContritionContent,
        'icon': Icons.favorite_border,
        'category': 'sacraments'
      },
      {
        'id': 'confiteor',
        'title': l10n.prayerConfiteorTitle,
        'content': l10n.prayerConfiteorContent,
        'contentLatin': l10n.prayerConfiteorContentLatin,
        'icon': Icons.back_hand,
        'category': 'sacraments'
      },
      {
        'id': 'before_confession',
        'title': l10n.prayerBeforeConfessionTitle,
        'content': l10n.prayerBeforeConfessionContent,
        'icon': Icons.lightbulb_outline,
        'category': 'sacraments'
      },
      {
        'id': 'after_confession',
        'title': l10n.prayerAfterConfessionTitle,
        'content': l10n.prayerAfterConfessionContent,
        'icon': Icons.volunteer_activism,
        'category': 'sacraments'
      },
      {
        'id': 'before_communion',
        'title': l10n.prayerBeforeCommunionTitle,
        'content': l10n.prayerBeforeCommunionContent,
        'icon': Icons.church,
        'category': 'sacraments'
      },
      {
        'id': 'after_communion',
        'title': l10n.prayerAfterCommunionTitle,
        'content': l10n.prayerAfterCommunionContent,
        'icon': Icons.local_florist,
        'category': 'sacraments'
      },
      {
        'id': 'theological_acts',
        'title': l10n.prayerTheologicalActsTitle,
        'content': l10n.prayerTheologicalActsContent,
        'icon': Icons.auto_awesome,
        'category': 'sacraments'
      },
      {
        'id': 'tantum_ergo',
        'title': l10n.prayerTantumErgoTitle,
        'content': l10n.prayerTantumErgoContent,
        'contentLatin': l10n.prayerTantumErgoContentLatin,
        'icon': Icons.brightness_7,
        'category': 'sacraments'
      },
      {
        'id': 'psalm_50',
        'title': l10n.prayerPsalm50Title,
        'content': l10n.prayerPsalm50Content,
        'contentLatin': l10n.prayerPsalm50ContentLatin,
        'icon': Icons.water_drop,
        'category': 'psalms'
      },
      {
        'id': 'psalm_129',
        'title': l10n.prayerPsalm129Title,
        'content': l10n.prayerPsalm129Content,
        'contentLatin': l10n.prayerPsalm129ContentLatin,
        'icon': Icons.nights_stay,
        'category': 'psalms'
      },
      {
        'id': 'psalm_22',
        'title': l10n.prayerPsalm22Title,
        'content': l10n.prayerPsalm22Content,
        'contentLatin': l10n.prayerPsalm22ContentLatin,
        'icon': Icons.grass,
        'category': 'psalms'
      },
      {
        'id': 'magnificat',
        'title': l10n.prayerMagnificatTitle,
        'content': l10n.prayerMagnificatContent,
        'contentLatin': l10n.prayerMagnificatContentLatin,
        'icon': Icons.music_note,
        'category': 'psalms'
      },
      {
        'id': 'via_sacra',
        'title': l10n.prayerViaSacraTitle,
        'content': l10n.prayerViaSacraContent,
        'icon': Icons.directions_walk,
        'category': 'devotions'
      },
      {
        'id': 'divine_mercy_chaplet',
        'title': l10n.prayerDivineMercyChapletTitle,
        'content': l10n.prayerDivineMercyChapletContent,
        'icon': Icons.water_drop,
        'category': 'devotions'
      },
      {
        'id': 'memorare',
        'title': l10n.prayerMemorareTitle,
        'content': l10n.prayerMemorareContent,
        'contentLatin': l10n.prayerMemorareContentLatin,
        'icon': Icons.favorite,
        'category': 'main'
      },
      {
        'id': 'st_michael',
        'title': l10n.prayerStMichaelTitle,
        'content': l10n.prayerStMichaelContent,
        'contentLatin': l10n.prayerStMichaelContentLatin,
        'icon': Icons.shield,
        'category': 'main'
      },
      {
        'id': 'eternal_rest',
        'title': l10n.prayerEternalRestTitle,
        'content': l10n.prayerEternalRestContent,
        'contentLatin': l10n.prayerEternalRestContentLatin,
        'icon': Icons.wb_twilight,
        'category': 'main'
      },
      {
        'id': 'grace_after_meals',
        'title': l10n.prayerGraceAfterMealsTitle,
        'content': l10n.prayerGraceAfterMealsContent,
        'contentLatin': l10n.prayerGraceAfterMealsContentLatin,
        'icon': Icons.restaurant,
        'category': 'daily'
      },

      // --- Fase 5: santos, ladainhas e consagrações ---
      {
        'id': 'st_francis_peace',
        'title': l10n.prayerStFrancisPeaceTitle,
        'content': l10n.prayerStFrancisPeaceContent,
        'contentLatin': l10n.prayerStFrancisPeaceContentLatin,
        'icon': Icons.eco,
        'category': 'saints'
      },
      {
        'id': 'st_benedict_medal',
        'title': l10n.prayerStBenedictMedalTitle,
        'content': l10n.prayerStBenedictMedalContent,
        'contentLatin': l10n.prayerStBenedictMedalContentLatin,
        'icon': Icons.shield_outlined,
        'category': 'saints'
      },
      {
        'id': 'universal_prayer_clement_xi',
        'title': l10n.prayerUniversalClementTitle,
        'content': l10n.prayerUniversalClementContent,
        'contentLatin': l10n.prayerUniversalClementContentLatin,
        'icon': Icons.wb_twilight,
        'category': 'devotions'
      },
      {
        'id': 'st_teresa_avila',
        'title': l10n.prayerStTeresaAvilaTitle,
        'content': l10n.prayerStTeresaAvilaContent,
        'contentLatin': l10n.prayerStTeresaAvilaContentLatin,
        'icon': Icons.bookmark_border,
        'category': 'saints'
      },
      {
        'id': 'st_augustine',
        'title': l10n.prayerStAugustineTitle,
        'content': l10n.prayerStAugustineContent,
        'contentLatin': l10n.prayerStAugustineContentLatin,
        'icon': Icons.lightbulb_outline,
        'category': 'saints'
      },
      {
        'id': 'st_anthony',
        'title': l10n.prayerStAnthonyTitle,
        'content': l10n.prayerStAnthonyContent,
        'contentLatin': l10n.prayerStAnthonyContentLatin,
        'icon': Icons.menu_book,
        'category': 'saints'
      },
      {
        'id': 'st_rita',
        'title': l10n.prayerStRitaTitle,
        'content': l10n.prayerStRitaContent,
        'contentLatin': l10n.prayerStRitaContentLatin,
        'icon': Icons.local_florist,
        'category': 'saints'
      },
      {
        'id': 'litany_humility',
        'title': l10n.prayerLitanyHumilityTitle,
        'content': l10n.prayerLitanyHumilityContent,
        'contentLatin': l10n.prayerLitanyHumilityContentLatin,
        'icon': Icons.south,
        'category': 'litanies'
      },
      {
        'id': 'litany_precious_blood',
        'title': l10n.prayerLitanyPreciousBloodTitle,
        'content': l10n.prayerLitanyPreciousBloodContent,
        'contentLatin': l10n.prayerLitanyPreciousBloodContentLatin,
        'icon': Icons.water_drop,
        'category': 'litanies'
      },
      {
        'id': 'litany_blessed_sacrament',
        'title': l10n.prayerLitanyBlessedSacramentTitle,
        'content': l10n.prayerLitanyBlessedSacramentContent,
        'contentLatin': l10n.prayerLitanyBlessedSacramentContentLatin,
        'icon': Icons.brightness_7,
        'category': 'litanies'
      },
      {
        'id': 'litany_holy_angels',
        'title': l10n.prayerLitanyHolyAngelsTitle,
        'content': l10n.prayerLitanyHolyAngelsContent,
        'contentLatin': l10n.prayerLitanyHolyAngelsContentLatin,
        'icon': Icons.cloud_outlined,
        'category': 'litanies'
      },
      {
        'id': 'litany_good_death',
        'title': l10n.prayerLitanyGoodDeathTitle,
        'content': l10n.prayerLitanyGoodDeathContent,
        'contentLatin': l10n.prayerLitanyGoodDeathContentLatin,
        'icon': Icons.nights_stay,
        'category': 'litanies'
      },
      {
        'id': 'consec_totus_tuus',
        'title': l10n.prayerConsecTotusTuusTitle,
        'content': l10n.prayerConsecTotusTuusContent,
        'contentLatin': l10n.prayerConsecTotusTuusContentLatin,
        'icon': Icons.favorite,
        'category': 'consecrations'
      },
      {
        'id': 'consec_montfort',
        'title': l10n.prayerConsecMontfortTitle,
        'content': l10n.prayerConsecMontfortContent,
        'contentLatin': l10n.prayerConsecMontfortContentLatin,
        'icon': Icons.star,
        'category': 'consecrations'
      },
      {
        'id': 'consec_sacred_heart',
        'title': l10n.prayerConsecSacredHeartTitle,
        'content': l10n.prayerConsecSacredHeartContent,
        'contentLatin': l10n.prayerConsecSacredHeartContentLatin,
        'icon': Icons.favorite_border,
        'category': 'consecrations'
      },
      {
        'id': 'consec_st_joseph',
        'title': l10n.prayerConsecStJosephTitle,
        'content': l10n.prayerConsecStJosephContent,
        'contentLatin': l10n.prayerConsecStJosephContentLatin,
        'icon': Icons.home,
        'category': 'consecrations'
      },
    ];
  }
}
