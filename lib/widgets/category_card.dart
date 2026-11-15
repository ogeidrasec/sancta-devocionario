import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Linha de uma etapa do Exame (mesmo estilo dos itens de Orações e Novenas).
class CategoryCard extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onTap;

  /// Texto do selo (ex.: "3 marcados"); nulo = sem selo.
  final String? badge;

  const CategoryCard({
    super.key,
    required this.categoria,
    required this.onTap,
    this.badge,
  });

  IconData _getIcon(String iconeName) {
    switch (iconeName) {
      case 'favorite':
        return Icons.favorite;
      case 'format_list_numbered':
        return Icons.format_list_numbered;
      case 'access_time':
        return Icons.access_time;
      case 'filter_9_plus':
        return Icons.filter_9_plus;
      case 'church':
        return Icons.church;
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'today':
        return Icons.today;
      case 'local_florist':
        return Icons.local_florist;
      case 'format_quote':
        return Icons.format_quote;
      case 'assignment':
        return Icons.assignment;
      case 'more_horiz':
        return Icons.more_horiz;
      case 'calendar_month':
        return Icons.calendar_month;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = AppColors.themeColor;
    final marked = badge != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: appCardDecoration(tint: color).copyWith(
        border: Border.all(
          color: color.withValues(alpha: categoria.highlight || marked ? 0.5 : 0.15),
          width: categoria.highlight || marked ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleIcon(icon: _getIcon(categoria.icone), color: color),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoria.titulo,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        categoria.subtitulo,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.3,
                          color: AppColors.secondaryText.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
