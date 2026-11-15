// =====================================================================
// DOAÇÕES — preencha aqui. O que ficar vazio ('') não aparece no app.
// =====================================================================
//
// PIX: use uma chave ALEATÓRIA ou um e-mail só do app (nunca o CPF): a chave
// fica visível para todos. Nome e cidade aparecem no app do banco de quem paga.
//
// Os valores marcados com "PREENCHER" são provisórios: o script de release
// (tool/build_release.ps1) recusa gerar o pacote enquanto eles existirem.

class DonationConfig {
  // ---------- PIX (Brasil) ----------
  static const pixKey = 'f5575d0d-797f-457a-9dcb-e6623bdeb775';
  /// Nome do recebedor (até 25 letras, sem acento), como no banco.
  static const pixReceiverName = 'DIEGO CESAR SOUSA COSTA';
  /// Cidade do recebedor (até 15 letras, sem acento).
  static const pixCity = 'SAO PAULO';
  /// Valores sugeridos (em reais) nos botões do PIX; "Outro valor" deixa em aberto.
  static const pixSuggestedAmounts = <int>[10, 25, 50];

  // ---------- Cartão (internacional) ----------
  /// Página de doações por cartão e PayPal (Ko-fi; serve também Buy Me a Coffee etc.).
  static const cardUrl = 'https://ko-fi.com/sanctadevocionario';
  /// Nome mostrado no botão (ex.: 'Ko-fi').
  static const cardPlatform = 'Ko-fi';

  // ---------- Criptomoedas (internacional) ----------
  /// Uma linha por moeda: nome (com a rede, se houver) e endereço.
  static const crypto = <CryptoWallet>[
    CryptoWallet('Bitcoin (BTC)', 'bc1qn7y92w8hfhlxfe37g7uxcxpnd4ltkp0qtzzk4e'),
    // Para outra moeda, acrescente uma linha: CryptoWallet('USDT (rede Tron, TRC-20)', 'endereço'),
  ];

  /// Opcional: página de doação em cripto (ex.: um link do NOWPayments ou de
  /// um servidor BTCPay). Aparece como botão acima dos endereços.
  static const cryptoDonationUrl = '';

  // ---------- Versão para lojas ----------
  /// Play Store e App Store costumam não aceitar doação por link externo para
  /// pessoa física. Gere a versão dessas lojas com
  /// --dart-define=DONATION_LINKS=false: fica só o pedido de oração.
  static const showPaymentLinks = bool.fromEnvironment('DONATION_LINKS', defaultValue: true);

  static bool get hasPix => showPaymentLinks && pixKey.isNotEmpty;
  static bool get hasCard => showPaymentLinks && cardUrl.isNotEmpty;
  static bool get hasCryptoLink => showPaymentLinks && cryptoDonationUrl.isNotEmpty;
  static List<CryptoWallet> get cryptoWallets =>
      showPaymentLinks ? crypto.where((w) => w.address.isNotEmpty).toList() : const [];

  /// Ainda há valores provisórios ("PREENCHER")?
  static bool get hasPlaceholders =>
      [pixKey, pixReceiverName, cardUrl, ...crypto.map((w) => w.address)]
          .any((v) => v.contains('PREENCHER'));
}

class CryptoWallet {
  final String name;
  final String address;
  const CryptoWallet(this.name, this.address);
}
