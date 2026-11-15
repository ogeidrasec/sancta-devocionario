import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart'; // Para MysteryType
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart'; // Para RosaryPrayerPage
import '../../../providers/prayer_provider.dart';
import 'prayer_edit_dialog.dart';


// Helper classes for unified prayer list
enum PrayerType { planned, logged }

class PrayerListItem {
  final String id;
  final String title;
  final PrayerType type;
  final bool isCompleted;
  final String? time;
  final DateTime? timestamp;

  PrayerListItem({
    required this.id,
    required this.title,
    required this.type,
    required this.isCompleted,
    this.time,
    this.timestamp,
  });
}

class PrayerTile extends StatelessWidget {
  final PrayerListItem prayer;
  final String dateKey;
  final PrayerProvider prayerProvider;
  final bool isTraditionalRosary;

  const PrayerTile({
    super.key, 
    required this.prayer, 
    required this.dateKey, 
    required this.prayerProvider,
    this.isTraditionalRosary = true,
  });

  @override
  Widget build(BuildContext context) {
    // Try to get localized title from PrayerData using ID, fallback to stored title
    // First, try to find the original prayerId if it's a unique ID (e.g. prayer_123456)
    String lookupId = prayer.id;
    
    // Check if it's a unique ID with timestamp (contains underscore and ends with digits)
    if (prayer.id.contains('_')) {
      final lastUnderscore = prayer.id.lastIndexOf('_');
      if (lastUnderscore > 0) {
        final possibleTimestamp = prayer.id.substring(lastUnderscore + 1);
        // Check if it looks like a timestamp (digits, usually 13 chars for millis)
        if (possibleTimestamp.length >= 10 && int.tryParse(possibleTimestamp) != null) {
          // Try to find the base ID in available prayers to be sure
          final originalPrayer = prayerProvider.availablePrayers.firstWhere(
            (p) => p['id'] == prayer.id,
            orElse: () => <String, String>{},
          );
          
          if (originalPrayer.isNotEmpty && originalPrayer['prayerId'] != null) {
            lookupId = originalPrayer['prayerId']!;
          } else {
            // Fallback: assume the part before underscore is the ID
            lookupId = prayer.id.substring(0, lastUnderscore);
          }
        }
      }
    }

    final prayerData = PrayerData.getPrayerById(context, lookupId);
    final displayTitle = prayerData?['title'] ?? prayer.title;

    final planned = prayer.type == PrayerType.planned;
    final reminder = planned ? _activeReminder() : null;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppColors.themeColor.withValues(alpha: 0.15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _handleTap(context),
        // Segurar também abre as opções (deslizar fica livre para trocar de aba).
        onLongPress: planned ? () => _showActions(context, displayTitle) : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
          child: Row(
            children: [
              // Checkbox
              InkWell(
                key: ValueKey('check_${prayer.id}_$dateKey'),
                onTap: planned ? () => _toggleCompletion(context) : null,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: prayer.isCompleted ? AppColors.themeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: prayer.isCompleted ? AppColors.themeColor : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: prayer.isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: prayer.isCompleted ? TextDecoration.lineThrough : null,
                        color: prayer.isCompleted ? Colors.grey : AppColors.primaryText,
                      ),
                    ),
                    if (prayer.timestamp != null)
                      Text(
                        DateFormat('HH:mm').format(prayer.timestamp!),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    // O lembrete aparece como informação, junto do nome
                    if (reminder != null && reminder.times.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          key: ValueKey('reminder_info_${prayer.id}'),
                          children: [
                            const Icon(Icons.notifications_active, size: 13, color: AppColors.accentGold),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${reminder.times.first.format(context)} · ${reminder.getFrequencyDescription(context)}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (planned)
                IconButton(
                  key: ValueKey('more_${prayer.id}'),
                  tooltip: l10n.prayerMoreOptions,
                  icon: const Icon(Icons.more_vert, color: AppColors.secondaryText),
                  onPressed: () => _showActions(context, displayTitle),
                ),
              if (prayer.type == PrayerType.logged)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.check_circle, size: 16, color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Abre o menu de opções e executa a escolhida.
  Future<void> _showActions(BuildContext context, String displayTitle) async {
    final action = await _chooseAction(context, displayTitle);
    if (!context.mounted || action == null) return;
    switch (action) {
      case 'open':
        _handleTap(context);
      case 'edit':
        _editPrayer(context);
      case 'remove':
        await _confirmRemove(context, displayTitle);
    }
  }

  Future<void> _confirmRemove(BuildContext context, String displayTitle) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removePrayerTitle),
        content: Text(l10n.removePrayerContent(displayTitle)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.removeButton, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    await prayerProvider.removePrayer(prayer.id);
    messenger.showSnackBar(SnackBar(content: Text(l10n.prayerRemovedMessage(displayTitle))));
  }

  /// Menu em folha (o mesmo estilo do "+"): abrir, ajustar ou excluir a oração.
  Future<String?> _chooseAction(BuildContext context, String displayTitle) {
    final l10n = AppLocalizations.of(context)!;
    Widget choice(BuildContext ctx, String value, IconData icon, Color color, String title, String desc) {
      return Container(
        decoration: appCardDecoration(tint: color),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            key: ValueKey('prayer_action_$value'),
            borderRadius: BorderRadius.circular(18),
            onTap: () => Navigator.pop(ctx, value),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleIcon(icon: icon, color: color, size: 46),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                        const SizedBox(height: 2),
                        Text(desc, style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: color),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.primaryBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                displayTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.prayerActionsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
              ),
              const SizedBox(height: 16),
              choice(ctx, 'open', Icons.menu_book_outlined, AppColors.themeColor, l10n.prayerActionOpen, l10n.prayerActionOpenDesc),
              const SizedBox(height: 10),
              choice(ctx, 'edit', Icons.schedule, AppColors.accentGold, l10n.prayerActionEdit, l10n.prayerActionEditDesc),
              const SizedBox(height: 10),
              choice(ctx, 'remove', Icons.delete_outline, Colors.red, l10n.prayerActionRemove, l10n.prayerActionRemoveDesc),
            ],
          ),
        ),
      ),
    );
  }

  /// Lembrete ligado desta oração (ou da novena), se houver.
  ReminderModel? _activeReminder() {
    final reminder = prayerProvider.getReminderById('prayer_${prayer.id}') ??
        prayerProvider.getReminderById('novena_${prayer.id}');
    return reminder != null && reminder.isActive ? reminder : null;
  }

  void _toggleCompletion(BuildContext context) {
    // Unified toggle: handles checkbox AND history sync
    prayerProvider.toggleDailyPrayer(dateKey, prayer.id, title: prayer.title);
  }


  void _editPrayer(BuildContext context) async {
    // Get current prayer configuration from availablePrayers
    final currentPrayer = prayerProvider.availablePrayers.firstWhere(
      (p) => p['id'] == prayer.id,
      orElse: () => {},
    );

    // Try to get localized title from PrayerData using ID, fallback to stored title
    // First, try to find the original prayerId if it's a unique ID (e.g. prayer_123456)
    String lookupId = prayer.id;
    
    // Check if it's a unique ID with timestamp (contains underscore and ends with digits)
    if (prayer.id.contains('_')) {
      final lastUnderscore = prayer.id.lastIndexOf('_');
      if (lastUnderscore > 0) {
        final possibleTimestamp = prayer.id.substring(lastUnderscore + 1);
        // Check if it looks like a timestamp (digits, usually 13 chars for millis)
        if (possibleTimestamp.length >= 10 && int.tryParse(possibleTimestamp) != null) {
          // Try to find the base ID in available prayers to be sure
          final originalPrayer = prayerProvider.availablePrayers.firstWhere(
            (p) => p['id'] == prayer.id,
            orElse: () => <String, String>{},
          );
          
          if (originalPrayer.isNotEmpty && originalPrayer['prayerId'] != null) {
            lookupId = originalPrayer['prayerId']!;
          } else {
            // Fallback: assume the part before underscore is the ID
            lookupId = prayer.id.substring(0, lastUnderscore);
          }
        }
      }
    }

    final prayerData = PrayerData.getPrayerById(context, lookupId);
    final displayTitle = prayerData?['title'] ?? prayer.title;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => PrayerEditDialog(
        prayerId: prayer.id,
        prayerTitle: displayTitle,
        currentDefaultTime: currentPrayer['defaultTime'],
        currentReminderTime: currentPrayer['reminderTime'],
        currentFrequency: currentPrayer['frequency'],
      ),
    );

    if (result != null) {
      // Update default time if changed
      final newDefaultTime = result['defaultTime'] as String;
      if (newDefaultTime != currentPrayer['defaultTime']) {
        // Update in database
        prayerProvider.updatePrayerTime(prayer.id, newDefaultTime);
      }

      // Handle reminder
      final hasReminder = result['hasReminder'] as bool;
      if (hasReminder) {
        final reminderTime = result['reminderTime'] as TimeOfDay;
        final frequency = result['frequency'] as String;
        
        await prayerProvider.setPrayerReminder(
          prayer.id,
          reminderTime,
          frequency: frequency,
          title: displayTitle,
        );
      } else {
        // Remove reminder if disabled
        await prayerProvider.setPrayerReminder(prayer.id, null);
      }

      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.prayerUpdatedSuccess(displayTitle))),
        );
      }
    }
  }

  void _handleTap(BuildContext context) {
    // Obter o prayerId original: pode estar no campo 'prayerId' do availablePrayers ou extraído do ID
    final availablePrayer = prayerProvider.availablePrayers.firstWhere(
      (p) => p['id'] == prayer.id,
      orElse: () => <String, String>{},
    );
    // O prayerId original é armazenado no campo 'prayerId', ou use o ID se não houver
    String originalPrayerId = availablePrayer['prayerId'] ?? prayer.id;
    
    // Fallback: se o ID contém underscore + timestamp, extrair o original
    // Ex: guardianAngel_1705188000 -> guardianAngel
    if (originalPrayerId == prayer.id && prayer.id.contains('_')) {
      final lastUnderscore = prayer.id.lastIndexOf('_');
      if (lastUnderscore > 0) {
        final possibleTimestamp = prayer.id.substring(lastUnderscore + 1);
        // Verificar se é um timestamp (13 dígitos)
        if (possibleTimestamp.length >= 13 && int.tryParse(possibleTimestamp) != null) {
          originalPrayerId = prayer.id.substring(0, lastUnderscore);
        }
      }
    }
    
    final prayerData = PrayerData.getPrayerById(context, originalPrayerId);
    
    if (prayer.id.startsWith('novena_') || originalPrayerId.startsWith('novena_')) {
      final novenaId = originalPrayerId.startsWith('novena_') ? originalPrayerId : prayer.id;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NovenaDetailPage(novenaId: novenaId),
        ),
      );
    } else if (originalPrayerId == 'rosary') {
      // Santo Terço: Abrir o mistério do dia automaticamente
      final isTraditional = isTraditionalRosary;
      final todaysMystery = _getTodaysMystery(isTraditional);
      _navigateToRosary(context, todaysMystery);
    } else if (originalPrayerId.startsWith('rosary_')) {
      // Mistério específico selecionado
      MysteryType mysteryType;
      switch (originalPrayerId) {
        case 'rosary_joyful':
          mysteryType = MysteryType.joyful;
          break;
        case 'rosary_sorrowful':
          mysteryType = MysteryType.sorrowful;
          break;
        case 'rosary_luminous':
          mysteryType = MysteryType.luminous;
          break;
        case 'rosary_glorious':
        default:
          mysteryType = MysteryType.glorious;
      }
      _navigateToRosary(context, mysteryType);
    } else if (originalPrayerId == 'full_examination') {
      MainScaffold.of(context)?.switchToTab(4); // Switch to Examination Tab (agora índice 4)
    } else if (prayerData != null && prayerData.isNotEmpty) {
      if (prayerData.containsKey('route')) {
        Navigator.push(context, MaterialPageRoute(builder: prayerData['route'] as WidgetBuilder));
      } else if (prayerData.containsKey('content') && (prayerData['content'] as String).isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrayerDetailPage(
              title: prayerData['title'] as String,
              content: prayerData['content'] as String,
              contentLatin: prayerData['contentLatin'] as String?,
              prayerId: prayer.id, // Pass unique ID for correct toggling
            ),
          ),
        );
      }
    }
  }


  // Método auxiliar para navegar para página do terço
  void _navigateToRosary(BuildContext context, MysteryType mysteryType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RosaryPrayerPage(mysteryType: mysteryType),
      ),
    );
  }

  // Método auxiliar para determinar o mistério do dia
  MysteryType _getTodaysMystery(bool isTraditional) {
    final weekday = DateTime.now().weekday;
    if (isTraditional) {
      // Tradicional (pré-2002): 3 mistérios
      switch (weekday) {
        case DateTime.monday:
        case DateTime.thursday:
          return MysteryType.joyful;
        case DateTime.tuesday:
        case DateTime.friday:
          return MysteryType.sorrowful;
        default:
          return MysteryType.glorious;
      }
    } else {
      // Com Luminosos (pós-2002): 4 mistérios
      switch (weekday) {
        case DateTime.monday:
        case DateTime.saturday:
          return MysteryType.joyful;
        case DateTime.tuesday:
        case DateTime.friday:
          return MysteryType.sorrowful;
        case DateTime.thursday:
          return MysteryType.luminous;
        default:
          return MysteryType.glorious;
      }
    }
  }
}
