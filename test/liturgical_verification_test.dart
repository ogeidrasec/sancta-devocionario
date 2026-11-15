import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';
import 'dart:io';

void main() {
  test('Verify Lent Dates', () {
    final file = File('test_output.txt');
    final sink = file.openWrite();
    
    for (var year in [2024, 2025]) {
      sink.writeln('\nChecking Year $year:');
      final start = DateTime(year, 1, 1);
      final end = DateTime(year + 1, 1, 1);
      
      DateTime current = start;
      LiturgicalSeason? lastSeason;
      
      while (current.isBefore(end)) {
        final season = LiturgicalCalendar.getSeason(current);
        if (season != lastSeason) {
          sink.writeln('${current.toIso8601String().split('T')[0]}: Switched to $season');
          lastSeason = season;
        }
        current = current.add(const Duration(days: 1));
      }
    }
    sink.close();
  });

  test('Verify Lent Bug (Time of Day)', () {
    // 2026 Ash Wednesday is Feb 18
    // Tues Feb 17 at noon should be Ordinary Time, NOT Lent
    final tuesdayNoon = DateTime(2026, 2, 17, 12, 0, 0);
    final ashWednesdayNoon = DateTime(2026, 2, 18, 12, 0, 0);
    
    final tuesdaySeason = LiturgicalCalendar.getSeason(tuesdayNoon);
    final ashSeason = LiturgicalCalendar.getSeason(ashWednesdayNoon);
    
    print('Tuesday Feb 17 Noon Season: $tuesdaySeason'); // Expected: ordinaryTime
    print('Wednesday Feb 18 Noon Season: $ashSeason');   // Expected: lent
    
    expect(tuesdaySeason, equals(LiturgicalSeason.ordinaryTime), reason: 'Tuesday before Ash Wed should be Ordinary Time');
    expect(ashSeason, equals(LiturgicalSeason.lent), reason: 'Ash Wednesday should be Lent');
  });
}
