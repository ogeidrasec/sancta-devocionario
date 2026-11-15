import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Um passo de um roteiro guiado (exame diário, luta contra as tentações).
class StepData {
  final String title;
  final String description;
  final String prayer;

  /// Ícone do passo; sem ele, mostra o número do passo.
  final IconData? icon;

  const StepData({
    required this.title,
    required this.description,
    required this.prayer,
    this.icon,
  });
}

/// Roteiro em passos: um cartão por passo, barra de progresso e botões
/// "anterior"/"próximo" grandes. Ao concluir o último passo chama [onFinish].
class StepFlowPage extends StatefulWidget {
  final String title;
  final List<StepData> steps;
  final String prayerLabel;
  final String nextLabel;
  final String finishLabel;
  final Color color;
  final VoidCallback onFinish;

  const StepFlowPage({
    super.key,
    required this.title,
    required this.steps,
    required this.prayerLabel,
    required this.nextLabel,
    required this.finishLabel,
    required this.onFinish,
    this.color = AppColors.themeColor,
  });

  @override
  State<StepFlowPage> createState() => _StepFlowPageState();
}

class _StepFlowPageState extends State<StepFlowPage> {
  final _controller = PageController();
  int _page = 0;

  bool get _isLast => _page == widget.steps.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    _controller.animateToPage(
      _page + delta,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_isLast) {
      widget.onFinish();
    } else {
      _go(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.steps;
    final color = widget.color;

    return InnerPageScaffold(
      title: widget.title,
      subtitle: '${_page + 1} / ${steps.length}',
      color: color,
      bottom: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: OutlinedButton(
              onPressed: _page == 0 ? null : () => _go(-1),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                side: BorderSide(color: color.withValues(alpha: _page == 0 ? 0.2 : 0.5), width: 2),
                foregroundColor: color,
              ),
              child: const Icon(Icons.chevron_left, size: 30),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PillButton(
              label: _isLast ? widget.finishLabel : widget.nextLabel,
              icon: _isLast ? Icons.check_circle_outline : Icons.chevron_right,
              color: color,
              onPressed: _next,
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          // progresso
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Row(
              children: List.generate(steps.length, (i) {
                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 5,
                    decoration: BoxDecoration(
                      color: i <= _page ? Colors.white : Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              itemCount: steps.length,
              itemBuilder: (context, index) => _StepCard(
                data: steps[index],
                number: index + 1,
                prayerLabel: widget.prayerLabel,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final StepData data;
  final int number;
  final String prayerLabel;
  final Color color;

  const _StepCard({
    required this.data,
    required this.number,
    required this.prayerLabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: data.icon != null
                    ? Icon(data.icon, size: 34, color: color)
                    : Text(
                        '$number',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color),
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.55,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.35)),
                ),
                child: Column(
                  children: [
                    Text(
                      prayerLabel.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Color(0xFFB7791F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.prayer,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.55,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
