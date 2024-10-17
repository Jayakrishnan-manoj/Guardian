import 'package:flutter/services.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/services/encryption_service.dart';

// class AutofillService {
//   static final AutofillService _instance = AutofillService._internal();
//   factory AutofillService() => _instance;

//   AutofillService._internal();

//   static const platform = MethodChannel("autofill_channel");
//   final EncryptionService _encryptionService = EncryptionService();

//   Future<void> init() async {
//     await _encryptionService.init();
//   }

//   Future<List<Password>> getPasswordsForPackage(String packageName) async {
//     final List result =
//         await platform.invokeMethod('getPasswordsForPackage', packageName);
//     return result
//         .map((item) => _decryptPassword(Password.fromMap(item)))
//         .toList();
//   }

//   Password _decryptPassword(Password password) {
//     return password.copyWith(
//         encryptedPassword:
//             _encryptionService.decryptPassword(password.encryptedPassword));
//   }

//   Future<void> savePassword(Password password) async {
//     final encryptedPassword = password.copyWith(
//         encryptedPassword:
//             _encryptionService.encryptPassword(password.encryptedPassword));
//     await platform.invokeMethod('savePassword', encryptedPassword.toMap());
//   }
// }
