import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:provider/provider.dart';

import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/haptics_service.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/petal_shower.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';

enum RosaryPhase { opening, decade, closing }
enum BeadType { signCross, offering, creed, ourFather, hailMary, hailMaryFaith, hailMaryHope, hailMaryCharity, glory, fatima, salveRegina, meditation }

class RosaryPrayerPage extends StatefulWidget {
  final MysteryType mysteryType;

  const RosaryPrayerPage({super.key, required this.mysteryType});

  @override
  State<RosaryPrayerPage> createState() => _RosaryPrayerPageState();
}

class _RosaryPrayerPageState extends State<RosaryPrayerPage> {
  RosaryPhase _phase = RosaryPhase.opening;
  int _openingStep = 0;
  int _currentDecade = 1;
  int _currentBead = 0;
  int _closingStep = 0;

  @override
  void initState() {
    super.initState();
    // Mantém a tela acesa enquanto o terço é rezado.
    WakelockPlus.enable().catchError((_) {});
  }

  @override
  void dispose() {
    WakelockPlus.disable().catchError((_) {});
    super.dispose();
  }

  /// Resposta tátil (vibração leve), respeitando a opção nas configurações.
  void _haptic(HapticKind kind) {
    if (context.read<SettingsProvider>().hapticsEnabled) HapticsService.play(kind);
  }

  void _goNext() {
    final phaseBefore = _phase;
    final decadeBefore = _currentDecade;
    var finished = false;
    setState(() {
      if (_phase == RosaryPhase.opening) {
        if (_openingStep < 6) {
          _openingStep++;
        } else {
          _phase = RosaryPhase.decade;
          _currentDecade = 1;
          _currentBead = 0;
        }
      } else if (_phase == RosaryPhase.decade) {
        if (_currentBead < 13) {
          _currentBead++;
        } else {
          if (_currentDecade < 5) {
            _currentDecade++;
            _currentBead = 0;
          } else {
            _phase = RosaryPhase.closing;
            _closingStep = 0;
          }
        }
      } else if (_phase == RosaryPhase.closing) {
        // Salve Rainha is the only step in closing phase (step 0)
        // So we finish immediately
        finished = true;
        _showCompletionDialog();
      }
    });

    if (finished) {
      _haptic(HapticKind.finale); // terço concluído: três vibrações curtas
    } else if (phaseBefore == RosaryPhase.decade &&
        (_currentDecade != decadeBefore || _phase == RosaryPhase.closing)) {
      _haptic(HapticKind.decade); // fim de um mistério: vibração longa
    } else if (_phase != phaseBefore || _currentDecade != decadeBefore) {
      _haptic(HapticKind.medium); // novo mistério ou nova fase
    } else {
      _haptic(HapticKind.light); // próxima oração
    }
  }

  void _goPrevious() {
    if (_phase == RosaryPhase.opening && _openingStep == 0) return;
    
    setState(() {
      if (_phase == RosaryPhase.opening) {
        if (_openingStep > 0) _openingStep--;
      } else if (_phase == RosaryPhase.decade) {
        if (_currentBead > 0) {
          _currentBead--;
        } else {
          if (_currentDecade > 1) {
            _currentDecade--;
            _currentBead = 13;
          } else {
            _phase = RosaryPhase.opening;
            _openingStep = 6;
          }
        }
      } else if (_phase == RosaryPhase.closing) {
        if (_closingStep > 0) {
          _closingStep--;
        } else {
          _phase = RosaryPhase.decade;
          _currentDecade = 5;
          _currentBead = 13;
        }
      }
    });
    _haptic(HapticKind.selection);
  }

  Future<void> _showCompletionDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
    final traditional = Provider.of<SettingsProvider>(context, listen: false).isTraditionalRosary;

    // Determine specific ID based on mystery
    String prayerId = 'rosary';
    switch (widget.mysteryType) {
      case MysteryType.joyful:
        prayerId = 'rosary_joyful';
        break;
      case MysteryType.sorrowful:
        prayerId = 'rosary_sorrowful';
        break;
      case MysteryType.glorious:
        prayerId = 'rosary_glorious';
        break;
      case MysteryType.luminous:
        prayerId = 'rosary_luminous';
        break;
    }

    // logPrayer já faz o sync com dailyPrayers (e com o "Rosário completo") internamente
    await prayerProvider.logPrayer(_getMysteryName(l10n), DateTime.now(), prayerId: prayerId);

    // Também marca o ID genérico 'rosary' se existir no plano, para sincronizar com o terço genérico
    final hasGenericRosary = prayerProvider.availablePrayers.any((p) => p['id'] == 'rosary');
    if (hasGenericRosary) {
      // Idempotente: um segundo terço no mesmo dia não desmarca o do plano.
      await prayerProvider.markPrayerDoneToday('rosary', l10n.rosaryTitle);
    }
    if (!mounted) return;

    // Este terço fechou um Rosário? (3 terços no modo tradicional, 4 no atual)
    final per = PrayerProvider.chapletsPerRosary(traditional: traditional);
    final done = prayerProvider.chapletsToday;
    final fullRosary = done > 0 && done % per == 0;
    final String title = fullRosary ? l10n.rosaryFullComplete : l10n.rosaryComplete;
    final String detail = fullRosary
        ? l10n.rosaryFullDetail(done, done * 5)
        : l10n.rosaryProgress(done % per, per);

    // celebração: pétalas caem sobre a janela (como ao marcar a missa)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) showPetalShower(context, count: fullRosary ? 44 : 30);
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                builder: (_, t, child) => Transform.scale(scale: t.clamp(0.0, 1.4), child: child),
                child: Icon(fullRosary ? Icons.auto_awesome : Icons.check_circle, color: AppColors.accentGold, size: 60),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
            ),
            const SizedBox(height: 8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.secondaryText),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(l10n.backButton, style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  BeadType _getCurrentBeadType() {
    if (_phase == RosaryPhase.opening) {
      switch (_openingStep) {
        case 0: return BeadType.signCross;
        case 1: return BeadType.creed;
        case 2: return BeadType.ourFather;
        case 3: return BeadType.hailMaryFaith;
        case 4: return BeadType.hailMaryHope;
        case 5: return BeadType.hailMaryCharity;
        case 6: return BeadType.glory;
        default: return BeadType.signCross;
      }
    } else if (_phase == RosaryPhase.decade) {
      switch (_currentBead) {
        case 0: return BeadType.meditation;
        case 1: return BeadType.ourFather;
        case 12: return BeadType.glory;
        case 13: return BeadType.fatima;
        default: return BeadType.hailMary;
      }
    } else {
      return BeadType.salveRegina;
    }
  }

  String _getCurrentTitle(AppLocalizations l10n) {
    final beadType = _getCurrentBeadType();
    switch (beadType) {
      case BeadType.signCross: return l10n.prayerSignCrossTitle;
      case BeadType.offering: return l10n.prayerOfferingTitle;
      case BeadType.creed: return l10n.rosaryBeadCreed;
      case BeadType.ourFather: return l10n.rosaryBeadOurFather;
      case BeadType.hailMary: return l10n.rosaryBeadHailMary;
      case BeadType.hailMaryFaith: return l10n.rosaryHailMaryFaith;
      case BeadType.hailMaryHope: return l10n.rosaryHailMaryHope;
      case BeadType.hailMaryCharity: return l10n.rosaryHailMaryCharity;
      case BeadType.glory: return l10n.rosaryBeadGlory;
      case BeadType.fatima: return l10n.rosaryBeadFatima;
      case BeadType.salveRegina: return l10n.rosaryBeadSalveRegina;
      case BeadType.meditation: return l10n.rosaryMeditationTitle;
    }
  }

  String _getCurrentContent(AppLocalizations l10n) {
    final beadType = _getCurrentBeadType();
    switch (beadType) {
      case BeadType.signCross: return "${l10n.prayerSignCrossContent}\n\n${l10n.prayerOfferingContent}";
      case BeadType.offering: return l10n.prayerOfferingContent;
      case BeadType.creed: return l10n.prayerCredoContent;
      case BeadType.ourFather: return l10n.prayerPaterNosterContent;
      case BeadType.hailMary:
      case BeadType.hailMaryFaith:
      case BeadType.hailMaryHope:
      case BeadType.hailMaryCharity:
        return l10n.prayerAveMariaContent;
      case BeadType.glory: return l10n.prayerGloriaContent;
      case BeadType.fatima: return l10n.prayerFatimaContent;
      case BeadType.salveRegina: return l10n.prayerSalveContent;
      case BeadType.meditation: return _getMeditationContent(l10n);
    }
  }

  String _getMysteryTitle(AppLocalizations l10n) {
    final titles = {
      MysteryType.joyful: [l10n.joyful1Title, l10n.joyful2Title, l10n.joyful3Title, l10n.joyful4Title, l10n.joyful5Title],
      MysteryType.sorrowful: [l10n.sorrowful1Title, l10n.sorrowful2Title, l10n.sorrowful3Title, l10n.sorrowful4Title, l10n.sorrowful5Title],
      MysteryType.glorious: [l10n.glorious1Title, l10n.glorious2Title, l10n.glorious3Title, l10n.glorious4Title, l10n.glorious5Title],
      MysteryType.luminous: [l10n.luminous1Title, l10n.luminous2Title, l10n.luminous3Title, l10n.luminous4Title, l10n.luminous5Title],
    };
    return titles[widget.mysteryType]![_currentDecade - 1];
  }

  String _getMeditationContent(AppLocalizations l10n) {
    final meds = {
      MysteryType.joyful: [
        [l10n.joyful1Short, l10n.joyful1Full], [l10n.joyful2Short, l10n.joyful2Full],
        [l10n.joyful3Short, l10n.joyful3Full], [l10n.joyful4Short, l10n.joyful4Full],
        [l10n.joyful5Short, l10n.joyful5Full],
      ],
      MysteryType.sorrowful: [
        [l10n.sorrowful1Short, l10n.sorrowful1Full], [l10n.sorrowful2Short, l10n.sorrowful2Full],
        [l10n.sorrowful3Short, l10n.sorrowful3Full], [l10n.sorrowful4Short, l10n.sorrowful4Full],
        [l10n.sorrowful5Short, l10n.sorrowful5Full],
      ],
      MysteryType.glorious: [
        [l10n.glorious1Short, l10n.glorious1Full], [l10n.glorious2Short, l10n.glorious2Full],
        [l10n.glorious3Short, l10n.glorious3Full], [l10n.glorious4Short, l10n.glorious4Full],
        [l10n.glorious5Short, l10n.glorious5Full],
      ],
      MysteryType.luminous: [
        [l10n.luminous1Short, l10n.luminous1Full], [l10n.luminous2Short, l10n.luminous2Full],
        [l10n.luminous3Short, l10n.luminous3Full], [l10n.luminous4Short, l10n.luminous4Full],
        [l10n.luminous5Short, l10n.luminous5Full],
      ],
    };
    final med = meds[widget.mysteryType]![_currentDecade - 1];
    return "📖 ${l10n.rosaryMeditationResume}\n${med[0]}\n\n✝ ${l10n.rosaryMeditationComplete}\n${med[1]}";
  }

  String _getMysteryName(AppLocalizations l10n) {
    switch (widget.mysteryType) {
      case MysteryType.joyful: return l10n.mysteryJoyfulTitle;
      case MysteryType.sorrowful: return l10n.mysterySorrowfulTitle;
      case MysteryType.glorious: return l10n.mysteryGloriousTitle;
      case MysteryType.luminous: return l10n.mysteryLuminousTitle;
    }
  }

  int _getHailMaryCount() {
    if (_phase != RosaryPhase.decade) return 0;
    if (_currentBead >= 2 && _currentBead <= 11) return _currentBead - 1;
    if (_currentBead > 11) return 10;
    return 0;
  }

  // For opening prayers 3 Hail Marys
  int _getOpeningHailMaryCount() {
    if (_phase == RosaryPhase.opening && _openingStep >= 3 && _openingStep <= 5) {
      return _openingStep - 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = RosaryMysteriesPage.styleOf(widget.mysteryType);
    final color = style.color;
    final atStart = _phase == RosaryPhase.opening && _openingStep == 0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        body: Stack(
          children: [
            // Pintura no topo, esmaecendo até o fundo da tela
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 270,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(style.image, fit: BoxFit.cover, alignment: Alignment.topCenter, cacheWidth: 900),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.55),
                          Color.lerp(color, Colors.black, 0.5)!.withValues(alpha: 0.55),
                          AppColors.primaryBg,
                        ],
                        stops: const [0.0, 0.5, 0.97],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(l10n),
                  _buildHeroInfo(l10n, color),
                  const SizedBox(height: 4),
                  Expanded(child: _buildPrayerCard(l10n, color)),
                  _buildBeadArea(l10n, color),
                  _buildControls(l10n, color, atStart),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(AppLocalizations l10n) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              l10n.rosaryTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 56), // equilibra o botão de voltar
        ],
      ),
    );
  }

  /// Nome do mistério, qual dezena está sendo rezada e a barra de 5 etapas.
  Widget _buildHeroInfo(AppLocalizations l10n, Color color) {
    final String subtitle;
    if (_phase == RosaryPhase.decade) {
      // O título do mistério já traz o número ("2º Mistério: ...")
      subtitle = _getMysteryTitle(l10n);
    } else if (_phase == RosaryPhase.opening) {
      subtitle = l10n.rosaryOpeningPhase;
    } else {
      subtitle = l10n.rosaryClosingPhase;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            _getMysteryName(l10n),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14,
              shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (i) {
              final decade = i + 1;
              final done = _phase == RosaryPhase.closing ||
                  (_phase == RosaryPhase.decade && decade < _currentDecade);
              final current = _phase == RosaryPhase.decade && decade == _currentDecade;
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 5,
                  decoration: BoxDecoration(
                    color: current
                        ? Colors.white
                        : (done ? Colors.white.withValues(alpha: 0.75) : Colors.white.withValues(alpha: 0.28)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Cartão da oração (opaco, para boa leitura), com troca suave entre as contas.
  Widget _buildPrayerCard(AppLocalizations l10n, Color color) {
    final key = ValueKey('$_phase-$_openingStep-$_currentDecade-$_currentBead-$_closingStep');
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v < -100) {
          _goNext(); // arrastar para a esquerda -> próxima
        } else if (v > 100) {
          _goPrevious(); // arrastar para a direita -> anterior
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              key: key,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getCurrentTitle(l10n),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
                    child: Text(
                      _getCurrentContent(l10n),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 19,
                        height: 1.65,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Contas das Ave-Marias (10 da dezena ou as 3 iniciais). Altura fixa para a
  /// tela não "pular" quando as contas aparecem e somem.
  Widget _buildBeadArea(AppLocalizations l10n, Color color) {
    int total = 0;
    int current = 0;
    if (_phase == RosaryPhase.decade && _currentBead >= 2 && _currentBead <= 11) {
      total = 10;
      current = _getHailMaryCount();
    } else if (_phase == RosaryPhase.opening && _openingStep >= 3 && _openingStep <= 5) {
      total = 3;
      current = _getOpeningHailMaryCount();
    }

    return SizedBox(
      height: 58,
      child: total == 0
          ? const SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(total, (i) {
                    final done = i < current - 1;
                    final isCurrent = i == current - 1;
                    final size = isCurrent ? 22.0 : 16.0;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3.5),
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (done || isCurrent) ? color : Colors.transparent,
                        border: Border.all(
                          color: (done || isCurrent) ? color : color.withValues(alpha: 0.35),
                          width: 2,
                        ),
                        boxShadow: isCurrent
                            ? [BoxShadow(color: color.withValues(alpha: 0.45), blurRadius: 8, spreadRadius: 1)]
                            : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.rosaryHailMaryCount(current, total),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildControls(AppLocalizations l10n, Color color, bool atStart) {
    final isFinish = _phase == RosaryPhase.closing;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Row(
        children: [
          // Anterior
          SizedBox(
            width: 56,
            height: 56,
            child: OutlinedButton(
              onPressed: atStart ? null : _goPrevious,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                side: BorderSide(color: color.withValues(alpha: atStart ? 0.2 : 0.5), width: 2),
                foregroundColor: color,
              ),
              child: const Icon(Icons.chevron_left, size: 30),
            ),
          ),
          const SizedBox(width: 12),
          // Próxima / Finalizar
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _goNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isFinish ? l10n.rosaryFinish : l10n.rosaryNextBead,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      Icon(isFinish ? Icons.check_circle_outline : Icons.chevron_right, size: 26),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
