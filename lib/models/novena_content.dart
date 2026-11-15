import 'package:flutter/material.dart';

class NovenaDay {
  final int dayNumber;
  final String title;
  final String meditation;

  const NovenaDay({
    required this.dayNumber,
    required this.title,
    required this.meditation,
  });
}

class NovenaContent {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String openingPrayer;
  final String closingPrayer;
  final String prayerInstruction;
  final List<NovenaDay> days;

  const NovenaContent({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.openingPrayer,
    required this.closingPrayer,
    required this.prayerInstruction,
    required this.days,
  });
}
