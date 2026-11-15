import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:intl/intl.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

class NovenaDetailPage extends StatefulWidget {
  final String novenaId;

  const NovenaDetailPage({
    super.key,
    required this.novenaId,
  });

  @override
  State<NovenaDetailPage> createState() => _NovenaDetailPageState();
}

class _NovenaDetailPageState extends State<NovenaDetailPage> {
  late int _selectedDay;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDay = 1;
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
    final currentDay = prayerProvider.getNovenaDay(widget.novenaId);
    if (currentDay >= 1 && currentDay <= 9) {
      _selectedDay = currentDay;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(_selectedDay - 1);
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final currentDay = prayerProvider.getNovenaDay(widget.novenaId);
    final isActive = prayerProvider.isNovenaActive(widget.novenaId);
    final startDate = prayerProvider.getNovenaStartDate(widget.novenaId);
    final isScheduled = startDate != null && currentDay < 1;
    final isStarted = isActive || isScheduled;
    final timesCompleted = prayerProvider.novenaTimesCompleted(widget.novenaId);
    final lastCompletion = prayerProvider.lastNovenaCompletion(widget.novenaId);
    
    // Get novena content from data source
    final novenaContent = NovenaData.getNovenaById(context, widget.novenaId);

    return InnerPageScaffold(
      title: novenaContent.title,
      subtitle: isActive
          ? l10n.novenaDayProgress(currentDay, 9)
          : (isScheduled ? l10n.novenaScheduled(fmtDayMonth(context, startDate)) : null),
      actions: isStarted
          ? [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                tooltip: l10n.novenaCancelTitle,
                onPressed: () => _showCancelDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                tooltip: l10n.novenaRestartTitle,
                onPressed: () => _showResetDialog(context),
              ),
            ]
          : const [],
      child: Column(
        children: [
          // Day selector
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: 70, // espaço para fontes maiores
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final isSelected = _selectedDay == day;
                  final isCurrentDay = currentDay == day && isActive;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 50,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.accentGold
                            : isCurrentDay
                                ? AppColors.themeColor.withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: isCurrentDay && !isSelected
                            ? Border.all(color: AppColors.themeColor, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              l10n.novenaDayLabel,
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected 
                                    ? AppColors.primaryText
                                    : Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          Text(
                            '$day',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? AppColors.primaryText
                                  : Colors.white,
                            ),
                          ),
                          // Dia já rezado: marca de conferido
                          if (prayerProvider.isNovenaDayDone(widget.novenaId, day))
                            Icon(
                              Icons.check_circle,
                              size: 12,
                              color: isSelected ? AppColors.successColor : const Color(0xFFA5D6A7),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Start button banner (when not started)
          if (!isStarted)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: appCardDecoration(radius: 20),
              child: Column(
                children: [
                  Text(
                    timesCompleted > 0 && lastCompletion != null
                        ? l10n.novenaPrayedBefore(
                            timesCompleted,
                            fmtDate(context, lastCompletion),
                          )
                        : l10n.novenaSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showStartOptionsDialog(context),
                    icon: Icon(timesCompleted > 0 ? Icons.refresh : Icons.play_arrow),
                    label: Text(timesCompleted > 0 ? l10n.novenaStartAgain : l10n.novenaStartButton),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ],
              ),
            )
          else if (isScheduled)
             Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: appCardDecoration(tint: AppColors.accentGold, radius: 20),
              child: Column(
                children: [
                  Text(
                    l10n.novenaScheduledMessage,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fmtDate(context, startDate),
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (prayerProvider.getNovenaReminderTime(widget.novenaId) != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.novenaReminderMessage(prayerProvider.getNovenaReminderTime(widget.novenaId)!),
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          
          // Page content
          Expanded(
            child: PageView.builder(
                  controller: _pageController,
                  itemCount: 9,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedDay = index + 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    return _buildDayContent(context, day, novenaContent);
                  },
                ),
          ),
        ],
      ),
    );
  }

  /// Botão "Marcar dia como rezado": só no dia corrente da novena. Usa o mesmo
  /// registro da aba Hoje do Jardim, então os dois ficam sempre em sincronia.
  Widget _buildDayDoneButton(BuildContext context, int day, NovenaContent novenaContent) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final isCurrentDay = prayerProvider.isNovenaActive(widget.novenaId) &&
        prayerProvider.getNovenaDay(widget.novenaId) == day;
    if (!isCurrentDay) return const SizedBox.shrink();

    final todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    final dailyId = '${widget.novenaId}_day_$day';
    final done = prayerProvider.isDailyPrayerCompleted(todayKey, dailyId);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => prayerProvider.toggleDailyPrayer(
          todayKey,
          dailyId,
          title: '${novenaContent.title} - ${l10n.novenaDay(day)}',
        ),
        icon: Icon(done ? Icons.check_circle : Icons.check_circle_outline),
        label: Text(done ? l10n.novenaDayDoneLabel(day) : l10n.novenaMarkDayDone(day)),
        style: ElevatedButton.styleFrom(
          backgroundColor: done ? AppColors.successColor : AppColors.accentGold,
          foregroundColor: done ? Colors.white : AppColors.primaryText,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDayContent(BuildContext context, int day, NovenaContent novenaContent) {
    final l10n = AppLocalizations.of(context)!;
    
    // Get content for the specific day
    final dayContent = novenaContent.days.firstWhere(
      (d) => d.dayNumber == day,
      orElse: () => NovenaDay(dayNumber: day, title: '${l10n.novenaDayLabel} $day', meditation: ''),
    );

    String dayTitle = dayContent.title;
    if (dayTitle.isEmpty) {
       dayTitle = '${l10n.novenaDayLabel} $day';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
            child: Column(
              children: [
                Text(
                  l10n.novenaDayProgress(day, 9),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dayTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDayDoneButton(context, day, novenaContent),
          const SizedBox(height: 24),
          
          // Opening Prayer
          if (novenaContent.openingPrayer.isNotEmpty) ...[
            _buildPrayerSection(
              l10n.novenaOpeningPrayerLabel,
              novenaContent.openingPrayer,
              Icons.play_arrow,
            ),
            const SizedBox(height: 20),
          ],
          
          // Meditation (only show if not empty)
          if (dayContent.meditation.isNotEmpty) ...[
            _buildPrayerSection(
              l10n.novenaMeditationLabel,
              dayContent.meditation,
              Icons.lightbulb_outline,
            ),
            const SizedBox(height: 20),
          ],
          
          // Prayer instruction
          if (novenaContent.prayerInstruction.isNotEmpty) ...[
            _buildPrayerSection(
              l10n.novenaPrayersLabel,
              novenaContent.prayerInstruction,
              Icons.church,
            ),
          ],
          
          // Closing Prayer (only show if not empty)
          if (novenaContent.closingPrayer.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildPrayerSection(
              l10n.novenaClosingPrayerLabel,
              novenaContent.closingPrayer,
              Icons.check_circle_outline,
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPrayerSection(String label, String content, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  void _showStartOptionsDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    DateTime startDate = DateTime.now();
    TimeOfDay? reminderTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              l10n.novenaConfigTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.novenaConfigStartDate,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => startDate = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20, color: AppColors.themeColor),
                        const SizedBox(width: 8),
                        Text(
                          fmtDate(context, startDate),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.novenaConfigReminder,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: reminderTime ?? TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => reminderTime = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.alarm, size: 20, color: AppColors.themeColor),
                        const SizedBox(width: 8),
                        Text(
                          reminderTime != null 
                              ? reminderTime!.format(context)
                              : l10n.novenaConfigNoReminder,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (reminderTime != null) ...[
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () => setState(() => reminderTime = null),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.cancelButton,
                  style: const TextStyle(color: AppColors.secondaryText),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final novenaTitle = NovenaData.getNovenaById(context, widget.novenaId).title;
                  Provider.of<PrayerProvider>(context, listen: false).startNovena(
                    widget.novenaId,
                    startDate: startDate,
                    reminderTime: reminderTime,
                    title: novenaTitle,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.novenaStartedMessage),
                      backgroundColor: AppColors.themeColor,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(l10n.novenaStartButton),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.novenaRestartTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          l10n.novenaRestartContent,
          style: const TextStyle(color: AppColors.secondaryText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancelButton,
              style: const TextStyle(color: AppColors.secondaryText),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Restart immediately (today)
              final novenaTitle = NovenaData.getNovenaById(context, widget.novenaId).title;
              Provider.of<PrayerProvider>(context, listen: false).startNovena(
                widget.novenaId, 
                title: novenaTitle,
              );
              Navigator.pop(context);
              setState(() {
                _selectedDay = 1;
              });
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.novenaStartedMessage),
                  backgroundColor: AppColors.themeColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(l10n.novenaRestartConfirm),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.novenaCancelTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          l10n.novenaCancelContent,
          style: const TextStyle(color: AppColors.secondaryText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.novenaCancelDismiss,
              style: const TextStyle(color: AppColors.secondaryText),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<PrayerProvider>(context, listen: false).cancelNovena(widget.novenaId);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to novena list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(l10n.novenaCancelConfirm),
          ),
        ],
      ),
    );
  }
}
