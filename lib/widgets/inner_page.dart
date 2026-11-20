import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:flutter/services.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Estrutura das telas internas do app (mesmo estilo da tela de oração do terço):
/// cabeçalho colorido com o título, corpo sobre o fundo creme (opcionalmente
/// dentro de um cartão branco de leitura) e botão grande fixo na parte de baixo.
class InnerPageScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color color;

  /// Imagem de fundo do cabeçalho (opcional). Sem imagem, usa só a cor.
  final String? image;
  final List<Widget> actions;

  /// Conteúdo. Com [card] = true ele é colocado num cartão branco rolável;
  /// com false, o próprio conteúdo deve ser rolável (ListView, etc.).
  final Widget child;
  final bool card;

  /// Barra fixa no rodapé (normalmente um [PillButton]).
  final Widget? bottom;

  const InnerPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.color = AppColors.themeColor,
    this.image,
    this.actions = const [],
    this.card = false,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Color.lerp(color, Colors.black, 0.45)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        body: Stack(
          children: [
            // Cabeçalho: cor (e imagem) que esmaece até o fundo da tela
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (image != null)
                    Image.asset(image!, fit: BoxFit.cover, alignment: Alignment.topCenter, cacheWidth: AppImages.headerWidth),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (image != null ? Colors.black : dark).withValues(alpha: image != null ? 0.55 : 1),
                          color.withValues(alpha: image != null ? 0.55 : 0.92),
                          AppColors.primaryBg,
                        ],
                        stops: const [0.0, 0.5, 0.97],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        if (Navigator.of(context).canPop())
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.maybePop(context),
                          )
                        else
                          const SizedBox(width: 48),
                        const Spacer(),
                        ...actions,
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                            shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.92),
                              fontSize: 14,
                              shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(child: card ? _CardBody(child: child) : child),
                  if (bottom != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: bottom,
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

/// Cartão branco de leitura (opaco, com sombra suave) que rola por dentro.
class _CardBody extends StatelessWidget {
  final Widget child;
  const _CardBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

/// Botão grande e arredondado (rodapé das telas e ações principais).
class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;

  /// Versão discreta (contorno), para ações secundárias.
  final bool outlined;

  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color = AppColors.themeColor,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final text = FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          if (icon != null) ...[const SizedBox(width: 8), Icon(icon, size: 22)],
        ],
      ),
    );
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(28));

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color.withValues(alpha: 0.6), width: 2),
                shape: shape,
              ),
              child: text,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                elevation: 3,
                shape: shape,
              ),
              child: text,
            ),
    );
  }
}

/// Aparência padrão dos cartões brancos (listas, itens, seções).
BoxDecoration appCardDecoration({Color? tint, double radius = 18}) => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: (tint ?? AppColors.themeColor).withValues(alpha: 0.15)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );

/// Círculo colorido com ícone (usado à esquerda de itens de lista).
class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const CircleIcon({super.key, required this.icon, required this.color, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color.withValues(alpha: color.a * 0.12), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}

/// Título pequeno de seção ("CATEGORIAS", "TODAS AS NOVENAS").
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }
}
