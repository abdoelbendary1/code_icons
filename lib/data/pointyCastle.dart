import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

Uint8List generateKeyAndIv(
    String key, Uint8List salt, int iterations, int keySize, int ivSize) {
  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA1Digest(), 64));
  pbkdf2.init(Pbkdf2Parameters(salt, iterations, (keySize + ivSize) ~/ 8));

  final keyAndIv = pbkdf2.process(Uint8List.fromList(utf8.encode(key)));
  return keyAndIv;
}

Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
  final cbc = CBCBlockCipher(AESEngine())
    ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

  final paddedPlainText = Uint8List(cipherText.length);
  var offset = 0;
  while (offset < cipherText.length) {
    offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
  }

  // Remove padding (assuming PKCS7 padding)
  final padCount = paddedPlainText.last;
  final plainText =
      paddedPlainText.sublist(0, paddedPlainText.length - padCount);

  return plainText;
}

String decrypt(String base64CipherText) {
  const key = "EncryptionKey";
  final salt = base64.decode('SXZhbiBNZWR2ZWRldg==');
  const iterations = 1000;

  try {
    final keyAndIv = generateKeyAndIv(key, salt, iterations, 256, 128);
    final hexKey = keyAndIv.sublist(0, 32);
    final iv = keyAndIv.sublist(32, 48);

    final cipherText = base64.decode(base64CipherText);
    final decryptedBytes = aesCbcDecrypt(hexKey, iv, cipherText);

    return utf8.decode(decryptedBytes.where((byte) => byte != 0).toList());
  } catch (error) {
    throw error;
  }
}
