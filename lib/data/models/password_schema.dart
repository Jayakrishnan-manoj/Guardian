import 'package:isar/isar.dart';

part 'password_schema.g.dart';

@collection
class Password {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title = '';

  String? username;
  String encryptedPassword = '';

  @enumerated
  Categories category = Categories.miscellaneous;

  String? websiteAddress;
  String? note;
  String? connectedAccount;

  @Index(type: IndexType.value)
  DateTime createdAt = DateTime.now();

  DateTime lastModified = DateTime.now();

  String? imagePath;
}

enum Categories {
  browser,
  socialMedia,
  payments,
  miscellaneous,
}
