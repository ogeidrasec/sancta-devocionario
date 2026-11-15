import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/luta_tentacoes_page.dart';

enum PrayerType {
  prayer,
  novena,
  rosary,
  special, // For Exame Diário, Luta contra Tentações
}

class PrayerItem {
  final String id;
  final String title;
  final String? subtitle;
  final PrayerType type;
  final IconData icon;
  final String? content; // For simple prayers
  final Widget Function(BuildContext)? pageBuilder; // For navigation

  PrayerItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    required this.icon,
    this.content,
    this.pageBuilder,
  });
}

class PrayerData {
  static List<PrayerItem> getAllPrayers(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      // --- Special ---
      PrayerItem(
        id: 'rosary',
        title: l10n.rosaryTitle,
        type: PrayerType.rosary,
        icon: Icons.format_quote,
        pageBuilder: (context) => const RosaryMysteriesPage(),
      ),
      PrayerItem(
        id: 'rosary_joyful',
        title: l10n.mysteryJoyfulTitle,
        subtitle: l10n.mysteryJoyfulDays,
        type: PrayerType.rosary,
        icon: Icons.child_care,
        pageBuilder: (context) => const RosaryPrayerPage(mysteryType: MysteryType.joyful),
      ),
      PrayerItem(
        id: 'rosary_sorrowful',
        title: l10n.mysterySorrowfulTitle,
        subtitle: l10n.mysterySorrowfulDays,
        type: PrayerType.rosary,
        icon: Icons.favorite,
        pageBuilder: (context) => const RosaryPrayerPage(mysteryType: MysteryType.sorrowful),
      ),
      PrayerItem(
        id: 'rosary_glorious',
        title: l10n.mysteryGloriousTitle,
        subtitle: l10n.mysteryGloriousDays,
        type: PrayerType.rosary,
        icon: Icons.wb_sunny,
        pageBuilder: (context) => const RosaryPrayerPage(mysteryType: MysteryType.glorious),
      ),
      PrayerItem(
        id: 'exame_diario',
        title: l10n.catExameDiarioTitle,
        type: PrayerType.special,
        icon: Icons.today,
        pageBuilder: (context) => const ExameDiarioPage(),
      ),
      PrayerItem(
        id: 'luta_tentacoes',
        title: l10n.temptationFightTitle,
        type: PrayerType.special,
        icon: Icons.shield,
        pageBuilder: (context) => const LutaTentacoesPage(),
      ),

      // --- Novenas ---
      PrayerItem(
        id: 'novena_natal',
        title: l10n.novenaNatalTitle,
        subtitle: l10n.novenaNatalDesc,
        type: PrayerType.novena,
        icon: Icons.child_care,
        pageBuilder: (context) => const NovenaDetailPage(novenaId: 'natal'),
      ),
      PrayerItem(
        id: 'novena_carlo_acutis',
        title: l10n.novenaCarloAcutisTitle,
        subtitle: l10n.novenaCarloAcutisDesc,
        type: PrayerType.novena,
        icon: Icons.computer,
        pageBuilder: (context) => const NovenaDetailPage(novenaId: 'carlo_acutis'),
      ),
      PrayerItem(
        id: 'novena_teresa',
        title: l10n.novenaTeresaTitle,
        subtitle: l10n.novenaTeresaDesc,
        type: PrayerType.novena,
        icon: Icons.local_florist,
        pageBuilder: (context) => const NovenaDetailPage(novenaId: 'teresa_lisieux'),
      ),
      PrayerItem(
        id: 'novena_sagrado_coracao',
        title: l10n.novenaSagradoCoracaoTitle,
        subtitle: l10n.novenaSagradoCoracaoDesc,
        type: PrayerType.novena,
        icon: Icons.favorite,
        pageBuilder: (context) => const NovenaDetailPage(novenaId: 'sagrado_coracao'),
      ),

      // --- Main Prayers ---
      _buildPrayer(l10n.prayerSignCrossTitle, l10n.prayerSignCrossContent, Icons.add),
      _buildPrayer(l10n.prayerPaterNosterTitle, l10n.prayerPaterNosterContent, Icons.church),
      _buildPrayer(l10n.prayerAveMariaTitle, l10n.prayerAveMariaContent, Icons.favorite),
      _buildPrayer(l10n.prayerGloriaTitle, l10n.prayerGloriaContent, Icons.light_mode),
      _buildPrayer(l10n.prayerCredoTitle, l10n.prayerCredoContent, Icons.verified),
      _buildPrayer(l10n.prayerSalveTitle, l10n.prayerSalveContent, Icons.star),
      _buildPrayer(l10n.prayerGuardianAngelTitle, l10n.prayerGuardianAngelContent, Icons.security),
      _buildPrayer(l10n.prayerVeniCreatorTitle, l10n.prayerVeniCreatorContent, Icons.local_fire_department),

      // --- Daily Prayers ---
      _buildPrayer(l10n.prayerMorningTitle, l10n.prayerMorningContent, Icons.wb_sunny),
      _buildPrayer(l10n.prayerNightTitle, l10n.prayerNightContent, Icons.nights_stay),
      _buildPrayer(l10n.prayerStudiesTitle, l10n.prayerStudiesContent, Icons.school),
      _buildPrayer(l10n.prayerBeforeWorkTitle, l10n.prayerBeforeWorkContent, Icons.work),
      _buildPrayer(l10n.prayerMealsTitle, l10n.prayerMealsContent, Icons.restaurant),

      // --- Saints Prayers ---
      _buildPrayer(l10n.prayerStJosephTitle, l10n.prayerStJosephContent, Icons.handyman),
      _buildPrayer(l10n.prayerStThereseTitle, l10n.prayerStThereseContent, Icons.local_florist),
      _buildPrayer(l10n.prayerGuadalupeTitle, l10n.prayerGuadalupeContent, Icons.public),
      _buildPrayer(l10n.prayerCarloAcutisTitle, l10n.prayerCarloAcutisContent, Icons.computer),

      // --- Jaculatórias ---
      _buildPrayer(l10n.jaculatoriaSacredHeartTitle, l10n.jaculatoriaSacredHeartContent, Icons.favorite),
      _buildPrayer(l10n.jaculatoriaMeekHeartTitle, l10n.jaculatoriaMeekHeartContent, Icons.favorite_border),
      _buildPrayer(l10n.jaculatoriaMarySalvationTitle, l10n.jaculatoriaMarySalvationContent, Icons.volunteer_activism),
      _buildPrayer(l10n.jaculatoriaHolyFamilyTitle, l10n.jaculatoriaHolyFamilyContent, Icons.family_restroom),
      _buildPrayer(l10n.jaculatoriaImmaculateConceptionTitle, l10n.jaculatoriaImmaculateConceptionContent, Icons.star),
      _buildPrayer(l10n.jaculatoriaMercyTitle, l10n.jaculatoriaMercyContent, Icons.water_drop),

      // --- Litanies ---
      _buildPrayer(l10n.litanyLorettoTitle, l10n.litanyLorettoContent, Icons.star),
      _buildPrayer(l10n.litanySacredHeartTitle, l10n.litanySacredHeartContent, Icons.favorite),
      _buildPrayer(l10n.litanyAllSaintsTitle, l10n.litanyAllSaintsContent, Icons.people),
      _buildPrayer(l10n.litanyStJosephTitle, l10n.litanyStJosephContent, Icons.handyman),
      _buildPrayer(l10n.litanyHolyNameTitle, l10n.litanyHolyNameContent, Icons.brightness_7),
      _buildPrayer(l10n.litanySevenSorrowsTitle, l10n.litanySevenSorrowsContent, Icons.water_drop),
    ];
  }

  static PrayerItem _buildPrayer(String title, String content, IconData icon) {
    // Generate a simple ID from title (removing spaces/special chars)
    final id = title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    
    return PrayerItem(
      id: id,
      title: title,
      type: PrayerType.prayer,
      icon: icon,
      content: content,
      pageBuilder: (context) => PrayerDetailPage(title: title, content: content),
    );
  }
}
