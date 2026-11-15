import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Intensidade da resposta tátil.
/// [decade] = fim de um mistério (uma vibração longa);
/// [finale] = terço concluído (três vibrações curtas).
enum HapticKind { selection, light, medium, heavy, decade, finale }

/// Acesso ao hardware de vibração (separado para poder ser trocado nos testes).
abstract class HapticsBackend {
  Future<bool> hasVibrator();
  Future<bool> hasAmplitudeControl();
  Future<void> vibrate({required int durationMs, required int amplitude});
  /// [pattern]: espera, vibra, espera, vibra... (ms), como no Android.
  Future<void> vibratePattern({required List<int> pattern, required List<int> intensities});
  Future<void> systemFallback(HapticKind kind);
}

class _DeviceHapticsBackend implements HapticsBackend {
  @override
  Future<bool> hasVibrator() async => await Vibration.hasVibrator();

  @override
  Future<bool> hasAmplitudeControl() async => await Vibration.hasAmplitudeControl();

  @override
  Future<void> vibrate({required int durationMs, required int amplitude}) =>
      Vibration.vibrate(duration: durationMs, amplitude: amplitude);

  @override
  Future<void> vibratePattern({required List<int> pattern, required List<int> intensities}) =>
      Vibration.vibrate(pattern: pattern, intensities: intensities);

  @override
  Future<void> systemFallback(HapticKind kind) {
    switch (kind) {
      case HapticKind.decade:
        return HapticFeedback.heavyImpact();
      case HapticKind.finale:
        return HapticFeedback.heavyImpact();
      case HapticKind.selection:
        return HapticFeedback.selectionClick();
      case HapticKind.light:
        return HapticFeedback.lightImpact();
      case HapticKind.medium:
        return HapticFeedback.mediumImpact();
      case HapticKind.heavy:
        return HapticFeedback.heavyImpact();
    }
  }
}

/// Vibração do celular.
///
/// Usa o motor de vibração diretamente (permissão VIBRATE). O recurso padrão do
/// Flutter (`HapticFeedback`) depende do ajuste "vibrar ao tocar" do sistema, que
/// vem desligado em muitos aparelhos, e por isso não vibrava. Se o aparelho não
/// tiver motor de vibração acessível, cai para o `HapticFeedback`.
class HapticsService {
  HapticsService._();

  @visibleForTesting
  static HapticsBackend backend = _DeviceHapticsBackend();

  static bool? _hasVibrator;
  static bool? _hasAmplitude;

  @visibleForTesting
  static void resetCache() {
    _hasVibrator = null;
    _hasAmplitude = null;
  }

  /// (duração em ms, amplitude 1-255). Sem controle de amplitude, só a duração
  /// vale; por isso as durações já são perceptíveis sozinhas.
  static (int, int) _pattern(HapticKind kind) {
    switch (kind) {
      case HapticKind.selection:
        return (15, 60);
      case HapticKind.light:
        return (25, 110);
      case HapticKind.medium:
        return (45, 170);
      case HapticKind.heavy:
        return (90, 255);
      case HapticKind.decade:
        return (400, 255); // uma vibração longa: acabou um mistério
      case HapticKind.finale:
        return (90, 255);
    }
  }

  /// Três vibrações curtas (terço concluído): espera, vibra, espera, vibra...
  static const _finalePattern = [0, 90, 110, 90, 110, 90];
  static const _finaleIntensities = [0, 255, 0, 255, 0, 255];

  static Future<void> play(HapticKind kind) async {
    try {
      _hasVibrator ??= await backend.hasVibrator();
      if (_hasVibrator == true) {
        _hasAmplitude ??= await backend.hasAmplitudeControl();
        if (kind == HapticKind.finale) {
          await backend.vibratePattern(
            pattern: _finalePattern,
            intensities: _hasAmplitude == true ? _finaleIntensities : const [],
          );
          return;
        }
        final (ms, amp) = _pattern(kind);
        await backend.vibrate(durationMs: ms, amplitude: _hasAmplitude == true ? amp : -1);
        return;
      }
    } catch (e) {
      debugPrint('HapticsService: vibração direta indisponível ($e)');
    }
    try {
      if (kind == HapticKind.finale) {
        // sem motor direto: três batidas do sistema, com pausa
        for (var i = 0; i < 3; i++) {
          await backend.systemFallback(kind);
          if (i < 2) await Future<void>.delayed(const Duration(milliseconds: 200));
        }
        return;
      }
      await backend.systemFallback(kind);
    } catch (e) {
      debugPrint('HapticsService: sem resposta tátil ($e)');
    }
  }
}
