import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:intl/intl.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

class JornadaConfissaoPage extends StatelessWidget {
  const JornadaConfissaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InnerPageScaffold(
      title: l10n.jornadaTitle,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Card(
              margin: EdgeInsets.zero,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.themeColor,
                      AppColors.themeColor.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.jornadaHeaderTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.jornadaHeaderSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Confession History Timeline
            Consumer<ConfessionProvider>(
              builder: (context, confessionProvider, child) {
                if (confessionProvider.confessionHistory.isEmpty) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.themeColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.jornadaEmpty,
                              style: const TextStyle(color: AppColors.secondaryText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
                return Card(
                  margin: EdgeInsets.zero,
                  child: ExpansionTile(
                    shape: const Border(),
                    collapsedShape: const Border(),
                    leading: const Icon(Icons.timeline, color: AppColors.themeColor),
                    title: Text(
                      l10n.jornadaHistoryTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    subtitle: Text(
                      l10n.jornadaHistorySubtitle(confessionProvider.confessionHistory.length),
                      style: const TextStyle(color: AppColors.secondaryText, fontSize: 12),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: confessionProvider.confessionHistory.length,
                        itemBuilder: (context, index) {
                          final reversedIndex = confessionProvider.confessionHistory.length - 1 - index;
                          final entry = confessionProvider.confessionHistory[reversedIndex];
                          final date = entry['date'] as DateTime;
                          final penanceNote = entry['penanceNote'] as String?;
                          final penanceCompleted = entry['penanceCompleted'] as bool? ?? false;
                          final confessionId = entry['id'] as int;
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentGold.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.check_circle, color: AppColors.accentGold, size: 20),
                                ),
                                title: Text(
                                  fmtDate(context, date),
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  DateFormat('HH:mm').format(date),
                                  style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: AppColors.errorColor, size: 20),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(l10n.deleteConfessionTitle),
                                        content: Text(
                                          l10n.deleteConfessionContent(fmtDate(context, date)),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text(l10n.deleteConfessionCancel),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            style: TextButton.styleFrom(
                                              foregroundColor: AppColors.errorColor,
                                            ),
                                            child: Text(l10n.deleteConfessionConfirm),
                                          ),
                                        ],
                                      ),
                                    );
                                    
                                    if (confirm == true) {
                                      await confessionProvider.deleteConfession(reversedIndex);
                                    }
                                  },
                                  tooltip: l10n.deleteConfessionTitle,
                                ),
                              ),
                              if (penanceNote != null && penanceNote.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                                  child: InkWell(
                                    onTap: () {
                                      confessionProvider.togglePenanceCompleted(confessionId, !penanceCompleted);
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: penanceCompleted
                                            ? Colors.green.withValues(alpha: 0.1)
                                            : Colors.orange.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: penanceCompleted
                                              ? Colors.green.withValues(alpha: 0.3)
                                              : Colors.orange.withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            penanceCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                            size: 20,
                                            color: penanceCompleted ? Colors.green : Colors.orange,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  l10n.penanceLabel,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: penanceCompleted ? Colors.green : Colors.orange,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  penanceNote,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: penanceCompleted ? Colors.grey : AppColors.primaryText,
                                                    decoration: penanceCompleted ? TextDecoration.lineThrough : null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Expandable Educational Content Sections
            _buildExpandableSection(
              title: l10n.whyConfessTitle,
              icon: Icons.help_outline,
              content: _buildRichText(l10n.whyConfessContent),
            ),
            
            _buildExpandableSection(
              title: l10n.psychBenefitsTitle,
              icon: Icons.healing,
              content: _buildRichText(l10n.psychBenefitsContent),
            ),
            
            _buildExpandableSection(
              title: l10n.saintsWordsTitle,
              icon: Icons.auto_stories,
              content: _buildRichText(l10n.saintsWordsContent),
            ),
            
            _buildExpandableSection(
              title: l10n.tipsTitle,
              icon: Icons.favorite_border,
              content: _buildRichText(l10n.tipsContent),
            ),
            
            _buildExpandableSection(
              title: l10n.secrecyTitle,
              icon: Icons.lock,
              content: _buildRichText(l10n.secrecyContent),
            ),
            
            _buildExpandableSection(
              title: l10n.priestAttitudeTitle,
              icon: Icons.person,
              content: _buildRichText(l10n.priestAttitudeContent),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String text) {
    List<TextSpan> spans = [];
    final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*');
    
    int lastIndex = 0;
    
    for (final match in boldPattern.allMatches(text)) {
      // Add text before the match
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            color: AppColors.primaryText,
          ),
        ));
      }
      
      // Add the bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: AppColors.themeColor,
          fontWeight: FontWeight.w600,
        ),
      ));
      
      lastIndex = match.end;
    }
    
    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: AppColors.primaryText,
        ),
      ));
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        trailing: const Icon(
          Icons.expand_more,
          color: AppColors.themeColor,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ],
      ),
    );
  }
}
