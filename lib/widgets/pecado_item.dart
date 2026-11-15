import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

class PecadoItem extends StatelessWidget {
  final String descricao;
  final int contador;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PecadoItem({
    super.key,
    required this.descricao,
    required this.contador,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.themeColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                descricao,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryText,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Container dos botões - layout mais seguro
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accentGold),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão de decremento
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: onDecrement,
                      color: contador > 0 ? AppColors.themeColor : Colors.grey,
                      padding: const EdgeInsets.all(6),
                    ),
                  ),
                  // Contador
                  Container(
                    width: 32,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(color: AppColors.accentGold, width: 0.5),
                      ),
                    ),
                    child: Text(
                      contador.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: contador > 0 ? AppColors.themeColor : AppColors.secondaryText,
                      ),
                    ),
                  ),
                  // Botão de incremento
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: onIncrement,
                      color: AppColors.themeColor,
                      padding: const EdgeInsets.all(6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}