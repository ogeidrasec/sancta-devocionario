/// "PIX copia e cola" (BR Code estático do Banco Central), gerado no aparelho.
/// O mesmo texto vira o QR Code.
class PixPayload {
  static String build({
    required String key,
    required String name,
    required String city,
    double? amount,
    String txid = '***',
  }) {
    String field(String id, String value) => '$id${value.length.toString().padLeft(2, '0')}$value';

    final account = field('00', 'br.gov.bcb.pix') + field('01', key);
    final buffer = StringBuffer()
      ..write(field('00', '01'))
      ..write(field('26', account))
      ..write(field('52', '0000'))
      ..write(field('53', '986'));
    if (amount != null && amount > 0) buffer.write(field('54', amount.toStringAsFixed(2)));
    buffer
      ..write(field('58', 'BR'))
      ..write(field('59', _clean(name, 25)))
      ..write(field('60', _clean(city, 15)))
      ..write(field('62', field('05', txid)))
      ..write('6304');
    final payload = buffer.toString();
    return payload + crc16(payload);
  }

  /// CRC16-CCITT (polinômio 0x1021, início 0xFFFF), em 4 dígitos hexadecimais.
  static String crc16(String data) {
    var crc = 0xFFFF;
    for (final byte in data.codeUnits) {
      crc ^= byte << 8;
      for (var i = 0; i < 8; i++) {
        crc = (crc & 0x8000) != 0 ? ((crc << 1) ^ 0x1021) : (crc << 1);
        crc &= 0xFFFF;
      }
    }
    return crc.toRadixString(16).toUpperCase().padLeft(4, '0');
  }

  static const _accents = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'é': 'e', 'ê': 'e', 'è': 'e',
    'í': 'i', 'ì': 'i', 'î': 'i', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ò': 'o', 'ú': 'u',
    'ù': 'u', 'û': 'u', 'ü': 'u', 'ç': 'c', 'ñ': 'n',
  };

  /// Sem acentos e no tamanho máximo do campo (o padrão aceita só ASCII).
  static String _clean(String s, int max) {
    final out = s.split('').map((c) {
      final lower = c.toLowerCase();
      final plain = _accents[lower];
      if (plain == null) return c;
      return c == lower ? plain : plain.toUpperCase();
    }).join().replaceAll(RegExp(r'[^\x20-\x7E]'), '');
    return out.length > max ? out.substring(0, max) : out;
  }
}
