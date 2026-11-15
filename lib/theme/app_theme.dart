import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Tema único do app (também usado nos testes de tela, para ficarem iguais).
/// [fontFamily] só é usado nos testes de tela (para carregar a Roboto real).
ThemeData buildAppTheme({String? fontFamily}) {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.themeColor,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.themeColor,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.primaryText,
    error: AppColors.errorColor,
  );

  return ThemeData(
    fontFamily: fontFamily,
    colorScheme: scheme,
    // Mesmo fundo creme em todas as telas
    scaffoldBackgroundColor: AppColors.primaryBg,
    // Cartões brancos, sem o tom lilás automático do Material 3
    cardTheme: const CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryText,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    // Janelas (diálogos): brancas, bem arredondadas, título em destaque
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        height: 1.45,
        color: AppColors.secondaryText,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ),
    // Folhas que sobem de baixo (seleção de oração etc.)
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    // Botões de texto das janelas
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.themeColor,
        textStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    // Botões principais em pílula (os que definem o próprio estilo continuam valendo)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: const StadiumBorder(),
        textStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    // Interruptores na cor do app
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? Colors.white : Colors.grey.shade500,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? AppColors.themeColor : Colors.grey.shade300,
      ),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primaryBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.themeColor.withValues(alpha: 0.25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.themeColor.withValues(alpha: 0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.themeColor, width: 2),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryText,
      contentTextStyle: TextStyle(fontFamily: fontFamily, color: Colors.white, fontSize: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
