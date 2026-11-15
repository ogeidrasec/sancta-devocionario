import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Caderno de intenções: por quem e pelo quê o usuário reza, com a opção de
/// marcar as graças recebidas.
class IntentionsPage extends StatelessWidget {
  const IntentionsPage({super.key});

  static const _color = Color(0xFF2E7D6B);

  Future<void> _edit(BuildContext context, {Map<String, dynamic>? existing}) async {
    final l10n = AppLocalizations.of(context)!;
    final prayers = context.read<PrayerProvider>();
    final controller = TextEditingController(text: existing?['text'] as String? ?? '');
    final saved = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? l10n.intentionsAdd : l10n.intentionsEditTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 200,
          minLines: 2,
          maxLines: 5,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: l10n.intentionsHint),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancelButton)),
          TextButton(onPressed: () => Navigator.pop(ctx, controller.text), child: Text(l10n.saveButton)),
        ],
      ),
    );
    final text = saved?.trim() ?? '';
    if (text.isEmpty) return;
    if (existing == null) {
      await prayers.addIntention(text);
    } else {
      await prayers.updateIntention(existing['id'] as String, text);
    }
  }

  Future<void> _delete(BuildContext context, Map<String, dynamic> item) async {
    final l10n = AppLocalizations.of(context)!;
    final prayers = context.read<PrayerProvider>();
    final messenger = ScaffoldMessenger.of(context);
    await prayers.deleteIntention(item['id'] as String);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.intentionsDeleted),
        action: SnackBarAction(
          label: l10n.undoAction,
          textColor: AppColors.accentGold,
          onPressed: () => prayers.restoreIntention(item),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = Provider.of<PrayerProvider>(context);
    final all = prayers.intentions;
    final open = all.where((i) => i['answered'] != true).toList();
    final answered = all.where((i) => i['answered'] == true).toList();

    Widget section(String label, List<Map<String, dynamic>> items) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionLabel(label),
            for (final i in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _IntentionTile(
                  item: i,
                  onToggle: () => prayers.toggleIntentionAnswered(i['id'] as String),
                  onEdit: () => _edit(context, existing: i),
                  onDelete: () => _delete(context, i),
                ),
              ),
            const SizedBox(height: 8),
          ],
        );

    return InnerPageScaffold(
      title: l10n.intentionsTitle,
      subtitle: l10n.intentionsSubtitle,
      color: _color,
      bottom: PillButton(
        label: l10n.intentionsAdd,
        icon: Icons.add,
        color: _color,
        onPressed: () => _edit(context),
      ),
      child: all.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  l10n.intentionsEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, height: 1.5, color: AppColors.secondaryText),
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                if (open.isNotEmpty) section(l10n.intentionsOpenSection, open),
                if (answered.isNotEmpty) section(l10n.intentionsAnsweredSection, answered),
              ],
            ),
    );
  }
}

class _IntentionTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _IntentionTile({
    required this.item,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final answered = item['answered'] == true;
    final created = DateTime.tryParse(item['created'] as String? ?? '');

    return Container(
      decoration: appCardDecoration(tint: IntentionsPage._color),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            tooltip: answered ? l10n.intentionsMarkOpen : l10n.intentionsMarkAnswered,
            onPressed: onToggle,
            icon: Icon(
              answered ? Icons.check_circle : Icons.circle_outlined,
              color: answered ? AppColors.successColor : AppColors.secondaryText,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['text'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.35,
                      color: AppColors.primaryText,
                      decoration: answered ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (created != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        fmtDate(context, created),
                        style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                      ),
                    ),
                ],
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (v) => v == 'edit' ? onEdit() : onDelete(),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'edit', child: Text(l10n.intentionsEdit)),
              PopupMenuItem(value: 'delete', child: Text(l10n.intentionsDelete)),
            ],
          ),
        ],
      ),
    );
  }
}
