part of encrypt;

/// Wraps Algorithms in a unique Container.
class Encrypter {
  final Algorithm algo;
  final iv = IV.fromUtf8("weaxO23UXGedmzfT");

  Encrypter(this.algo);

  /// Calls [encrypt] on the wrapped Algorithm using a raw binary.
  Encrypted encryptBytes(List<int> input) {
    if (input is Uint8List) {
      return algo.encrypt(input, iv: this.iv);
    }

    return algo.encrypt(Uint8List.fromList(input), iv: this.iv);
  }

  /// Calls [encrypt] on the wrapped Algorithm.
  Encrypted encrypt(String input) {
    return encryptBytes(convert.utf8.encode(input));
  }

  /// Calls [decrypt] on the wrapped Algorith without UTF-8 decoding.
  List<int> decryptBytes(Encrypted encrypted) {
    return algo.decrypt(encrypted, iv: this.iv).toList();
  }

  /// Calls [decrypt] on the wrapped Algorithm.
  String decrypt(Encrypted encrypted) {
    return convert.utf8.decode(decryptBytes(encrypted), allowMalformed: true);
  }

  /// Sugar for `decrypt(Encrypted.fromBase16(encoded))`.
  String decrypt16(String encoded) {
    return decrypt(Encrypted.fromBase16(encoded));
  }

  /// Sugar for `decrypt(Encrypted.fromBase64(encoded))`.
  String decrypt64(String encoded) {
    return decrypt(Encrypted.fromBase64(encoded));
  }
}
