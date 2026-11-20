// Restaurar um backup grande: rápido (em lote) e sem duplicar se for
// restaurado duas vezes.
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/services/backup_service.dart';
import 'package:sanctaconscientia/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_backup_bulk');

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    await DatabaseService().wipeAllDataForTests();
  });

  Map<String, dynamic> bigBackup() {
    final start = DateTime(2025, 1, 1, 7);
    return {
      'version': 1,
      'pecados': {for (var i = 0; i < 40; i++) 'mandamentos-1-$i': 1},
      'dailyPrayers': {
        for (var d = 0; d < 300; d++)
          for (final id in ['morning', 'rosary', 'night'])
            '${(start.add(Duration(days: d))).toIso8601String().substring(0, 10).replaceAll('-', '')}_$id': 1,
      },
      'prayerLogs': [
        for (var i = 0; i < 3000; i++)
          {
            'title': 'Oração $i',
            'timestamp': start.add(Duration(hours: i)).toIso8601String(),
            'prayerId': 'p$i',
            'prayerType': 'prayer',
          },
      ],
    };
  }

  test('backup grande é restaurado por completo e em poucos segundos', () async {
    final db = DatabaseService();
    final sw = Stopwatch()..start();
    await BackupService().restoreDataForTests(bigBackup());
    sw.stop();
    expect((await db.loadPrayerLogs()).length, 3000);
    expect((await db.loadDailyPrayersStatus()).length, 900);
    expect((await db.loadPecados()).length, 40);
    expect(sw.elapsed, lessThan(const Duration(seconds: 10)));
  });

  test('restaurar o mesmo backup duas vezes não duplica as orações', () async {
    final db = DatabaseService();
    await BackupService().restoreDataForTests(bigBackup());
    await BackupService().restoreDataForTests(bigBackup());
    expect((await db.loadPrayerLogs()).length, 3000);
    expect((await db.loadDailyPrayersStatus()).length, 900);
  });
}
