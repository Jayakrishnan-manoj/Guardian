import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../data/models/password_schema.dart';
import '../data/service/database_service.dart';

class AutofillService {
  static const platform = MethodChannel('autofill_channel');
  final DatabaseService _databaseService;

  AutofillService(this._databaseService) {
    _initializeMethodChannel();
  }

  void _initializeMethodChannel() {
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'getPasswordsForPackage':
          final packageName = call.arguments as String;
          return await _getPasswordsForPackage(packageName);
        default:
          throw PlatformException(
            code: 'NOT_IMPLEMENTED',
            message: 'Method not implemented',
          );
      }
    });
  }

  Future<List<Map<String, dynamic>>> _getPasswordsForPackage(String packageName) async {
    final isar = await _databaseService.db;
    
    // Query passwords that match the package name (website address)
    final passwords = await isar.passwords
        .filter()
        .websiteAddressContains(packageName, caseSensitive: false)
        .or()
        .titleContains(packageName, caseSensitive: false)
        .findAll();

    // Convert passwords to maps that can be sent through the platform channel
    return passwords.map((password) => password.toMap()).toList();
  }
}
