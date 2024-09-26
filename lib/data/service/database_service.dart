import 'package:guardian/data/models/password_schema.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DatabaseService {
  late Future<Isar> db;
  late StreamController<List<Password>> _passwordsController;
  StreamSubscription? _passwordSubscription;
  bool _isInitialized = false;

  DatabaseService() {
    db = openDB();
  }

  Stream<List<Password>> listenPasswords() async* {
    final isar = await db;
    yield* isar.passwords
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  Stream<List<Password>> get watchPasswordEntries {
    print("Accessing watchPasswordEntries"); // Debug print
    return _passwordsController.stream;
  }

  void dispose() {
    _passwordSubscription?.cancel();
    _passwordsController.close();
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
    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  Future<void> updatePassword(
    Password password, {
    required String username,
    required String encryptedPassword,
    required String? connectedAccount,
    required String? websiteAddress,
    required String? note,
    required String? imagePath,
  }) async {
    final isar = await db;
    password.username = username;
    password.encryptedPassword = encryptedPassword;
    password.connectedAccount = connectedAccount;
    password.websiteAddress = websiteAddress;
    password.note = note;
    password.imagePath = imagePath;
    password.lastModified = DateTime.now();

    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  // Stream<List<Password>> watchPasswordEntries() async* {
  //   final isar = await db;
  //   yield* isar.passwords
  //       .where()
  //       .sortByCreatedAtDesc()
  //       .watch(fireImmediately: true);
  // }
}
