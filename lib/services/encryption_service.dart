import "package:encrypt/encrypt.dart" as encrypt;
import "package:flutter_secure_storage/flutter_secure_storage.dart";

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
