import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/garden_heatmap.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Durante o guia, a aba Exame aparece aberta (sem pedir a senha), mas com
/// dados de exemplo: os dados reais e a senha nunca são lidos nem mostrados.
class TourPreview {
  static final examOpen = ValueNotifier<bool>(false);
}

/// Rolagem das telas principais. O guia volta cada tela ao topo antes de
/// mostrar os pontos dela: se a pessoa tinha rolado a lista ou aberto uma
/// categoria (menu sanfonado), o campo de busca e o resto ficariam fora da tela.
class AppTourScroll {
  static final today = ScrollController();
  static final prayers = ScrollController();
  static final novenas = ScrollController();
  static final rosary = ScrollController();
  static final exam = ScrollController();
  static ScrollController? forTab(int? tab) => switch (tab) {
        0 => today,
        1 => prayers,
        2 => novenas,
        3 => rosary,
        4 => exam,
        _ => null,
      };
}

/// Pontos da tela que o guia ilumina. Cada chave fica em um único widget.
class AppTourKeys {
  static final navGarden = GlobalKey(debugLabel: 'tour_nav_garden');
  static final navPrayers = GlobalKey(debugLabel: 'tour_nav_prayers');
  static final navNovenas = GlobalKey(debugLabel: 'tour_nav_novenas');
  static final navRosary = GlobalKey(debugLabel: 'tour_nav_rosary');
  static final navExam = GlobalKey(debugLabel: 'tour_nav_exam');
  static final menu = GlobalKey(debugLabel: 'tour_menu');
  static final garden = GlobalKey(debugLabel: 'tour_garden');
  static final tabToday = GlobalKey(debugLabel: 'tour_tab_today');
  static final tabCalendar = GlobalKey(debugLabel: 'tour_tab_calendar');
  static final tabReminders = GlobalKey(debugLabel: 'tour_tab_reminders');
  static final addButton = GlobalKey(debugLabel: 'tour_add');
  static final prayerSearch = GlobalKey(debugLabel: 'tour_prayer_search');
  static final prayerGuides = GlobalKey(debugLabel: 'tour_prayer_guides');
  static final novenaSearch = GlobalKey(debugLabel: 'tour_novena_search');
  static final novenaList = GlobalKey(debugLabel: 'tour_novena_list');
  static final rosaryProgress = GlobalKey(debugLabel: 'tour_rosary_progress');
  static final rosaryToday = GlobalKey(debugLabel: 'tour_rosary_today');
  static final examHeader = GlobalKey(debugLabel: 'tour_exam_header');
  static final examJornada = GlobalKey(debugLabel: 'tour_exam_jornada');
  static final examSections = GlobalKey(debugLabel: 'tour_exam_sections');
  static final examGuide = GlobalKey(debugLabel: 'tour_exam_guide');
}

/// Um passo do guia: o que iluminar, em qual aba, e o texto.
class TourStep {
  final GlobalKey? target;
  final int? tab;
  final IconData icon;
  final String title;
  final String body;
  const TourStep({this.target, this.tab, required this.icon, required this.title, required this.body});
}

/// Os passos do guia, na ordem em que aparecem.
List<TourStep> buildAppTourSteps(AppLocalizations l10n) => [
      TourStep(icon: Icons.waving_hand, title: l10n.tourWelcomeTitle, body: l10n.tourWelcomeBody, tab: 0),
      TourStep(target: AppTourKeys.navGarden, tab: 0, icon: Icons.park, title: l10n.tourNavGardenTitle, body: l10n.tourNavGardenBody),
      TourStep(target: AppTourKeys.garden, tab: 0, icon: Icons.grass, title: l10n.tourGardenTitle, body: l10n.tourGardenBody),
      TourStep(target: AppTourKeys.tabToday, tab: 0, icon: Icons.wb_sunny_outlined, title: l10n.tourTodayTitle, body: l10n.tourTodayBody),
      TourStep(target: AppTourKeys.addButton, tab: 0, icon: Icons.add_circle, title: l10n.tourAddTitle, body: l10n.tourAddBody),
      TourStep(target: AppTourKeys.tabCalendar, tab: 0, icon: Icons.calendar_month, title: l10n.tourCalendarTitle, body: l10n.tourCalendarBody),
      TourStep(target: AppTourKeys.tabReminders, tab: 0, icon: Icons.notifications_active, title: l10n.tourRemindersTitle, body: l10n.tourRemindersBody),
      TourStep(target: AppTourKeys.menu, tab: 0, icon: Icons.menu, title: l10n.tourMenuTitle, body: l10n.tourMenuBody),
      TourStep(target: AppTourKeys.navPrayers, tab: 1, icon: Icons.church, title: l10n.tourPrayersTitle, body: l10n.tourPrayersBody),
      TourStep(target: AppTourKeys.prayerSearch, tab: 1, icon: Icons.search, title: l10n.tourSearchTitle, body: l10n.tourSearchBody),
      TourStep(target: AppTourKeys.prayerGuides, tab: 1, icon: Icons.menu_book, title: l10n.tourGuidesTitle, body: l10n.tourGuidesBody),
      TourStep(target: AppTourKeys.navNovenas, tab: 2, icon: Icons.local_florist, title: l10n.tourNovenasTitle, body: l10n.tourNovenasBody),
      TourStep(target: AppTourKeys.novenaSearch, tab: 2, icon: Icons.search, title: l10n.tourNovenaSearchTitle, body: l10n.tourNovenaSearchBody),
      TourStep(target: AppTourKeys.novenaList, tab: 2, icon: Icons.play_circle, title: l10n.tourNovenaStartTitle, body: l10n.tourNovenaStartBody),
      TourStep(target: AppTourKeys.navRosary, tab: 3, icon: Icons.auto_awesome, title: l10n.tourRosaryTitle, body: l10n.tourRosaryBody),
      TourStep(target: AppTourKeys.rosaryProgress, tab: 3, icon: Icons.radio_button_checked, title: l10n.tourRosaryProgressTitle, body: l10n.tourRosaryProgressBody),
      TourStep(target: AppTourKeys.rosaryToday, tab: 3, icon: Icons.touch_app, title: l10n.tourRosaryTodayTitle, body: l10n.tourRosaryTodayBody),
      TourStep(target: AppTourKeys.navExam, tab: 4, icon: Icons.assignment, title: l10n.tourExamTitle, body: l10n.tourExamBody),
      TourStep(target: AppTourKeys.examHeader, tab: 4, icon: Icons.event_available, title: l10n.tourExamHeaderTitle, body: l10n.tourExamHeaderBody),
      TourStep(target: AppTourKeys.examJornada, tab: 4, icon: Icons.menu_book, title: l10n.tourExamJornadaTitle, body: l10n.tourExamJornadaBody),
      TourStep(target: AppTourKeys.examSections, tab: 4, icon: Icons.checklist, title: l10n.tourExamSectionsTitle, body: l10n.tourExamSectionsBody),
      TourStep(target: AppTourKeys.examGuide, tab: 4, icon: Icons.arrow_forward, title: l10n.tourExamGuideTitle, body: l10n.tourExamGuideBody),
      TourStep(icon: Icons.favorite, title: l10n.tourEndTitle, body: l10n.tourEndBody, tab: 0),
    ];

/// Camada do guia: escurece a tela, abre um "buraco" iluminado sobre o ponto
/// do passo e mostra um balão com o texto e os botões.
class AppTourOverlay extends StatefulWidget {
  final List<TourStep> steps;
  final ValueChanged<int> onTabChange;
  final VoidCallback onFinish;
  const AppTourOverlay({super.key, required this.steps, required this.onTabChange, required this.onFinish});

  @override
  State<AppTourOverlay> createState() => _AppTourOverlayState();
}

class _AppTourOverlayState extends State<AppTourOverlay> with TickerProviderStateMixin {
  // Ritmo do guia: some, troca de aba, espera a tela assentar, desliza o foco
  // até o novo ponto e só então mostra o balão.
  static const _fadeOut = Duration(milliseconds: 220);
  static const _tabSettle = Duration(milliseconds: 550);
  static const _sameTabSettle = Duration(milliseconds: 120);
  static const _moveDuration = Duration(milliseconds: 520);
  static const _tapGuard = Duration(milliseconds: 700);

  int _index = 0;
  int? _currentTab;
  Rect? _from;
  Rect? _to;
  double? _navTop; // topo da barra de baixo: o balão para logo acima dela
  bool _visible = false;
  bool _busy = false;
  DateTime _shownAt = DateTime.fromMillisecondsSinceEpoch(0);

  late final AnimationController _pulse =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
  late final AnimationController _move = AnimationController(vsync: this, duration: _moveDuration);
  late final Animation<double> _moveCurve = CurvedAnimation(parent: _move, curve: Curves.easeInOutCubic);

  TourStep get _step => widget.steps[_index];

  /// Buraco mostrado agora (interpolado entre o ponto anterior e o novo).
  Rect? get _hole {
    final a = _from, b = _to;
    if (a == null && b == null) return null;
    final t = _moveCurve.value;
    final start = a ?? Rect.fromCenter(center: b!.center, width: 0, height: 0);
    final end = b ?? Rect.fromCenter(center: a!.center, width: 0, height: 0);
    final r = Rect.lerp(start, end, t)!;
    return (b == null && t >= 1) ? null : r;
  }

  @override
  void initState() {
    super.initState();
    // Durante o guia o Jardim mostra um exemplo verde e florido.
    _pulse.addListener(_track);
    // troca de aba só depois do primeiro quadro (não durante o build)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      GardenDemo.active.value = true;
      TourPreview.examOpen.value = true;
      _start();
    });
  }

  /// Espera a tela terminar de entrar (no primeiro uso ela chega deslizando,
  /// vinda das boas-vindas) antes de medir os pontos.
  Future<void> _start() async {
    if (!mounted) return;
    final anim = ModalRoute.of(context)?.animation;
    if (anim != null && anim.status != AnimationStatus.completed) {
      final done = Completer<void>();
      void l(AnimationStatus s) {
        if (s == AnimationStatus.completed && !done.isCompleted) done.complete();
      }
      anim.addStatusListener(l);
      await done.future.timeout(const Duration(seconds: 2), onTimeout: () {});
      anim.removeStatusListener(l);
    }
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) _goTo(0);
  }

  /// Acompanha o ponto iluminado: se a tela mudar de lugar (rolagem, teclado,
  /// conteúdo carregando), o foco e o balão seguem junto.
  void _track() {
    if (!_visible || _busy || _to == null) return;
    final rect = _rectOf(_step.target)?.inflate(8);
    if (rect == null) return;
    final d = (rect.topLeft - _to!.topLeft).distance + (rect.size - _to!.size as Offset).distance;
    if (d > 1) setState(() => _from = _to = rect);
  }

  @override
  void dispose() {
    // fora do build: o Jardim volta a mostrar os dados reais
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GardenDemo.active.value = false;
      TourPreview.examOpen.value = false;
    });
    WidgetsBinding.instance.scheduleFrame();
    _pulse.removeListener(_track);
    _pulse.dispose();
    _move.dispose();
    super.dispose();
  }

  /// Vai para o passo [i] com calma: esconde o balão, troca de aba se preciso,
  /// espera a tela se redesenhar, mede o alvo e desliza o foco até ele.
  Future<void> _goTo(int i) async {
    if (_busy) return;
    _busy = true;
    final step = widget.steps[i];
    if (_visible) {
      setState(() => _visible = false);
      await Future.delayed(_fadeOut);
      if (!mounted) return;
    }
    final changesTab = step.tab != null && step.tab != _currentTab;
    setState(() => _index = i);
    if (changesTab) {
      _currentTab = step.tab;
      widget.onTabChange(step.tab!);
    }
    await Future.delayed(changesTab ? _tabSettle : _sameTabSettle);
    if (!mounted) return;
    if (step.tab == 0) await _showTodaySubtab();
    if (!mounted) return;
    if (changesTab || (step.target != null && step.target!.currentContext == null)) {
      await _scrollToTop(AppTourScroll.forTab(step.tab));
      if (!mounted) return;
    }
    await _scrollTargetIntoView(step.target);
    if (!mounted) return;
    final rect = await _measure(attempts: 10);
    if (!mounted) return;
    final nav = _rectOf(AppTourKeys.navGarden);
    if (nav != null) _navTop = nav.top - 22;
    final current = _hole;
    setState(() {
      _from = current;
      _to = rect?.inflate(8);
    });
    await _move.forward(from: 0).orCancel.catchError((_) {});
    if (!mounted) return;
    setState(() {
      _visible = true;
      _shownAt = DateTime.now();
    });
    _busy = false;
  }

  /// Volta a lista da aba ao topo (só as que estiverem na tela).
  Future<void> _scrollToTop(ScrollController? c) async {
    if (c == null || !c.hasClients) return;
    final moving = <Future<void>>[];
    for (final p in c.positions) {
      if (p.pixels > p.minScrollExtent + 1) {
        moving.add(p.animateTo(p.minScrollExtent, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut));
      }
    }
    if (moving.isEmpty) return;
    await Future.wait(moving);
    await WidgetsBinding.instance.endOfFrame;
  }

  /// No Jardim, garante a sub-aba Hoje (a pessoa pode ter deixado Calendário
  /// ou Lembretes abertos).
  Future<void> _showTodaySubtab() async {
    final ctx = AppTourKeys.tabToday.currentContext;
    if (ctx == null) return;
    final tc = DefaultTabController.maybeOf(ctx);
    if (tc == null || tc.index == 0) return;
    tc.animateTo(0);
    await Future.delayed(const Duration(milliseconds: 400));
  }

  /// Se o ponto está numa lista que rola na vertical, rola só essa lista até
  /// ele ficar visível (sem mexer em abas ou páginas que rolam na horizontal).
  Future<void> _scrollTargetIntoView(GlobalKey? key) async {
    final ctx = key?.currentContext;
    if (ctx == null || !ctx.mounted) return;
    try {
      final scrollable = Scrollable.maybeOf(ctx, axis: Axis.vertical);
      final box = ctx.findRenderObject();
      if (scrollable == null || box is! RenderBox) return;
      final position = scrollable.position;
      final viewport = RenderAbstractViewport.maybeOf(box);
      if (viewport == null) return;
      final target = viewport
          .getOffsetToReveal(box, 0.25)
          .offset
          .clamp(position.minScrollExtent, position.maxScrollExtent);
      if ((target - position.pixels).abs() < 2) return;
      await position.animateTo(target, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } catch (_) {}
  }

  Future<Rect?> _measure({required int attempts}) async {
    for (var a = 0; a <= attempts; a++) {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return null;
      final rect = _rectOf(_step.target);
      if (rect != null || _step.target == null) return rect;
      await Future.delayed(const Duration(milliseconds: 80));
    }
    return null;
  }

  Rect? _rectOf(GlobalKey? key) {
    final ctx = key?.currentContext;
    final box = ctx?.findRenderObject();
    final me = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize || !box.attached || me is! RenderBox) return null;
    final topLeft = box.localToGlobal(Offset.zero, ancestor: me);
    final r = (topLeft & box.size).intersect(Offset.zero & me.size);
    return r.width <= 0 || r.height <= 0 ? null : r;
  }

  bool get _canAct => !_busy && _visible;

  void _next() {
    if (!_canAct) return;
    _index == widget.steps.length - 1 ? widget.onFinish() : _goTo(_index + 1);
  }

  void _back() {
    if (_canAct && _index > 0) _goTo(_index - 1);
  }

  /// Toque no fundo escuro: só avança depois de o balão estar um tempinho na
  /// tela, para um toque duplo ou acidental não pular passos.
  void _scrimTap() {
    if (DateTime.now().difference(_shownAt) < _tapGuard) return;
    _next();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, c) {
      final size = Size(c.maxWidth, c.maxHeight);
      final hole = _to;
      final bubble = IgnorePointer(
        ignoring: !_visible,
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          child: AnimatedSlide(
            offset: _visible ? Offset.zero : const Offset(0, 0.04),
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOut,
            child: _bubble(l10n),
          ),
        ),
      );
      final pad = MediaQuery.of(context).padding;
      // O balão fica sempre no mesmo lugar (colado acima da barra de baixo), e
      // assim os botões Voltar e Próximo ficam sempre no mesmo ponto da tela.
      // Só vai para o topo quando cobriria o ponto iluminado.
      final bottomLimit = _navTop ?? (size.height - pad.bottom - 80);
      final needed = 200.0 + (_step.body.length / 33).ceil() * 22.0;
      final bottomRect = Rect.fromLTRB(16, bottomLimit - needed, size.width - 16, bottomLimit);
      final topRect = Rect.fromLTWH(16, pad.top + 8, size.width - 32, needed);
      final target = hole?.inflate(10);
      final atTop = target != null && target.overlaps(bottomRect) && !target.overlaps(topRect);

      return Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            // fundo escuro com o buraco (tocar no fundo avança)
            Positioned.fill(
              child: GestureDetector(
                key: const ValueKey('tour_scrim'),
                behavior: HitTestBehavior.opaque,
                onTap: _scrimTap,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_pulse, _move]),
                  builder: (context, _) => CustomPaint(
                    painter: _ScrimPainter(hole: _hole, pulse: _pulse.value),
                  ),
                ),
              ),
            ),
            if (atTop)
              Positioned(
                left: 16,
                right: 16,
                top: pad.top + 8,
                bottom: size.height - bottomLimit,
                child: Align(alignment: Alignment.topCenter, child: SingleChildScrollView(child: bubble)),
              )
            else
              Positioned(
                left: 16,
                right: 16,
                top: pad.top + 8,
                bottom: size.height - bottomLimit,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(reverse: true, child: bubble),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _bubble(AppLocalizations l10n) {
    final last = _index == widget.steps.length - 1;
    return Container(
      key: const ValueKey('tour_bubble'),
      constraints: const BoxConstraints(maxWidth: 460),
      padding: const EdgeInsets.fromLTRB(18, 16, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: AppColors.accentGold.withValues(alpha: 0.18), shape: BoxShape.circle),
                child: Icon(_step.icon, color: AppColors.primaryText, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _step.title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
              ),
              Text(
                '${_index + 1}/${widget.steps.length}',
                style: const TextStyle(fontSize: 12, color: AppColors.secondaryText, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(_step.body, style: const TextStyle(fontSize: 14.5, height: 1.45, color: AppColors.primaryText)),
          const SizedBox(height: 6),
          // progresso
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_index + 1) / widget.steps.length,
              minHeight: 4,
              backgroundColor: AppColors.accentGold.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation(AppColors.accentGold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                    visible: !last,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: TextButton(
                      key: const ValueKey('tour_skip'),
                      onPressed: last ? null : widget.onFinish,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondaryText,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Text(l10n.tourSkip, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
              // Voltar ocupa sempre o mesmo lugar (some no 1º passo)
              Visibility(
                visible: _index > 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: TextButton(
                  key: const ValueKey('tour_back'),
                  onPressed: _index > 0 ? _back : null,
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12)),
                  child: Text(l10n.tourBack),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 112,
                child: FilledButton(
                  key: const ValueKey('tour_next'),
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Text(last ? l10n.tourFinish : l10n.tourNext, overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScrimPainter extends CustomPainter {
  final Rect? hole;
  final double pulse;
  _ScrimPainter({required this.hole, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final scrim = Paint()..color = Colors.black.withValues(alpha: hole == null ? 0.45 : 0.72);
    final full = Path()..addRect(Offset.zero & size);
    if (hole == null) {
      canvas.drawPath(full, scrim);
      return;
    }
    final r = RRect.fromRectAndRadius(hole!, const Radius.circular(16));
    canvas.drawPath(Path.combine(PathOperation.difference, full, Path()..addRRect(r)), scrim);
    // anel dourado pulsando em volta do ponto
    final ring = Paint()
      ..color = AppColors.accentGold.withValues(alpha: 0.9 - pulse * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRRect(r.inflate(2 + pulse * 6), ring);
  }

  @override
  bool shouldRepaint(covariant _ScrimPainter old) => old.hole != hole || old.pulse != pulse;
}
