import 'package:sanctaconscientia/services/database_service.dart';

/// Quando mostrar o lembrete gentil de apoio ao projeto na aba Hoje.
///
/// Regras:
/// - nunca nos primeiros [firstDays] dias de uso;
/// - depois, aparece em um único dia por mês ([interval]) (some sozinho no
///   dia seguinte, mesmo sem resposta);
/// - "Agora não" esconde até o próximo ciclo;
/// - "Vou rezar por vocês" adia até o mês seguinte ([prayerSnooze]);
/// - "Já apoiei" adia por [supportedSnooze].
class SupportNudge {
  static const firstDays = 3;
  static const interval = Duration(days: 30);
  static const prayerSnooze = Duration(days: 30);
  static const supportedSnooze = Duration(days: 90);

  static const firstOpenKey = 'support_first_open';
  static const cycleKey = 'support_nudge_cycle';
  static const snoozeKey = 'support_nudge_snooze_until';
  static const dismissedKey = 'support_nudge_dismissed';

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Decisão pura (sem banco): mostra hoje? e qual o início do ciclo a gravar.
  static ({bool show, DateTime? newCycle}) decide({
    required DateTime now,
    required DateTime firstOpen,
    DateTime? cycleStart,
    DateTime? snoozeUntil,
    DateTime? dismissedOn,
  }) {
    final today = _day(now);
    if (today.difference(_day(firstOpen)).inDays < firstDays) return (show: false, newCycle: null);
    if (snoozeUntil != null && today.isBefore(_day(snoozeUntil))) return (show: false, newCycle: null);
    if (dismissedOn != null && _day(dismissedOn) == today) return (show: false, newCycle: null);

    if (cycleStart != null) {
      final start = _day(cycleStart);
      if (start == today) return (show: true, newCycle: null); // o dia do aviso
      if (today.difference(start) < interval) return (show: false, newCycle: null);
    }
    return (show: true, newCycle: today); // começa um novo ciclo hoje
  }

  static DateTime? _parse(String? v) => v == null || v.isEmpty ? null : DateTime.tryParse(v);

  /// Consulta o banco (e grava o primeiro uso e o ciclo quando preciso).
  static Future<bool> shouldShow({DateTime? now}) async {
    final db = DatabaseService();
    final at = now ?? DateTime.now();
    var first = _parse(await db.getSetting(firstOpenKey));
    if (first == null) {
      first = at;
      await db.saveSetting(firstOpenKey, at.toIso8601String());
    }
    final r = decide(
      now: at,
      firstOpen: first,
      cycleStart: _parse(await db.getSetting(cycleKey)),
      snoozeUntil: _parse(await db.getSetting(snoozeKey)),
      dismissedOn: _parse(await db.getSetting(dismissedKey)),
    );
    if (r.newCycle != null) await db.saveSetting(cycleKey, r.newCycle!.toIso8601String());
    return r.show;
  }

  /// "Agora não": some hoje; volta só no próximo ciclo.
  static Future<void> notNow({DateTime? now}) =>
      DatabaseService().saveSetting(dismissedKey, (now ?? DateTime.now()).toIso8601String());

  static Future<void> snooze(Duration d, {DateTime? now}) =>
      DatabaseService().saveSetting(snoozeKey, (now ?? DateTime.now()).add(d).toIso8601String());
}
