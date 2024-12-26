import 'dart:convert';

import "package:encrypt/encrypt.dart" as encrypt;
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:http/http.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  final _secureStorage = const FlutterSecureStorage();
  factory EncryptionService() => _instance;

  EncryptionService._internal();

  encrypt.Key? _key;
  final _keyStorageKey = 'encryption_key';

  Future<void> init() async {
    final storedKey = await _secureStorage.read(key: _keyStorageKey);
    if (storedKey != null) {
      _key = encrypt.Key.fromBase64(storedKey);
    } else {
      final newKey = _generateRandomKey();
      await _secureStorage.write(key: _keyStorageKey, value: newKey);
      _key = encrypt.Key.fromBase64(newKey);
    }
  }

  String generateRecoveryPhrase() {
    return bip39.generateMnemonic();
  }

  bool validateRecoveryPhrase(String phrase) {
    return bip39.validateMnemonic(phrase);
  }

  Future<List<int>> deriveKey(String password, String salt) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final secretKey = SecretKey(utf8.encode(password));
    final derivedKey = await pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: utf8.encode(salt),
    );
    return derivedKey.extractBytes();
  }

  Future<Map<String, String>> encryptMasterKey(
      List<int> masterKey, String recoveryPhrase) async {
    final recoveryKey =
        await deriveKey(recoveryPhrase, "guardian-jayk-passman");
    final encrypter = AesCbc.with128bits(macAlgorithm: MacAlgorithm.empty);
    // final iv = encrypt.IV.fromLength(16);
    final iv = List<int>.generate(16, (i) => i);
    final encryptedKey = await encrypter.encrypt(
      masterKey,
      secretKey: SecretKey(recoveryKey),
      nonce: iv,
    );

    return {
      "encryptedKey": base64Encode(encryptedKey.cipherText),
      "iv": base64Encode(iv)
    };
  }

  String encryptPassword(String password) {
    final iv = encrypt.IV.fromLength(16);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(_key!, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  String decryptPassword(String encryptedPassword) {
    final parts = encryptedPassword.split(':');
    final iv = encrypt.IV.fromBase64(parts[0]);
    final encrypted = encrypt.Encrypted.fromBase64(parts[1]);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(_key!, mode: encrypt.AESMode.cbc));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  String _generateRandomKey() {
    final random = encrypt.SecureRandom(32);
    return encrypt.Key(random.bytes).base64;
  }
}
