// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCategorySchemaCollection on Isar {
  IsarCollection<CategorySchema> get categorySchemas => this.collection();
}

const CategorySchemaSchema = CollectionSchema(
  name: r'CategorySchema',
  id: 2167192066729855138,
  properties: {
    r'browserPasswords': PropertySchema(
      id: 0,
      name: r'browserPasswords',
      type: IsarType.long,
    ),
    r'miscellaneousPasswords': PropertySchema(
      id: 1,
      name: r'miscellaneousPasswords',
      type: IsarType.long,
    ),
    r'paymentPasswords': PropertySchema(
      id: 2,
      name: r'paymentPasswords',
      type: IsarType.long,
    ),
    r'socialPasswords': PropertySchema(
      id: 3,
      name: r'socialPasswords',
      type: IsarType.long,
    )
  },
  estimateSize: _categorySchemaEstimateSize,
  serialize: _categorySchemaSerialize,
  deserialize: _categorySchemaDeserialize,
  deserializeProp: _categorySchemaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _categorySchemaGetId,
  getLinks: _categorySchemaGetLinks,
  attach: _categorySchemaAttach,
  version: '3.1.0+1',
);

int _categorySchemaEstimateSize(
  CategorySchema object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _categorySchemaSerialize(
  CategorySchema object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.browserPasswords);
  writer.writeLong(offsets[1], object.miscellaneousPasswords);
  writer.writeLong(offsets[2], object.paymentPasswords);
  writer.writeLong(offsets[3], object.socialPasswords);
}

CategorySchema _categorySchemaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CategorySchema();
  object.browserPasswords = reader.readLong(offsets[0]);
  object.id = id;
  object.miscellaneousPasswords = reader.readLong(offsets[1]);
  object.paymentPasswords = reader.readLong(offsets[2]);
  object.socialPasswords = reader.readLong(offsets[3]);
  return object;
}

P _categorySchemaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _categorySchemaGetId(CategorySchema object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _categorySchemaGetLinks(CategorySchema object) {
  return [];
}

void _categorySchemaAttach(
    IsarCollection<dynamic> col, Id id, CategorySchema object) {
  object.id = id;
}

extension CategorySchemaQueryWhereSort
    on QueryBuilder<CategorySchema, CategorySchema, QWhere> {
  QueryBuilder<CategorySchema, CategorySchema, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CategorySchemaQueryWhere
    on QueryBuilder<CategorySchema, CategorySchema, QWhereClause> {
  QueryBuilder<CategorySchema, CategorySchema, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CategorySchemaQueryFilter
    on QueryBuilder<CategorySchema, CategorySchema, QFilterCondition> {
  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      browserPasswordsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'browserPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      browserPasswordsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'browserPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      browserPasswordsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'browserPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      browserPasswordsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'browserPasswords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      miscellaneousPasswordsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'miscellaneousPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      miscellaneousPasswordsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'miscellaneousPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      miscellaneousPasswordsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'miscellaneousPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      miscellaneousPasswordsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'miscellaneousPasswords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      paymentPasswordsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      paymentPasswordsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      paymentPasswordsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      paymentPasswordsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentPasswords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      socialPasswordsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'socialPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      socialPasswordsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'socialPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      socialPasswordsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'socialPasswords',
        value: value,
      ));
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterFilterCondition>
      socialPasswordsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'socialPasswords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CategorySchemaQueryObject
    on QueryBuilder<CategorySchema, CategorySchema, QFilterCondition> {}

extension CategorySchemaQueryLinks
    on QueryBuilder<CategorySchema, CategorySchema, QFilterCondition> {}

extension CategorySchemaQuerySortBy
    on QueryBuilder<CategorySchema, CategorySchema, QSortBy> {
  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByBrowserPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browserPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByBrowserPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browserPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByMiscellaneousPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'miscellaneousPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByMiscellaneousPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'miscellaneousPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByPaymentPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortByPaymentPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortBySocialPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      sortBySocialPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialPasswords', Sort.desc);
    });
  }
}

extension CategorySchemaQuerySortThenBy
    on QueryBuilder<CategorySchema, CategorySchema, QSortThenBy> {
  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByBrowserPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browserPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByBrowserPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browserPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByMiscellaneousPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'miscellaneousPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByMiscellaneousPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'miscellaneousPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByPaymentPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenByPaymentPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPasswords', Sort.desc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenBySocialPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialPasswords', Sort.asc);
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QAfterSortBy>
      thenBySocialPasswordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialPasswords', Sort.desc);
    });
  }
}

extension CategorySchemaQueryWhereDistinct
    on QueryBuilder<CategorySchema, CategorySchema, QDistinct> {
  QueryBuilder<CategorySchema, CategorySchema, QDistinct>
      distinctByBrowserPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'browserPasswords');
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QDistinct>
      distinctByMiscellaneousPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'miscellaneousPasswords');
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QDistinct>
      distinctByPaymentPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentPasswords');
    });
  }

  QueryBuilder<CategorySchema, CategorySchema, QDistinct>
      distinctBySocialPasswords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'socialPasswords');
    });
  }
}

extension CategorySchemaQueryProperty
    on QueryBuilder<CategorySchema, CategorySchema, QQueryProperty> {
  QueryBuilder<CategorySchema, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CategorySchema, int, QQueryOperations>
      browserPasswordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'browserPasswords');
    });
  }

  QueryBuilder<CategorySchema, int, QQueryOperations>
      miscellaneousPasswordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'miscellaneousPasswords');
    });
  }

  QueryBuilder<CategorySchema, int, QQueryOperations>
      paymentPasswordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentPasswords');
    });
  }

  QueryBuilder<CategorySchema, int, QQueryOperations>
      socialPasswordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'socialPasswords');
    });
  }
}
