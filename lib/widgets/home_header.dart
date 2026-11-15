import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Situação da confissão no topo do Exame: a última e a próxima, cada uma em
/// um cartão que abre a edição. A próxima mostra quantos dias faltam (ou de
/// quantos dias está atrasada).
class HomeHeader extends StatelessWidget {
  final DateTime? lastConfessionDate;
  final DateTime? proximaConfissao;
  final VoidCallback onEditUltimaConfissao;
  final VoidCallback onEditProximaConfissao;

  const HomeHeader({
    super.key,
    required this.lastConfessionDate,
    required this.proximaConfissao,
    required this.onEditUltimaConfissao,
    required this.onEditProximaConfissao,
  });

  String _getTempoDecorrido(BuildContext context, DateTime? data) {
    final l10n = AppLocalizations.of(context)!;
    if (data == null) return l10n.notRegistered;

    final dias = DateTime.now().difference(data).inDays;

    if (dias == 0) {
      return l10n.timeAgoToday;
    } else if (dias < 7) {
      return l10n.timeAgoDays(dias);
    } else if (dias < 30) {
      final semanas = (dias / 7).floor();
      final diasRestantes = dias % 7;
      if (diasRestantes == 0) {
        return l10n.timeAgoWeeks(semanas);
      } else {
        return '${l10n.timeAgoWeeks(semanas)}${l10n.timeAgoConnector}${l10n.timeAgoDays(diasRestantes)}';
      }
    } else if (dias < 365) {
      final meses = (dias / 30).floor();
      final diasRestantes = dias % 30;
      if (diasRestantes == 0) {
        return l10n.timeAgoMonths(meses);
      } else {
        final semanasRestantes = (diasRestantes / 7).floor();
        if (semanasRestantes > 0) {
          return '${l10n.timeAgoMonths(meses)}${l10n.timeAgoConnector}${l10n.timeAgoWeeks(semanasRestantes)}';
        } else {
          return '${l10n.timeAgoMonths(meses)}${l10n.timeAgoConnector}${l10n.timeAgoDays(diasRestantes)}';
        }
      }
    } else {
      final anos = (dias / 365).floor();
      final diasRestantes = dias % 365;
      final mesesRestantes = (diasRestantes / 30).floor();

      if (mesesRestantes == 0) {
        return l10n.timeAgoYears(anos);
      } else {
        return '${l10n.timeAgoYears(anos)}${l10n.timeAgoConnector}${l10n.timeAgoMonths(mesesRestantes)}';
      }
    }
  }

  /// Dias até a próxima confissão (negativo = atrasada), contando só a data.
  int? _daysUntilNext() {
    final next = proximaConfissao;
    if (next == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return DateTime(next.year, next.month, next.day).difference(today).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final days = _daysUntilNext();

    String? nextSub;
    var nextColor = AppColors.accentGold;
    if (days != null) {
      if (days < 0) {
        nextSub = l10n.nextConfessionOverdue(-days);
        nextColor = AppColors.errorColor;
      } else if (days == 0) {
        nextSub = l10n.nextConfessionToday;
      } else {
        nextSub = l10n.nextConfessionInDays(days);
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LiturgicalProvider>(
            builder: (context, liturgicalProvider, child) {
              final info = liturgicalProvider.getLiturgicalInfo(context, DateTime.now());
              if (info == null) return const SizedBox.shrink();
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.accentGold, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        info,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatusCard(
                    icon: Icons.history,
                    color: AppColors.themeColor,
                    label: l10n.lastConfessionLabel,
                    value: _getTempoDecorrido(context, lastConfessionDate),
                    sub: lastConfessionDate != null ? fmtDate(context, lastConfessionDate!) : null,
                    onTap: onEditUltimaConfissao,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatusCard(
                    icon: Icons.event,
                    color: nextColor,
                    label: l10n.nextConfessionLabel,
                    value: proximaConfissao != null ? fmtDate(context, proximaConfissao!) : l10n.planLabel,
                    sub: nextSub,
                    subColor: days != null && days < 0 ? AppColors.errorColor : null,
                    onTap: onEditProximaConfissao,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String? sub;
  final Color? subColor;
  final VoidCallback onTap;

  const _StatusCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.onTap,
    this.sub,
    this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: appCardDecoration(tint: color),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleIcon(icon: icon, color: color, size: 32),
                    const Spacer(),
                    const Icon(Icons.edit, size: 14, color: AppColors.secondaryText),
                  ],
                ),
                const SizedBox(height: 10),
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                if (sub != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    sub!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: subColor ?? AppColors.secondaryText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
