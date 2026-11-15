import 'package:flutter/material.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';


class AppState extends ChangeNotifier {
  
  // Reminder service
  late ReminderService _reminderService;

  
  // Initialize AppState with services
  AppState({ReminderService? reminderService}) {
    _reminderService = reminderService ?? ReminderService(
      databaseService: DatabaseService(),
      notificationService: NotificationService(),
    );
  }



  Future<void> loadSavedData() async {
    final dbService = DatabaseService();
    
    await dbService.migrateFromSharedPreferences();

    

    await dbService.getSetting('app_initialized');

    // Bind real-time sync
    _reminderService.onRemindersChanged = notifyListeners;
    
    // Load reminders
    await loadReminders();
    
    notifyListeners();
  }


  
  // =====================
  // Reminder Methods
  // =====================
  
  /// Create or update a unified reminder (delegates to ReminderService)
  Future<void> createOrUpdateUnifiedReminder(ReminderModel reminder) async {
    await _reminderService.createOrUpdateUnifiedReminder(reminder);
    notifyListeners();
  }
  
  Future<void> loadReminders() async {
    await _reminderService.loadReminders();
    notifyListeners();
  }

  Future<void> rescheduleAllReminders() async {
    // Cancelar TODAS as notificações pendentes do sistema antes de reagendar
    // para garantir um estado limpo a cada inicialização do app.
    await NotificationService().cancelAllNotifications();
    await _reminderService.rescheduleAllActiveReminders();
    notifyListeners();
  }
  
  List<ReminderModel> getAllReminders() => _reminderService.getAllReminders();
  List<ReminderModel> getActiveReminders() => _reminderService.getActiveReminders();
  ReminderModel? getReminderById(String id) => _reminderService.getReminderById(id);
  Map<ReminderType, List<ReminderModel>> getGroupedReminders() => _reminderService.getGroupedReminders();
  Map<String, dynamic> getReminderStatistics() => _reminderService.getStatistics();
  
  Future<ReminderModel> createReminder(ReminderModel reminder) async {
    final created = await _reminderService.createReminder(reminder);
    notifyListeners();
    return created;
  }
  
  Future<void> updateReminder(ReminderModel reminder) async {
    await _reminderService.updateReminder(reminder);
    notifyListeners();
  }
  
  Future<void> toggleReminderActive(String id) async {
    await _reminderService.toggleActive(id);
    notifyListeners();
  }
  
  Future<void> deleteReminder(String id) async {
    await _reminderService.deleteReminder(id);
    notifyListeners();
  }


}
