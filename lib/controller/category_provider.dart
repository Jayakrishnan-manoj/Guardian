import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guardian/data/models/category_schema.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class CategoryProvider extends ChangeNotifier {
  final DatabaseService _databaseService;
  CategorySchema _categorySchema = CategorySchema();

  CategoryProvider(this._databaseService) {
    _initCategoryCounts();
  }

  CategorySchema get categorySchema => _categorySchema;

  Future<void> _initCategoryCounts() async {
    _categorySchema = await _databaseService.getCategoryCounts();
    notifyListeners();
  }

  void updateCategoryCount(Categories category, int change)async{
    await _databaseService.updateCategoryCount(category, change);
    _categorySchema = await _databaseService.getCategoryCounts();
    notifyListeners();
  }

  Stream<CategorySchema> watchCategoryCounts() {
    return _databaseService.watchCategoryCounts();
  }
}


// class CategoryProvider extends ChangeNotifier {

//   int _browserPasswords = 0;
//   int _socialPasswords = 0;
//   int _paymentPasswords = 0;
//   int _miscellaneousPasswords = 0;

//   int get browserPasswords => _browserPasswords;
//   int get socialPasswords => _socialPasswords;
//   int get paymentPasswords => _paymentPasswords;
//   int get miscellaneousPasswords => _miscellaneousPasswords;

//   void updatePasswordCount(Categories category) {
//     switch (category) {
//       case Categories.browser:
//         _browserPasswords += 1;
//         break;
//       case Categories.socialMedia:
//         _socialPasswords += 1;
//         break;
//       case Categories.payments:
//         _paymentPasswords += 1;
//         break;
//       case Categories.miscellaneous:
//         _miscellaneousPasswords += 1;
//       default:
//     }
//     notifyListeners();
//   }
// }
