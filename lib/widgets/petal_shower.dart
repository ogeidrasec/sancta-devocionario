import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Chuva rápida de pétalas sobre a tela (celebração discreta, ~2 s).
/// Não bloqueia toques e se remove sozinha.
void showPetalShower(BuildContext context, {int count = 26}) {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => IgnorePointer(child: _PetalShower(count: count, onDone: () => entry.remove())),
  );
  overlay.insert(entry);
}

class _PetalShower extends StatefulWidget {
  final VoidCallback onDone;
  final int count;
  const _PetalShower({required this.onDone, this.count = 26});

  @override
  State<_PetalShower> createState() => _PetalShowerState();
}

class _Petal {
  final double x, delay, speed, sway, phase, size, spin;
  final Color color;
  _Petal(math.Random r, this.color)
      : x = r.nextDouble(),
        delay = r.nextDouble() * 0.35,
        speed = 0.7 + r.nextDouble() * 0.5,
        sway = 12 + r.nextDouble() * 22,
        phase = r.nextDouble() * math.pi * 2,
        size = 5 + r.nextDouble() * 5,
        spin = r.nextDouble() * math.pi * 2;
}

class _PetalShowerState extends State<_PetalShower> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..forward().whenComplete(widget.onDone);

  late final List<_Petal> _petals = () {
    final r = math.Random();
    const colors = [Color(0xFFE0A526), Color(0xFFF2D27A), Color(0xFFFFF3C4), Color(0xFFD98C5F)];
    return List.generate(widget.count, (i) => _Petal(r, colors[i % colors.length]));
  }();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _PetalPainter(_petals, _c.value),
        ),
      ),
    );
  }
}

class _PetalPainter extends CustomPainter {
  final List<_Petal> petals;
  final double t;
  _PetalPainter(this.petals, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in petals) {
      final local = ((t - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (local <= 0) continue;
      final y = -20 + (size.height * 0.85 + 20) * local * p.speed.clamp(0.0, 1.2);
      final x = p.x * size.width + math.sin(local * 6 + p.phase) * p.sway;
      final fade = local < 0.8 ? 1.0 : (1 - (local - 0.8) / 0.2);
      paint.color = p.color.withValues(alpha: fade.clamp(0.0, 1.0) * 0.9);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin + local * 5);
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: p.size * 1.7, height: p.size), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PetalPainter old) => old.t != t;
}
