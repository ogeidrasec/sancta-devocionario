import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Datas no formato do idioma do app (12/10/2026 em português, 10/12/2026 em inglês).
String fmtDate(BuildContext context, DateTime date) =>
    DateFormat.yMd(Localizations.localeOf(context).toString()).format(date);

/// Dia e mês (12/10 em português, 10/12 em inglês).
String fmtDayMonth(BuildContext context, DateTime date) =>
    DateFormat.Md(Localizations.localeOf(context).toString()).format(date);

/// Iniciais dos dias da semana, começando no domingo (D S T Q Q S S / S M T W T F S).
List<String> weekdayInitials(BuildContext context) {
  final locale = Localizations.localeOf(context).toString();
  // 1º/jan/2023 foi domingo
  return List.generate(
    7,
    (i) => DateFormat('EEEEE', locale).format(DateTime(2023, 1, 1 + i)).toUpperCase(),
  );
}
