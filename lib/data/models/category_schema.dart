import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'category_schema.g.dart';

@collection
class CategorySchema {
  Id id = Isar.autoIncrement;
  int browserPasswords = 0;
  int socialPasswords = 0;
  int paymentPasswords = 0;
  int miscellaneousPasswords = 0;
}


