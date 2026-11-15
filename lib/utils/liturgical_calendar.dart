import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

enum LiturgicalSeason {
  advent,
  christmas,
  lent,
  easter,
  ordinaryTime,
}


class LiturgicalCalendar {
  static LiturgicalSeason getSeason(DateTime date) {
    // Normalize date to midnight to avoid time-of-day issues
    date = DateTime(date.year, date.month, date.day);
    final year = date.year;
    
    // Advent: 4 Sundays before Christmas
    // The first Sunday of Advent is the Sunday closest to St. Andrew (Nov 30).
    // It is the Sunday on or after Nov 27.
    final christmas = DateTime(year, 12, 25);
    final nov27 = DateTime(year, 11, 27);
    // Find first Sunday on or after Nov 27
    var adventStart = nov27;
    while (adventStart.weekday != DateTime.sunday) {
      adventStart = adventStart.add(const Duration(days: 1));
    }
    
    if (date.isAfter(adventStart.subtract(const Duration(days: 1))) && 
        date.isBefore(christmas)) {
      return LiturgicalSeason.advent;
    }
    
    // Lent: Ash Wednesday to Holy Thursday
    final easter = _getEasterDate(year);
    final ashWednesday = easter.subtract(const Duration(days: 46));
    
    if (date.isAfter(ashWednesday.subtract(const Duration(days: 1))) && 
        date.isBefore(easter)) {
      return LiturgicalSeason.lent;
    }
    
    // Christmas Season
    // Starts Dec 25
    // Ends on Baptism of the Lord (Sunday after Jan 6, or Monday if Epiphany is Jan 7 or 8)
    
    // Calculate Epiphany (Sunday between Jan 2 and Jan 8)
    var epiphany = DateTime(year, 1, 2);
    while (epiphany.weekday != DateTime.sunday) {
      epiphany = epiphany.add(const Duration(days: 1));
    }
    // If Epiphany is Jan 7 or 8, Baptism is next day (Monday)
    // Otherwise, Baptism is next Sunday
    DateTime baptism;
    if (epiphany.day >= 7) {
      baptism = epiphany.add(const Duration(days: 1));
    } else {
      baptism = epiphany.add(const Duration(days: 7));
    }

    // Check if date is in Christmas season (Dec 25 to Baptism)
    // Note: We need to handle year transition.
    // If date is in Jan, we check against Baptism of THIS year.
    // If date is in Dec, we check against Christmas of THIS year.
    
    if (date.month == 12 && date.day >= 25) {
      return LiturgicalSeason.christmas;
    }
    if (date.month == 1 && date.isBefore(baptism.add(const Duration(days: 1)))) {
      return LiturgicalSeason.christmas;
    }
    
    // Easter Season: Easter to Pentecost (50 days)
    final pentecost = easter.add(const Duration(days: 49));
    if (date.isAfter(easter.subtract(const Duration(days: 1))) && 
        date.isBefore(pentecost.add(const Duration(days: 1)))) {
      return LiturgicalSeason.easter;
    }
    
    return LiturgicalSeason.ordinaryTime;
  }
  
  static Color getSeasonColor(LiturgicalSeason season) {
    switch (season) {
      case LiturgicalSeason.advent:
      case LiturgicalSeason.lent:
        return Colors.purple;
      case LiturgicalSeason.christmas:
      case LiturgicalSeason.easter:
        return const Color(0xFFD4AF37); // Gold
      case LiturgicalSeason.ordinaryTime:
        return Colors.green;
    }
  }
  
  static String getSeasonName(AppLocalizations l10n, LiturgicalSeason season) {
    switch (season) {
      case LiturgicalSeason.advent:
        return l10n.seasonAdvent;
      case LiturgicalSeason.christmas:
        return l10n.seasonChristmas;
      case LiturgicalSeason.lent:
        return l10n.seasonLent;
      case LiturgicalSeason.easter:
        return l10n.seasonEaster;
      case LiturgicalSeason.ordinaryTime:
        return l10n.seasonOrdinaryTime;
    }
  }

  static DateTime _getEasterDate(int year) {
    // Anonymous algorithm to calculate Easter date
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;
    
    return DateTime(year, month, day);
  }
  
  static Map<DateTime, String> getFixedFeasts(int year, AppLocalizations l10n) {
    return {
      DateTime(year, 1, 1): l10n.feastMaryMotherOfGod,
      DateTime(year, 1, 3): l10n.feastHolyNameJesus,
      DateTime(year, 1, 6): l10n.feastEpiphany,
      DateTime(year, 1, 25): l10n.feastConversionPaul,
      DateTime(year, 1, 26): l10n.feastTimothyTitus,
      DateTime(year, 1, 28): l10n.feastThomasAquinas,
      DateTime(year, 1, 31): l10n.feastJohnBosco,
      DateTime(year, 2, 2): l10n.feastPresentationLord,
      DateTime(year, 2, 11): l10n.feastLadyLourdes,
      DateTime(year, 2, 22): l10n.feastChairPeter,
      DateTime(year, 3, 19): l10n.feastJosephHusband,
      DateTime(year, 3, 25): l10n.feastAnnunciation,
      DateTime(year, 4, 25): l10n.feastMarkEvangelist,
      DateTime(year, 5, 1): l10n.feastJosephWorker,
      DateTime(year, 5, 3): l10n.feastPhilipJames,
      DateTime(year, 5, 13): l10n.feastLadyFatima,
      DateTime(year, 5, 31): l10n.feastVisitation,
      DateTime(year, 6, 1): l10n.feastJustin,
      DateTime(year, 6, 13): l10n.feastAnthonyPadua,
      DateTime(year, 6, 24): l10n.feastBirthJohnBaptist,
      DateTime(year, 6, 29): l10n.feastPeterPaul,
      DateTime(year, 7, 3): l10n.feastThomasApostle,
      DateTime(year, 7, 11): l10n.feastBenedict,
      DateTime(year, 7, 22): l10n.feastMaryMagdalene,
      DateTime(year, 7, 25): l10n.feastJamesApostle,
      DateTime(year, 7, 26): l10n.feastJoachimAnne,
      DateTime(year, 7, 29): l10n.feastMarthaMaryLazarus,
      DateTime(year, 7, 31): l10n.feastIgnatiusLoyola,
      DateTime(year, 8, 4): l10n.feastJohnVianney,
      DateTime(year, 8, 6): l10n.feastTransfiguration,
      DateTime(year, 8, 8): l10n.feastDominic,
      DateTime(year, 8, 10): l10n.feastLawrence,
      DateTime(year, 8, 11): l10n.feastClare,
      DateTime(year, 8, 14): l10n.feastMaximilianKolbe,
      DateTime(year, 8, 15): l10n.feastAssumption,
      DateTime(year, 8, 24): l10n.feastBartholomew,
      DateTime(year, 8, 27): l10n.feastMonica,
      DateTime(year, 8, 28): l10n.feastAugustine,
      DateTime(year, 8, 29): l10n.feastPassionJohnBaptist,
      DateTime(year, 9, 8): l10n.feastNativityMary,
      DateTime(year, 9, 14): l10n.feastExaltationCross,
      DateTime(year, 9, 15): l10n.feastLadySorrows,
      DateTime(year, 9, 21): l10n.feastMatthewApostle,
      DateTime(year, 9, 23): l10n.feastPadrePio,
      DateTime(year, 9, 27): l10n.feastVincentPaul,
      DateTime(year, 9, 29): l10n.feastArchangels,
      DateTime(year, 9, 30): l10n.feastJerome,
      DateTime(year, 10, 1): l10n.feastThereseLisieux,
      DateTime(year, 10, 2): l10n.feastGuardianAngels,
      DateTime(year, 10, 4): l10n.feastFrancisAssisi,
      DateTime(year, 10, 5): l10n.feastFaustina,
      DateTime(year, 10, 7): l10n.feastLadyRosary,
      DateTime(year, 10, 12): l10n.feastLadyAparecida,
      DateTime(year, 10, 15): l10n.feastTeresaAvila,
      DateTime(year, 10, 18): l10n.feastLukeEvangelist,
      DateTime(year, 10, 22): l10n.feastJohnPaulII,
      DateTime(year, 10, 28): l10n.feastSimonJude,
      DateTime(year, 11, 1): l10n.feastAllSaints,
      DateTime(year, 11, 2): l10n.feastAllSouls,
      DateTime(year, 11, 9): l10n.feastLateranBasilica,
      DateTime(year, 11, 21): l10n.feastPresentationMary,
      DateTime(year, 11, 22): l10n.feastCecilia,
      DateTime(year, 11, 30): l10n.feastAndrewApostle,
      DateTime(year, 12, 3): l10n.feastFrancisXavier,
      DateTime(year, 12, 6): l10n.feastNicholas,
      DateTime(year, 12, 8): l10n.feastImmaculateConception,
      DateTime(year, 12, 12): l10n.feastLadyGuadalupe,
      DateTime(year, 12, 13): l10n.feastLucy,
      DateTime(year, 12, 14): l10n.feastJohnCross,
      DateTime(year, 12, 25): l10n.feastChristmas,
      DateTime(year, 12, 26): l10n.feastStephen,
      DateTime(year, 12, 27): l10n.feastJohnApostle,
      DateTime(year, 12, 28): l10n.feastHolyInnocents,
      DateTime(year, 12, 31): l10n.feastSylvester,
    };
  }

  static Map<DateTime, String> getMovableFeasts(int year, AppLocalizations l10n) {
    final easter = _getEasterDate(year);
    final ashWednesday = easter.subtract(const Duration(days: 46));
    final goodFriday = easter.subtract(const Duration(days: 2));
    final ascension = easter.add(const Duration(days: 39)); // Thursday
    final pentecost = easter.add(const Duration(days: 49));
    final trinitySunday = pentecost.add(const Duration(days: 7));
    final corpusChristi = trinitySunday.add(const Duration(days: 4)); // Thursday
    final sacredHeart = corpusChristi.add(const Duration(days: 8)); // Friday

    return {
      ashWednesday: l10n.feastAshWednesday,
      easter.subtract(const Duration(days: 7)): l10n.feastPalmSunday,
      easter.subtract(const Duration(days: 3)): l10n.feastHolyThursday,
      goodFriday: l10n.feastGoodFriday,
      easter: l10n.feastEaster,
      ascension: l10n.feastAscension,
      pentecost: l10n.feastPentecost,
      trinitySunday: l10n.feastTrinitySunday,
      corpusChristi: l10n.feastCorpusChristi,
      sacredHeart: l10n.feastSacredHeart,
    };
  }

  static bool isDayOfObligation(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    // Fixed dates (Brazil)
    if (month == 1 && day == 1) return true; // Santa Maria Mãe de Deus
    if (month == 12 && day == 8) return true; // Imaculada Conceição
    if (month == 12 && day == 25) return true; // Natal

    // Sundays are always days of obligation
    if (date.weekday == DateTime.sunday) return true;

    // Movable dates logic - calculated directly to avoid string dependency
    final easter = _getEasterDate(year);
    final pentecost = easter.add(const Duration(days: 49));
    final trinitySunday = pentecost.add(const Duration(days: 7));
    final corpusChristi = trinitySunday.add(const Duration(days: 4)); // Thursday
    
    // Corpus Christi is a day of obligation in Brazil
    if (date.year == corpusChristi.year && date.month == corpusChristi.month && date.day == corpusChristi.day) return true;

    return false;
  }
  
  static String? getFeastName(DateTime date, AppLocalizations l10n) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final fixed = getFixedFeasts(date.year, l10n);
    if (fixed.containsKey(dateOnly)) return fixed[dateOnly];
    
    final movable = getMovableFeasts(date.year, l10n);
    // Check movable keys (ignoring time if any, though our generation uses 00:00)
    for (final entry in movable.entries) {
      if (entry.key.year == date.year && entry.key.month == date.month && entry.key.day == date.day) {
        return entry.value;
      }
    }
    
    return null;
  }
}
