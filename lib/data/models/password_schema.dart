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

  // Add this factory constructor
  static Password fromMap(Map<String, dynamic> map) {
    return Password()
      ..id = map['id'] as Id
      ..title = map['title'] as String
      ..username = map['username'] as String?
      ..encryptedPassword = map['encryptedPassword'] as String
      ..category = Categories.values.firstWhere(
        (e) => e.toString() == 'Categories.${map['category']}',
        orElse: () => Categories.miscellaneous,
      )
      ..websiteAddress = map['websiteAddress'] as String?
      ..note = map['note'] as String?
      ..connectedAccount = map['connectedAccount'] as String?
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
      ..lastModified =
          DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int)
      ..imagePath = map['imagePath'] as String?;
  }

  // Add this method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'encryptedPassword': encryptedPassword,
      'category': category.toString().split('.').last,
      'websiteAddress': websiteAddress,
      'note': note,
      'connectedAccount': connectedAccount,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModified': lastModified.millisecondsSinceEpoch,
      'imagePath': imagePath,
    };
  }

  // Add this method
  Password copyWith({
    Id? id,
    String? title,
    String? username,
    String? encryptedPassword,
    Categories? category,
    String? websiteAddress,
    String? note,
    String? connectedAccount,
    DateTime? createdAt,
    DateTime? lastModified,
    String? imagePath,
  }) {
    return Password()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..username = username ?? this.username
      ..encryptedPassword = encryptedPassword ?? this.encryptedPassword
      ..category = category ?? this.category
      ..websiteAddress = websiteAddress ?? this.websiteAddress
      ..note = note ?? this.note
      ..connectedAccount = connectedAccount ?? this.connectedAccount
      ..createdAt = createdAt ?? this.createdAt
      ..lastModified = lastModified ?? this.lastModified
      ..imagePath = imagePath ?? this.imagePath;
  }
}

enum Categories {
  browser,
  socialMedia,
  payments,
  miscellaneous,
}
