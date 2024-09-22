import 'package:guardian/data/models/password_schema.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  late Future<Isar> db;

  DatabaseService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PasswordSchema],
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());

  }

  Future<void> savePassword(Password password) async {
    final isar = await db;
    await isar.writeTxn(()async {
      await isar.passwords.put(password);
    });
  }
}
