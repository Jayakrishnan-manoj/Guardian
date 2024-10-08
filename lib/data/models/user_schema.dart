import 'package:isar/isar.dart';

part 'user_schema.g.dart';

@collection
class UserSchema {
  Id id = Isar.autoIncrement;
  String name = '';
}

