import 'dart:math';

import 'package:guardian/data/models/category_schema.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/models/user_schema.dart';
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
        .limit(10)
        .watch(fireImmediately: true);
  }

  Future<List<Password>> getAllPasswords() async {
    final isar = await db;
    return isar.passwords.where().findAll();
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
        [PasswordSchema, CategorySchemaSchema, UserSchemaSchema],
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

  Future<void> deletePassword(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final success = await isar.passwords.delete(id);
      print('Password deleted $success');
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
    required String? title,
  }) async {
    final isar = await db;
    password.username = username;
    password.encryptedPassword = encryptedPassword;
    password.connectedAccount = connectedAccount;
    password.websiteAddress = websiteAddress;
    password.note = note;
    password.imagePath = imagePath;
    password.lastModified = DateTime.now();
    password.title = title!;

    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  Future<void> updateCategoryCount(Categories category, int change) async {
    final isar = await db;
    await isar.writeTxn(() async {
      var counts =
          await isar.categorySchemas.where().findFirst() ?? CategorySchema();
      switch (category) {
        case Categories.browser:
          counts.browserPasswords += change;
          break;
        case Categories.socialMedia:
          counts.socialPasswords += change;
          break;
        case Categories.payments:
          counts.paymentPasswords += change;
          break;
        case Categories.miscellaneous:
          counts.miscellaneousPasswords += change;
          break;
      }
      await isar.categorySchemas.put(counts);
    });
  }

  Future<CategorySchema> getCategoryCounts() async {
    final isar = await db;
    return await isar.categorySchemas.where().findFirst() ?? CategorySchema();
  }

  Stream<CategorySchema> watchCategoryCounts() async* {
    final isar = await db;
    yield* isar.categorySchemas
        .where()
        .watch(fireImmediately: true)
        .map((counts) => counts.isNotEmpty ? counts.first : CategorySchema());
  }

  Future<void> saveUser(UserSchema user) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.userSchemas.put(user);
    });
  }

  Future<void> updateUserName(int userId, String newName) async {
  final isar = await db;
  
  await isar.writeTxn(() async {
    // Get the user from the database
    final user = await isar.userSchemas.get(userId);
    
    if (user != null) {
      // Update the name
      user.name = newName;
      
      // Save the updated user back to the database
      await isar.userSchemas.put(user);
    }
  });
}

  Future<String?> getUser() async {
  final isar = await db;
  final user = await isar.userSchemas.where().findFirst();
  return user?.name;
}

  // Stream<List<Password>> watchPasswordEntries() async* {
  //   final isar = await db;
  //   yield* isar.passwords
  //       .where()
  //       .sortByCreatedAtDesc()
  //       .watch(fireImmediately: true);
  // }
}
