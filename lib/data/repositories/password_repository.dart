import 'dart:async';

import 'package:guardian/controller/category_provider.dart';
import 'package:guardian/data/models/category_schema.dart';
import 'package:guardian/data/models/user_schema.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:isar/isar.dart';

import '../models/password_schema.dart';

class PasswordRepository {
  final DatabaseService _databaseService;
  final CategoryProvider _categoryProvider;

  PasswordRepository(this._databaseService, this._categoryProvider);

  Future<void> savePassword(Password password) async {
    await _databaseService.savePassword(password);
    _categoryProvider.updateCategoryCount(password.category, 1);
  }

  Future<List<Password>> getAllPasswords() async {
    return await _databaseService.getAllPasswords();
  }

  Future<void> deletePassword(Password password) async {
    await _databaseService.deletePassword(password.id);
    _categoryProvider.updateCategoryCount(password.category, -1);
  }

  Future<List<Password>> watchPasswordsByCategory(Categories category) {
    return _databaseService.db.then((isar) {
      return isar.passwords.filter().categoryEqualTo(category).findAll();
    });
  }

  Future<int> countPasswordsByCategory(Categories category) async {
    return _databaseService.db.then((isar) {
      return isar.passwords.filter().categoryEqualTo(category).count();
    });
  }

  Future<String?> getSavedUser() async {
    return _databaseService.getUser();
  }

  Future<void> saveUser(UserSchema user) async {
    _databaseService.saveUser(user);
  }

  Future<void> updateUserName(int userId, String newName) async {
    _databaseService.updateUserName(userId, newName);
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
    required Categories newCategory,
  }) async {
    Categories oldCategory = password.category;
    await _databaseService.updatePassword(
      password,
      username: username,
      encryptedPassword: encryptedPassword,
      connectedAccount: connectedAccount,
      websiteAddress: websiteAddress,
      note: note,
      imagePath: imagePath,
      title: title,
    );
    if (oldCategory != newCategory) {
      _categoryProvider.updateCategoryCount(oldCategory, -1);
      _categoryProvider.updateCategoryCount(newCategory, 1);
    }
  }

  Stream<List<Password>> watchPasswords() {
    return _databaseService.listenPasswords();
  }

  Stream<CategorySchema> watchCategoryCounts() {
    return _categoryProvider.watchCategoryCounts();
  }
}
