import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sanctaconscientia/config/donation_config.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/support_nudge.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/pix_payload.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:url_launcher/url_launcher.dart';

/// "Apoie o projeto": o app é gratuito; quem quiser ajuda nas despesas do
/// casamento com PIX, cartão (Buy Me a Coffee etc.), cripto, ou com oração.
/// As formas de doação vêm de [DonationConfig]; o que estiver vazio não aparece.
class SupportProjectPage extends StatefulWidget {
  const SupportProjectPage({super.key});

  /// Setting com a data em que a pessoa prometeu rezar pelos noivos.
  static const prayerPromiseKey = 'couple_prayer_promise';

  @override
  State<SupportProjectPage> createState() => _SupportProjectPageState();
}

enum _Method { pix, card, crypto }

class _SupportProjectPageState extends State<SupportProjectPage> {
  static const _purple = Color(0xFF5E1B8C);
  static const _purpleDeep = Color(0xFF3A0F5C);
  static const _gold = Color(0xFFD4A537);
  static const _pixColor = Color(0xFF32BCAD); // cor do PIX
  static const _cardColor = Color(0xFFB7791F);
  static const _cryptoColor = Color(0xFFF7931A);

  bool _promised = false;
  _Method? _method;
  int? _amount; // valor do PIX (null = em aberto)

  List<_Method> get _methods => [
        if (DonationConfig.hasPix) _Method.pix,
        if (DonationConfig.hasCard) _Method.card,
        if (DonationConfig.hasCryptoLink || DonationConfig.cryptoWallets.isNotEmpty) _Method.crypto,
      ];

  @override
  void initState() {
    super.initState();
    DatabaseService().getSetting(SupportProjectPage.prayerPromiseKey).then((v) {
      if (mounted && v != null && v.isNotEmpty) setState(() => _promised = true);
    }).catchError((_) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Primeiro método: PIX para quem usa o app em português, cartão para os demais
    if (_method == null && _methods.isNotEmpty) {
      final pt = Localizations.localeOf(context).languageCode == 'pt';
      _method = (!pt && _methods.contains(_Method.card)) ? _Method.card : _methods.first;
    }
  }

  Future<void> _promisePrayer() async {
    setState(() => _promised = true);
    await DatabaseService()
        .saveSetting(SupportProjectPage.prayerPromiseKey, DateTime.now().toIso8601String())
        .catchError((_) {});
    // quem prometeu oração não precisa ver o lembrete tão cedo
    await SupportNudge.snooze(SupportNudge.prayerSnooze).catchError((_) {});
  }

  void _copy(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _open(String url) async {
    final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication).catchError((_) => false);
    if (!ok && mounted) _copy(url, AppLocalizations.of(context)!.supportLinkCopied);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final methods = _methods;

    return InnerPageScaffold(
      title: l10n.supportTitle,
      subtitle: l10n.supportSubtitle,
      color: _purple,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(l10n),
            if (methods.isNotEmpty) ...[
              const SizedBox(height: 26),
              _sectionTitle(l10n.supportChooseMethod),
              _buildMethodPicker(l10n, methods),
              const SizedBox(height: 14),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SizeTransition(sizeFactor: anim, axisAlignment: -1, child: child),
                ),
                child: KeyedSubtree(
                  key: ValueKey(_method),
                  child: switch (_method) {
                    _Method.pix => _buildPix(l10n),
                    _Method.card => _buildCard(l10n),
                    _Method.crypto => _buildCrypto(l10n),
                    null => const SizedBox.shrink(),
                  },
                ),
              ),
            ],
            const SizedBox(height: 26),
            _buildPrayer(l10n),
            if (methods.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                child: Text(
                  l10n.supportFootnote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, height: 1.4, color: AppColors.secondaryText),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- Destaque: o projeto ----------------

  Widget _buildHero(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_purpleDeep, _purple, Color(0xFF8E3FA8)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(color: _purple.withValues(alpha: 0.35), blurRadius: 22, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // brilho dourado no canto
            Positioned(
              right: -60,
              top: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [_gold.withValues(alpha: 0.35), _gold.withValues(alpha: 0)]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
              child: Column(
                children: [
                  const SizedBox(width: 92, height: 56, child: CustomPaint(painter: _RingsPainter(_gold))),
                  const SizedBox(height: 14),
                  Text(
                    l10n.supportHeroTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.supportStory,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.92), fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, width: 60, color: _gold.withValues(alpha: 0.7)),
                  const SizedBox(height: 12),
                  Text(
                    l10n.supportQuote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _badge(Icons.card_giftcard, l10n.supportBadgeFree),
                      _badge(Icons.block, l10n.supportBadgeNoAds),
                      _badge(Icons.lock_outline, l10n.supportBadgePrivate),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: _gold),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryText),
        ),
      );

  // ---------------- Escolha da forma de doação ----------------

  Widget _buildMethodPicker(AppLocalizations l10n, List<_Method> methods) {
    (IconData, Color, String) style(_Method m) => switch (m) {
          _Method.pix => (Icons.pix, _pixColor, l10n.supportMethodPix),
          _Method.card => (Icons.credit_card, _cardColor, l10n.supportMethodCard),
          _Method.crypto => (Icons.currency_bitcoin, _cryptoColor, l10n.supportMethodCrypto),
        };
    return Row(
      children: [
        for (final m in methods) ...[
          if (m != methods.first) const SizedBox(width: 10),
          Expanded(
            child: Builder(builder: (context) {
              final (icon, color, label) = style(m);
              final selected = _method == m;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: selected ? color : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: selected ? color : color.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: (selected ? color : Colors.black).withValues(alpha: selected ? 0.3 : 0.05),
                      blurRadius: selected ? 12 : 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: ValueKey('method_${m.name}'),
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => setState(() => _method = m),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                      child: Column(
                        children: [
                          Icon(icon, color: selected ? Colors.white : color, size: 28),
                          const SizedBox(height: 6),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: selected ? Colors.white : AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }

  Widget _panel({required Color color, required Widget child}) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withValues(alpha: 0.25)),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: child,
      );

  Widget _panelHeader(String title, String desc) => Column(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText)),
        ],
      );

  // ---------------- PIX ----------------

  Widget _buildPix(AppLocalizations l10n) {
    final payload = PixPayload.build(
      key: DonationConfig.pixKey,
      name: DonationConfig.pixReceiverName,
      city: DonationConfig.pixCity,
      amount: _amount?.toDouble(),
    );
    Widget amountChip(int? value, String label) {
      final selected = _amount == value;
      return ChoiceChip(
        key: ValueKey('pix_amount_${value ?? 'free'}'),
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => setState(() => _amount = value),
        selectedColor: _pixColor,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: _pixColor.withValues(alpha: selected ? 1 : 0.35)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      );
    }

    return _panel(
      color: _pixColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _panelHeader(l10n.supportPixTitle, l10n.supportPixDesc),
          const SizedBox(height: 14),
          Text(l10n.supportPixAmountLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.secondaryText)),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final v in DonationConfig.pixSuggestedAmounts) amountChip(v, 'R\$ $v'),
              amountChip(null, l10n.supportPixAmountFree),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _pixColor, width: 2),
              ),
              child: QrImageView(
                key: const ValueKey('pix_qr'),
                data: payload,
                size: 200,
                padding: EdgeInsets.zero,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF1F2D3D)),
                dataModuleStyle:
                    const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF1F2D3D)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PillButton(
            key: const ValueKey('pix_copy_paste'),
            label: l10n.supportPixCopyPaste,
            icon: Icons.copy,
            color: _pixColor,
            onPressed: () => _copy(payload, l10n.supportPixCopied),
          ),
          const SizedBox(height: 10),
          _CopyRow(
            label: l10n.supportPixKey,
            value: DonationConfig.pixKey,
            onCopy: () => _copy(DonationConfig.pixKey, l10n.donateSuccess),
          ),
        ],
      ),
    );
  }

  // ---------------- Cartão ----------------

  Widget _buildCard(AppLocalizations l10n) {
    return _panel(
      color: _cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: CircleIcon(icon: Icons.coffee, color: _cardColor, size: 64)),
          const SizedBox(height: 12),
          _panelHeader(l10n.supportCardTitle, l10n.supportCardDesc),
          const SizedBox(height: 16),
          PillButton(
            key: const ValueKey('card_button'),
            label: DonationConfig.cardPlatform,
            icon: Icons.open_in_new,
            color: _cardColor,
            onPressed: () => _open(DonationConfig.cardUrl),
          ),
        ],
      ),
    );
  }

  // ---------------- Cripto ----------------

  Widget _buildCrypto(AppLocalizations l10n) {
    return _panel(
      color: _cryptoColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _panelHeader(l10n.supportCryptoTitle, l10n.supportCryptoDesc),
          if (DonationConfig.hasCryptoLink) ...[
            const SizedBox(height: 14),
            PillButton(
              key: const ValueKey('crypto_link'),
              label: l10n.supportCryptoLinkButton,
              icon: Icons.open_in_new,
              color: _cryptoColor,
              onPressed: () => _open(DonationConfig.cryptoDonationUrl),
            ),
          ],
          for (final w in DonationConfig.cryptoWallets)
            _CryptoTile(wallet: w, onCopy: (a) => _copy(a, l10n.supportAddressCopied)),
        ],
      ),
    );
  }

  // ---------------- Oração ----------------

  Widget _buildPrayer(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF8E7), _gold.withValues(alpha: 0.18)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _gold.withValues(alpha: 0.45)),
      ),
      child: Column(
        children: [
          const Icon(Icons.local_florist, color: _cardColor, size: 34),
          const SizedBox(height: 8),
          Text(
            l10n.supportPrayerAlt,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryText),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.supportPrayerDesc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.secondaryText),
          ),
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _promised
                ? Container(
                    key: const ValueKey('prayer_thanks'),
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, color: _purple),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.supportPrayerThanks,
                            style: const TextStyle(
                                fontSize: 14, height: 1.4, color: _purple, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                : PillButton(
                    key: const ValueKey('prayer_promise'),
                    label: l10n.supportPrayerButton,
                    icon: Icons.favorite_border,
                    color: _purple,
                    onPressed: _promisePrayer,
                  ),
          ),
        ],
      ),
    );
  }
}

/// Duas alianças entrelaçadas (o emblema do projeto).
class _RingsPainter extends CustomPainter {
  final Color color;
  const _RingsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.height * 0.42;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.09;
    final glow = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final c1 = Offset(size.width / 2 - r * 0.62, size.height / 2);
    final c2 = Offset(size.width / 2 + r * 0.62, size.height / 2);
    for (final c in [c1, c2]) {
      canvas.drawCircle(c, r, glow);
    }
    canvas.drawCircle(c1, r, paint);
    canvas.drawCircle(c2, r, paint);
  }

  @override
  bool shouldRepaint(covariant _RingsPainter old) => old.color != color;
}

/// Texto copiável (chave PIX, endereço) com botão de copiar.
class _CopyRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onCopy;
  const _CopyRow({required this.label, required this.value, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
                SelectableText(value,
                    style: const TextStyle(fontSize: 13, fontFamily: 'monospace', color: AppColors.primaryText)),
              ],
            ),
          ),
          IconButton(
            tooltip: MaterialLocalizations.of(context).copyButtonLabel,
            icon: const Icon(Icons.copy, size: 20, color: AppColors.secondaryText),
            onPressed: onCopy,
          ),
        ],
      ),
    );
  }
}

/// Uma carteira de cripto: nome, endereço copiável e QR ao tocar.
class _CryptoTile extends StatefulWidget {
  final CryptoWallet wallet;
  final ValueChanged<String> onCopy;
  const _CryptoTile({required this.wallet, required this.onCopy});

  @override
  State<_CryptoTile> createState() => _CryptoTileState();
}

class _CryptoTileState extends State<_CryptoTile> {
  bool _showQr = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CopyRow(
            label: widget.wallet.name,
            value: widget.wallet.address,
            onCopy: () => widget.onCopy(widget.wallet.address),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() => _showQr = !_showQr),
              icon: Icon(_showQr ? Icons.expand_less : Icons.qr_code, size: 18),
              label: Text(_showQr ? l10n.supportHideQr : l10n.supportShowQr),
            ),
          ),
          if (_showQr)
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: QrImageView(data: widget.wallet.address, size: 170, padding: EdgeInsets.zero),
              ),
            ),
        ],
      ),
    );
  }
}
