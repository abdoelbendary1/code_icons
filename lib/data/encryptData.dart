import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

class EncryptData {
//for AES Algorithms
  static Encrypted? encrypted;
  static var decrypted;
  static encryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    print(encrypted!.base64);
  }

  static decryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    print(decrypted);
  } // Define your decrypt function

  static String generateKey(String keyString, int bitLength) {
    var bytes = utf8.encode(keyString);
    var hash = sha256.convert(bytes).bytes;

    if (bitLength == 128) {
      return base64Url.encode(hash.sublist(0, 16));
    } else if (bitLength == 192) {
      return base64Url.encode(hash.sublist(0, 24));
    } else if (bitLength == 256) {
      return base64Url.encode(hash);
    } else {
      throw ArgumentError('Invalid key length. Must be 128, 192, or 256 bits.');
    }
  }

  static String decryptString(
      {required String encryptedString,
      required String keyString,
      required String ivString,
      required int keyLength}) {
    final keyBase64 = generateKey(keyString, keyLength);
    final key = Key.fromBase64(keyBase64);
    final iv = IV.fromUtf8(ivString);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = Encrypted.fromBase64(encryptedString);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }
}
