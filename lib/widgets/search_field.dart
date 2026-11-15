import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Campo de busca do app (Orações, Novenas, Exame): fundo branco, cantos
/// arredondados e botão para limpar.
class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.themeColor.withValues(alpha: 0.2)),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search, color: AppColors.themeColor),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => value.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: l10n.searchClear,
                  icon: const Icon(Icons.close, color: AppColors.secondaryText),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.themeColor, width: 2),
        ),
      ),
    );
  }
}

/// Mensagem quando a busca não encontra nada.
class SearchEmpty extends StatelessWidget {
  final String message;
  const SearchEmpty(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 40, color: AppColors.secondaryText.withValues(alpha: 0.6)),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, height: 1.45, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }
}

/// Aviso "resultados aproximados" acima da lista.
class SearchApproximateNote extends StatelessWidget {
  const SearchApproximateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        AppLocalizations.of(context)!.searchApproximate,
        style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.secondaryText),
      ),
    );
  }
}
