// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProblemIsarCollection on Isar {
  IsarCollection<ProblemIsar> get problemIsars => this.collection();
}

const ProblemIsarSchema = CollectionSchema(
  name: r'ProblemIsar',
  id: 8643536733184656094,
  properties: {
    r'approaches': PropertySchema(
      id: 0,
      name: r'approaches',
      type: IsarType.objectList,

      target: r'ApproachIsar',
    ),
    r'categoryId': PropertySchema(
      id: 1,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'categoryName': PropertySchema(
      id: 2,
      name: r'categoryName',
      type: IsarType.string,
    ),
    r'comparisonTable': PropertySchema(
      id: 3,
      name: r'comparisonTable',
      type: IsarType.object,

      target: r'ComparisonTableIsar',
    ),
    r'content': PropertySchema(
      id: 4,
      name: r'content',
      type: IsarType.object,

      target: r'ContentIsar',
    ),
    r'difficulty': PropertySchema(
      id: 5,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'estimatedMinutes': PropertySchema(
      id: 6,
      name: r'estimatedMinutes',
      type: IsarType.long,
    ),
    r'isBlind75': PropertySchema(
      id: 7,
      name: r'isBlind75',
      type: IsarType.bool,
    ),
    r'isNeetcode150': PropertySchema(
      id: 8,
      name: r'isNeetcode150',
      type: IsarType.bool,
    ),
    r'isPremium': PropertySchema(
      id: 9,
      name: r'isPremium',
      type: IsarType.bool,
    ),
    r'testCases': PropertySchema(
      id: 10,
      name: r'testCases',
      type: IsarType.objectList,

      target: r'TestCaseIsar',
    ),
    r'title': PropertySchema(id: 11, name: r'title', type: IsarType.string),
  },

  estimateSize: _problemIsarEstimateSize,
  serialize: _problemIsarSerialize,
  deserialize: _problemIsarDeserialize,
  deserializeProp: _problemIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'ContentIsar': ContentIsarSchema,
    r'ConstraintIsar': ConstraintIsarSchema,
    r'TestCaseIsar': TestCaseIsarSchema,
    r'ApproachIsar': ApproachIsarSchema,
    r'ImplementationIsar': ImplementationIsarSchema,
    r'ComparisonTableIsar': ComparisonTableIsarSchema,
    r'ComparisonRowIsar': ComparisonRowIsarSchema,
  },

  getId: _problemIsarGetId,
  getLinks: _problemIsarGetLinks,
  attach: _problemIsarAttach,
  version: '3.3.0-dev.3',
);

int _problemIsarEstimateSize(
  ProblemIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.approaches.length * 3;
  {
    final offsets = allOffsets[ApproachIsar]!;
    for (var i = 0; i < object.approaches.length; i++) {
      final value = object.approaches[i];
      bytesCount += ApproachIsarSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.categoryName.length * 3;
  {
    final value = object.comparisonTable;
    if (value != null) {
      bytesCount +=
          3 +
          ComparisonTableIsarSchema.estimateSize(
            value,
            allOffsets[ComparisonTableIsar]!,
            allOffsets,
          );
    }
  }
  {
    final value = object.content;
    if (value != null) {
      bytesCount +=
          3 +
          ContentIsarSchema.estimateSize(
            value,
            allOffsets[ContentIsar]!,
            allOffsets,
          );
    }
  }
  bytesCount += 3 + object.difficulty.length * 3;
  bytesCount += 3 + object.testCases.length * 3;
  {
    final offsets = allOffsets[TestCaseIsar]!;
    for (var i = 0; i < object.testCases.length; i++) {
      final value = object.testCases[i];
      bytesCount += TestCaseIsarSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _problemIsarSerialize(
  ProblemIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ApproachIsar>(
    offsets[0],
    allOffsets,
    ApproachIsarSchema.serialize,
    object.approaches,
  );
  writer.writeLong(offsets[1], object.categoryId);
  writer.writeString(offsets[2], object.categoryName);
  writer.writeObject<ComparisonTableIsar>(
    offsets[3],
    allOffsets,
    ComparisonTableIsarSchema.serialize,
    object.comparisonTable,
  );
  writer.writeObject<ContentIsar>(
    offsets[4],
    allOffsets,
    ContentIsarSchema.serialize,
    object.content,
  );
  writer.writeString(offsets[5], object.difficulty);
  writer.writeLong(offsets[6], object.estimatedMinutes);
  writer.writeBool(offsets[7], object.isBlind75);
  writer.writeBool(offsets[8], object.isNeetcode150);
  writer.writeBool(offsets[9], object.isPremium);
  writer.writeObjectList<TestCaseIsar>(
    offsets[10],
    allOffsets,
    TestCaseIsarSchema.serialize,
    object.testCases,
  );
  writer.writeString(offsets[11], object.title);
}

ProblemIsar _problemIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProblemIsar(
    approaches:
        reader.readObjectList<ApproachIsar>(
          offsets[0],
          ApproachIsarSchema.deserialize,
          allOffsets,
          ApproachIsar(),
        ) ??
        const [],
    categoryId: reader.readLong(offsets[1]),
    categoryName: reader.readStringOrNull(offsets[2]) ?? '',
    comparisonTable: reader.readObjectOrNull<ComparisonTableIsar>(
      offsets[3],
      ComparisonTableIsarSchema.deserialize,
      allOffsets,
    ),
    content: reader.readObjectOrNull<ContentIsar>(
      offsets[4],
      ContentIsarSchema.deserialize,
      allOffsets,
    ),
    difficulty: reader.readString(offsets[5]),
    estimatedMinutes: reader.readLongOrNull(offsets[6]) ?? 15,
    id: id,
    isBlind75: reader.readBoolOrNull(offsets[7]) ?? false,
    isNeetcode150: reader.readBoolOrNull(offsets[8]) ?? false,
    isPremium: reader.readBoolOrNull(offsets[9]) ?? false,
    testCases:
        reader.readObjectList<TestCaseIsar>(
          offsets[10],
          TestCaseIsarSchema.deserialize,
          allOffsets,
          TestCaseIsar(),
        ) ??
        const [],
    title: reader.readString(offsets[11]),
  );
  return object;
}

P _problemIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ApproachIsar>(
                offset,
                ApproachIsarSchema.deserialize,
                allOffsets,
                ApproachIsar(),
              ) ??
              const [])
          as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readObjectOrNull<ComparisonTableIsar>(
            offset,
            ComparisonTableIsarSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 4:
      return (reader.readObjectOrNull<ContentIsar>(
            offset,
            ContentIsarSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 15) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 10:
      return (reader.readObjectList<TestCaseIsar>(
                offset,
                TestCaseIsarSchema.deserialize,
                allOffsets,
                TestCaseIsar(),
              ) ??
              const [])
          as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _problemIsarGetId(ProblemIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _problemIsarGetLinks(ProblemIsar object) {
  return [];
}

void _problemIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  ProblemIsar object,
) {
  object.id = id;
}

extension ProblemIsarQueryWhereSort
    on QueryBuilder<ProblemIsar, ProblemIsar, QWhere> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProblemIsarQueryWhere
    on QueryBuilder<ProblemIsar, ProblemIsar, QWhereClause> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ProblemIsarQueryFilter
    on QueryBuilder<ProblemIsar, ProblemIsar, QFilterCondition> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'approaches', length, true, length, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'approaches', 0, true, 0, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'approaches', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'approaches', 0, true, length, include);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'approaches', length, include, 999999, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'approaches',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryId', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'categoryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'categoryName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryName', value: ''),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  categoryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'categoryName', value: ''),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  comparisonTableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comparisonTable'),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  comparisonTableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comparisonTable'),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'content'),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'content'),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'difficulty',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'difficulty',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  estimatedMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estimatedMinutes', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  estimatedMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estimatedMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  estimatedMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estimatedMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  estimatedMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estimatedMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  isBlind75EqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isBlind75', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  isNeetcode150EqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isNeetcode150', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  isPremiumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPremium', value: value),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'testCases', length, true, length, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'testCases', 0, true, 0, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'testCases', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'testCases', 0, true, length, include);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'testCases', length, include, 999999, true);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testCases',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension ProblemIsarQueryObject
    on QueryBuilder<ProblemIsar, ProblemIsar, QFilterCondition> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  approachesElement(FilterQuery<ApproachIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'approaches');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> comparisonTable(
    FilterQuery<ComparisonTableIsar> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'comparisonTable');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition> content(
    FilterQuery<ContentIsar> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'content');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterFilterCondition>
  testCasesElement(FilterQuery<TestCaseIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'testCases');
    });
  }
}

extension ProblemIsarQueryLinks
    on QueryBuilder<ProblemIsar, ProblemIsar, QFilterCondition> {}

extension ProblemIsarQuerySortBy
    on QueryBuilder<ProblemIsar, ProblemIsar, QSortBy> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  sortByCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  sortByEstimatedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMinutes', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  sortByEstimatedMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMinutes', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByIsBlind75() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlind75', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByIsBlind75Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlind75', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByIsNeetcode150() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNeetcode150', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  sortByIsNeetcode150Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNeetcode150', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ProblemIsarQuerySortThenBy
    on QueryBuilder<ProblemIsar, ProblemIsar, QSortThenBy> {
  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  thenByCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  thenByEstimatedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMinutes', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  thenByEstimatedMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMinutes', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIsBlind75() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlind75', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIsBlind75Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlind75', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIsNeetcode150() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNeetcode150', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy>
  thenByIsNeetcode150Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNeetcode150', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ProblemIsarQueryWhereDistinct
    on QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> {
  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByCategoryName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByDifficulty({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct>
  distinctByEstimatedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedMinutes');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByIsBlind75() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlind75');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByIsNeetcode150() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isNeetcode150');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPremium');
    });
  }

  QueryBuilder<ProblemIsar, ProblemIsar, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension ProblemIsarQueryProperty
    on QueryBuilder<ProblemIsar, ProblemIsar, QQueryProperty> {
  QueryBuilder<ProblemIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProblemIsar, List<ApproachIsar>, QQueryOperations>
  approachesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approaches');
    });
  }

  QueryBuilder<ProblemIsar, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<ProblemIsar, String, QQueryOperations> categoryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryName');
    });
  }

  QueryBuilder<ProblemIsar, ComparisonTableIsar?, QQueryOperations>
  comparisonTableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comparisonTable');
    });
  }

  QueryBuilder<ProblemIsar, ContentIsar?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<ProblemIsar, String, QQueryOperations> difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<ProblemIsar, int, QQueryOperations> estimatedMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedMinutes');
    });
  }

  QueryBuilder<ProblemIsar, bool, QQueryOperations> isBlind75Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlind75');
    });
  }

  QueryBuilder<ProblemIsar, bool, QQueryOperations> isNeetcode150Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isNeetcode150');
    });
  }

  QueryBuilder<ProblemIsar, bool, QQueryOperations> isPremiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPremium');
    });
  }

  QueryBuilder<ProblemIsar, List<TestCaseIsar>, QQueryOperations>
  testCasesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'testCases');
    });
  }

  QueryBuilder<ProblemIsar, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizPatternMapIsarCollection on Isar {
  IsarCollection<QuizPatternMapIsar> get quizPatternMapIsars =>
      this.collection();
}

const QuizPatternMapIsarSchema = CollectionSchema(
  name: r'QuizPatternMapIsar',
  id: -1738846374015900737,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'difficulty': PropertySchema(
      id: 1,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'isPremium': PropertySchema(
      id: 2,
      name: r'isPremium',
      type: IsarType.bool,
    ),
    r'optimalApproachKey': PropertySchema(
      id: 3,
      name: r'optimalApproachKey',
      type: IsarType.string,
    ),
    r'optimalApproachName': PropertySchema(
      id: 4,
      name: r'optimalApproachName',
      type: IsarType.string,
    ),
    r'optimalCodingPattern': PropertySchema(
      id: 5,
      name: r'optimalCodingPattern',
      type: IsarType.string,
    ),
    r'problemId': PropertySchema(
      id: 6,
      name: r'problemId',
      type: IsarType.long,
    ),
  },

  estimateSize: _quizPatternMapIsarEstimateSize,
  serialize: _quizPatternMapIsarSerialize,
  deserialize: _quizPatternMapIsarDeserialize,
  deserializeProp: _quizPatternMapIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _quizPatternMapIsarGetId,
  getLinks: _quizPatternMapIsarGetLinks,
  attach: _quizPatternMapIsarAttach,
  version: '3.3.0-dev.3',
);

int _quizPatternMapIsarEstimateSize(
  QuizPatternMapIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.difficulty.length * 3;
  bytesCount += 3 + object.optimalApproachKey.length * 3;
  bytesCount += 3 + object.optimalApproachName.length * 3;
  {
    final value = object.optimalCodingPattern;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _quizPatternMapIsarSerialize(
  QuizPatternMapIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.categoryId);
  writer.writeString(offsets[1], object.difficulty);
  writer.writeBool(offsets[2], object.isPremium);
  writer.writeString(offsets[3], object.optimalApproachKey);
  writer.writeString(offsets[4], object.optimalApproachName);
  writer.writeString(offsets[5], object.optimalCodingPattern);
  writer.writeLong(offsets[6], object.problemId);
}

QuizPatternMapIsar _quizPatternMapIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizPatternMapIsar(
    categoryId: reader.readLong(offsets[0]),
    difficulty: reader.readString(offsets[1]),
    id: id,
    isPremium: reader.readBool(offsets[2]),
    optimalApproachKey: reader.readString(offsets[3]),
    optimalApproachName: reader.readString(offsets[4]),
    optimalCodingPattern: reader.readStringOrNull(offsets[5]),
    problemId: reader.readLong(offsets[6]),
  );
  return object;
}

P _quizPatternMapIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizPatternMapIsarGetId(QuizPatternMapIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizPatternMapIsarGetLinks(
  QuizPatternMapIsar object,
) {
  return [];
}

void _quizPatternMapIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  QuizPatternMapIsar object,
) {
  object.id = id;
}

extension QuizPatternMapIsarQueryWhereSort
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QWhere> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuizPatternMapIsarQueryWhere
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QWhereClause> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizPatternMapIsarQueryFilter
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QFilterCondition> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  categoryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryId', value: value),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  categoryIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  categoryIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'difficulty',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'difficulty',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  isPremiumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPremium', value: value),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'optimalApproachKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'optimalApproachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'optimalApproachKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'optimalApproachKey', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'optimalApproachKey', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'optimalApproachName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'optimalApproachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'optimalApproachName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'optimalApproachName', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalApproachNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'optimalApproachName',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'optimalCodingPattern'),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'optimalCodingPattern'),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'optimalCodingPattern',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'optimalCodingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'optimalCodingPattern',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'optimalCodingPattern', value: ''),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  optimalCodingPatternIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'optimalCodingPattern',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  problemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problemId', value: value),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  problemIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  problemIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterFilterCondition>
  problemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizPatternMapIsarQueryObject
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QFilterCondition> {}

extension QuizPatternMapIsarQueryLinks
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QFilterCondition> {}

extension QuizPatternMapIsarQuerySortBy
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QSortBy> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachKey', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachKey', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalApproachName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachName', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalApproachNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachName', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalCodingPattern() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalCodingPattern', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByOptimalCodingPatternDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalCodingPattern', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  sortByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }
}

extension QuizPatternMapIsarQuerySortThenBy
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QSortThenBy> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachKey', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachKey', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalApproachName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachName', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalApproachNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalApproachName', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalCodingPattern() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalCodingPattern', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByOptimalCodingPatternDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optimalCodingPattern', Sort.desc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QAfterSortBy>
  thenByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }
}

extension QuizPatternMapIsarQueryWhereDistinct
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct> {
  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByDifficulty({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPremium');
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByOptimalApproachKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'optimalApproachKey',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByOptimalApproachName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'optimalApproachName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByOptimalCodingPattern({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'optimalCodingPattern',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QDistinct>
  distinctByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemId');
    });
  }
}

extension QuizPatternMapIsarQueryProperty
    on QueryBuilder<QuizPatternMapIsar, QuizPatternMapIsar, QQueryProperty> {
  QueryBuilder<QuizPatternMapIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizPatternMapIsar, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<QuizPatternMapIsar, String, QQueryOperations>
  difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<QuizPatternMapIsar, bool, QQueryOperations> isPremiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPremium');
    });
  }

  QueryBuilder<QuizPatternMapIsar, String, QQueryOperations>
  optimalApproachKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optimalApproachKey');
    });
  }

  QueryBuilder<QuizPatternMapIsar, String, QQueryOperations>
  optimalApproachNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optimalApproachName');
    });
  }

  QueryBuilder<QuizPatternMapIsar, String?, QQueryOperations>
  optimalCodingPatternProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optimalCodingPattern');
    });
  }

  QueryBuilder<QuizPatternMapIsar, int, QQueryOperations> problemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizApproachIdentifierIsarCollection on Isar {
  IsarCollection<QuizApproachIdentifierIsar> get quizApproachIdentifierIsars =>
      this.collection();
}

const QuizApproachIdentifierIsarSchema = CollectionSchema(
  name: r'QuizApproachIdentifierIsar',
  id: -4422993798636241577,
  properties: {
    r'approachKey': PropertySchema(
      id: 0,
      name: r'approachKey',
      type: IsarType.string,
    ),
    r'approachName': PropertySchema(
      id: 1,
      name: r'approachName',
      type: IsarType.string,
    ),
    r'codeSnippetShort': PropertySchema(
      id: 2,
      name: r'codeSnippetShort',
      type: IsarType.string,
    ),
    r'language': PropertySchema(
      id: 3,
      name: r'language',
      type: IsarType.string,
    ),
    r'problemId': PropertySchema(
      id: 4,
      name: r'problemId',
      type: IsarType.long,
    ),
  },

  estimateSize: _quizApproachIdentifierIsarEstimateSize,
  serialize: _quizApproachIdentifierIsarSerialize,
  deserialize: _quizApproachIdentifierIsarDeserialize,
  deserializeProp: _quizApproachIdentifierIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _quizApproachIdentifierIsarGetId,
  getLinks: _quizApproachIdentifierIsarGetLinks,
  attach: _quizApproachIdentifierIsarAttach,
  version: '3.3.0-dev.3',
);

int _quizApproachIdentifierIsarEstimateSize(
  QuizApproachIdentifierIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.approachKey.length * 3;
  bytesCount += 3 + object.approachName.length * 3;
  bytesCount += 3 + object.codeSnippetShort.length * 3;
  bytesCount += 3 + object.language.length * 3;
  return bytesCount;
}

void _quizApproachIdentifierIsarSerialize(
  QuizApproachIdentifierIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.approachKey);
  writer.writeString(offsets[1], object.approachName);
  writer.writeString(offsets[2], object.codeSnippetShort);
  writer.writeString(offsets[3], object.language);
  writer.writeLong(offsets[4], object.problemId);
}

QuizApproachIdentifierIsar _quizApproachIdentifierIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizApproachIdentifierIsar(
    approachKey: reader.readString(offsets[0]),
    approachName: reader.readString(offsets[1]),
    codeSnippetShort: reader.readString(offsets[2]),
    id: id,
    language: reader.readString(offsets[3]),
    problemId: reader.readLong(offsets[4]),
  );
  return object;
}

P _quizApproachIdentifierIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizApproachIdentifierIsarGetId(QuizApproachIdentifierIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizApproachIdentifierIsarGetLinks(
  QuizApproachIdentifierIsar object,
) {
  return [];
}

void _quizApproachIdentifierIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  QuizApproachIdentifierIsar object,
) {
  object.id = id;
}

extension QuizApproachIdentifierIsarQueryWhereSort
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QWhere
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuizApproachIdentifierIsarQueryWhere
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QWhereClause
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
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

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizApproachIdentifierIsarQueryFilter
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QFilterCondition
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'approachKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'approachKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'approachKey', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'approachKey', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'approachName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'approachName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'approachName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'approachName', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  approachNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'approachName', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'codeSnippetShort',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'codeSnippetShort',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'codeSnippetShort',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'codeSnippetShort', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  codeSnippetShortIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'codeSnippetShort', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'language',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'language',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  problemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problemId', value: value),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  problemIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  problemIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterFilterCondition
  >
  problemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizApproachIdentifierIsarQueryObject
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QFilterCondition
        > {}

extension QuizApproachIdentifierIsarQueryLinks
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QFilterCondition
        > {}

extension QuizApproachIdentifierIsarQuerySortBy
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QSortBy
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByApproachName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachName', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByApproachNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachName', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByCodeSnippetShort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeSnippetShort', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByCodeSnippetShortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeSnippetShort', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  sortByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }
}

extension QuizApproachIdentifierIsarQuerySortThenBy
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QSortThenBy
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByApproachName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachName', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByApproachNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachName', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByCodeSnippetShort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeSnippetShort', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByCodeSnippetShortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeSnippetShort', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QAfterSortBy
  >
  thenByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }
}

extension QuizApproachIdentifierIsarQueryWhereDistinct
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QDistinct
        > {
  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QDistinct
  >
  distinctByApproachKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approachKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QDistinct
  >
  distinctByApproachName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approachName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QDistinct
  >
  distinctByCodeSnippetShort({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'codeSnippetShort',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QDistinct
  >
  distinctByLanguage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    QuizApproachIdentifierIsar,
    QuizApproachIdentifierIsar,
    QDistinct
  >
  distinctByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemId');
    });
  }
}

extension QuizApproachIdentifierIsarQueryProperty
    on
        QueryBuilder<
          QuizApproachIdentifierIsar,
          QuizApproachIdentifierIsar,
          QQueryProperty
        > {
  QueryBuilder<QuizApproachIdentifierIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizApproachIdentifierIsar, String, QQueryOperations>
  approachKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approachKey');
    });
  }

  QueryBuilder<QuizApproachIdentifierIsar, String, QQueryOperations>
  approachNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approachName');
    });
  }

  QueryBuilder<QuizApproachIdentifierIsar, String, QQueryOperations>
  codeSnippetShortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeSnippetShort');
    });
  }

  QueryBuilder<QuizApproachIdentifierIsar, String, QQueryOperations>
  languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<QuizApproachIdentifierIsar, int, QQueryOperations>
  problemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizComplexityFactsIsarCollection on Isar {
  IsarCollection<QuizComplexityFactsIsar> get quizComplexityFactsIsars =>
      this.collection();
}

const QuizComplexityFactsIsarSchema = CollectionSchema(
  name: r'QuizComplexityFactsIsar',
  id: -5620009745041459084,
  properties: {
    r'approachKey': PropertySchema(
      id: 0,
      name: r'approachKey',
      type: IsarType.string,
    ),
    r'problemId': PropertySchema(
      id: 1,
      name: r'problemId',
      type: IsarType.long,
    ),
    r'spaceComplexity': PropertySchema(
      id: 2,
      name: r'spaceComplexity',
      type: IsarType.string,
    ),
    r'spaceExplanationForQuiz': PropertySchema(
      id: 3,
      name: r'spaceExplanationForQuiz',
      type: IsarType.string,
    ),
    r'timeComplexity': PropertySchema(
      id: 4,
      name: r'timeComplexity',
      type: IsarType.string,
    ),
    r'timeExplanationForQuiz': PropertySchema(
      id: 5,
      name: r'timeExplanationForQuiz',
      type: IsarType.string,
    ),
  },

  estimateSize: _quizComplexityFactsIsarEstimateSize,
  serialize: _quizComplexityFactsIsarSerialize,
  deserialize: _quizComplexityFactsIsarDeserialize,
  deserializeProp: _quizComplexityFactsIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _quizComplexityFactsIsarGetId,
  getLinks: _quizComplexityFactsIsarGetLinks,
  attach: _quizComplexityFactsIsarAttach,
  version: '3.3.0-dev.3',
);

int _quizComplexityFactsIsarEstimateSize(
  QuizComplexityFactsIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.approachKey.length * 3;
  bytesCount += 3 + object.spaceComplexity.length * 3;
  {
    final value = object.spaceExplanationForQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.timeComplexity.length * 3;
  {
    final value = object.timeExplanationForQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _quizComplexityFactsIsarSerialize(
  QuizComplexityFactsIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.approachKey);
  writer.writeLong(offsets[1], object.problemId);
  writer.writeString(offsets[2], object.spaceComplexity);
  writer.writeString(offsets[3], object.spaceExplanationForQuiz);
  writer.writeString(offsets[4], object.timeComplexity);
  writer.writeString(offsets[5], object.timeExplanationForQuiz);
}

QuizComplexityFactsIsar _quizComplexityFactsIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizComplexityFactsIsar(
    approachKey: reader.readString(offsets[0]),
    id: id,
    problemId: reader.readLong(offsets[1]),
    spaceComplexity: reader.readString(offsets[2]),
    spaceExplanationForQuiz: reader.readStringOrNull(offsets[3]),
    timeComplexity: reader.readString(offsets[4]),
    timeExplanationForQuiz: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _quizComplexityFactsIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizComplexityFactsIsarGetId(QuizComplexityFactsIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizComplexityFactsIsarGetLinks(
  QuizComplexityFactsIsar object,
) {
  return [];
}

void _quizComplexityFactsIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  QuizComplexityFactsIsar object,
) {
  object.id = id;
}

extension QuizComplexityFactsIsarQueryWhereSort
    on QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QWhere> {
  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuizComplexityFactsIsarQueryWhere
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QWhereClause
        > {
  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
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

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizComplexityFactsIsarQueryFilter
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QFilterCondition
        > {
  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'approachKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'approachKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'approachKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'approachKey', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  approachKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'approachKey', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  problemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problemId', value: value),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  problemIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  problemIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  problemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spaceComplexity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spaceComplexity',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spaceComplexity', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceComplexityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'spaceComplexity', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spaceExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spaceExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spaceExplanationForQuiz',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spaceExplanationForQuiz',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceExplanationForQuiz',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  spaceExplanationForQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'spaceExplanationForQuiz',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeComplexity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeComplexity',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeComplexity', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeComplexityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timeComplexity', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeExplanationForQuiz',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeExplanationForQuiz',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeExplanationForQuiz', value: ''),
      );
    });
  }

  QueryBuilder<
    QuizComplexityFactsIsar,
    QuizComplexityFactsIsar,
    QAfterFilterCondition
  >
  timeExplanationForQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'timeExplanationForQuiz',
          value: '',
        ),
      );
    });
  }
}

extension QuizComplexityFactsIsarQueryObject
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QFilterCondition
        > {}

extension QuizComplexityFactsIsarQueryLinks
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QFilterCondition
        > {}

extension QuizComplexityFactsIsarQuerySortBy
    on QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QSortBy> {
  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortBySpaceComplexity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceComplexity', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortBySpaceComplexityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceComplexity', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortBySpaceExplanationForQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceExplanationForQuiz', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortBySpaceExplanationForQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceExplanationForQuiz', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByTimeComplexity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeComplexity', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByTimeComplexityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeComplexity', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByTimeExplanationForQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeExplanationForQuiz', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  sortByTimeExplanationForQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeExplanationForQuiz', Sort.desc);
    });
  }
}

extension QuizComplexityFactsIsarQuerySortThenBy
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QSortThenBy
        > {
  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByApproachKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByApproachKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approachKey', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByProblemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemId', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenBySpaceComplexity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceComplexity', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenBySpaceComplexityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceComplexity', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenBySpaceExplanationForQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceExplanationForQuiz', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenBySpaceExplanationForQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spaceExplanationForQuiz', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByTimeComplexity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeComplexity', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByTimeComplexityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeComplexity', Sort.desc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByTimeExplanationForQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeExplanationForQuiz', Sort.asc);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QAfterSortBy>
  thenByTimeExplanationForQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeExplanationForQuiz', Sort.desc);
    });
  }
}

extension QuizComplexityFactsIsarQueryWhereDistinct
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QDistinct
        > {
  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctByApproachKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approachKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctByProblemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemId');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctBySpaceComplexity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'spaceComplexity',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctBySpaceExplanationForQuiz({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'spaceExplanationForQuiz',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctByTimeComplexity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'timeComplexity',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, QuizComplexityFactsIsar, QDistinct>
  distinctByTimeExplanationForQuiz({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'timeExplanationForQuiz',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension QuizComplexityFactsIsarQueryProperty
    on
        QueryBuilder<
          QuizComplexityFactsIsar,
          QuizComplexityFactsIsar,
          QQueryProperty
        > {
  QueryBuilder<QuizComplexityFactsIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, String, QQueryOperations>
  approachKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approachKey');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, int, QQueryOperations>
  problemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemId');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, String, QQueryOperations>
  spaceComplexityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spaceComplexity');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, String?, QQueryOperations>
  spaceExplanationForQuizProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spaceExplanationForQuiz');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, String, QQueryOperations>
  timeComplexityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeComplexity');
    });
  }

  QueryBuilder<QuizComplexityFactsIsar, String?, QQueryOperations>
  timeExplanationForQuizProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeExplanationForQuiz');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ContentIsarSchema = Schema(
  name: r'ContentIsar',
  id: -5742675028862527347,
  properties: {
    r'constraints': PropertySchema(
      id: 0,
      name: r'constraints',
      type: IsarType.objectList,

      target: r'ConstraintIsar',
    ),
    r'inputFormat': PropertySchema(
      id: 1,
      name: r'inputFormat',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 2, name: r'notes', type: IsarType.stringList),
    r'outputFormat': PropertySchema(
      id: 3,
      name: r'outputFormat',
      type: IsarType.string,
    ),
    r'statement': PropertySchema(
      id: 4,
      name: r'statement',
      type: IsarType.string,
    ),
  },

  estimateSize: _contentIsarEstimateSize,
  serialize: _contentIsarSerialize,
  deserialize: _contentIsarDeserialize,
  deserializeProp: _contentIsarDeserializeProp,
);

int _contentIsarEstimateSize(
  ContentIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.constraints.length * 3;
  {
    final offsets = allOffsets[ConstraintIsar]!;
    for (var i = 0; i < object.constraints.length; i++) {
      final value = object.constraints[i];
      bytesCount += ConstraintIsarSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.inputFormat.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  {
    for (var i = 0; i < object.notes.length; i++) {
      final value = object.notes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.outputFormat.length * 3;
  bytesCount += 3 + object.statement.length * 3;
  return bytesCount;
}

void _contentIsarSerialize(
  ContentIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ConstraintIsar>(
    offsets[0],
    allOffsets,
    ConstraintIsarSchema.serialize,
    object.constraints,
  );
  writer.writeString(offsets[1], object.inputFormat);
  writer.writeStringList(offsets[2], object.notes);
  writer.writeString(offsets[3], object.outputFormat);
  writer.writeString(offsets[4], object.statement);
}

ContentIsar _contentIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContentIsar(
    constraints:
        reader.readObjectList<ConstraintIsar>(
          offsets[0],
          ConstraintIsarSchema.deserialize,
          allOffsets,
          ConstraintIsar(),
        ) ??
        const [],
    inputFormat: reader.readStringOrNull(offsets[1]) ?? '',
    notes: reader.readStringList(offsets[2]) ?? const [],
    outputFormat: reader.readStringOrNull(offsets[3]) ?? '',
    statement: reader.readStringOrNull(offsets[4]) ?? '',
  );
  return object;
}

P _contentIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ConstraintIsar>(
                offset,
                ConstraintIsarSchema.deserialize,
                allOffsets,
                ConstraintIsar(),
              ) ??
              const [])
          as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ContentIsarQueryFilter
    on QueryBuilder<ContentIsar, ContentIsar, QFilterCondition> {
  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'constraints', length, true, length, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'constraints', 0, true, 0, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'constraints', 0, false, 999999, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'constraints', 0, true, length, include);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'constraints', length, include, 999999, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'constraints',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'inputFormat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'inputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'inputFormat',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'inputFormat', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  inputFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'inputFormat', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notes', length, true, length, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notes', 0, true, 0, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notes', 0, false, 999999, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notes', 0, true, length, include);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notes', length, include, 999999, true);
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  notesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'outputFormat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'outputFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'outputFormat',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'outputFormat', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  outputFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'outputFormat', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'statement',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'statement',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'statement',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'statement', value: ''),
      );
    });
  }

  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  statementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'statement', value: ''),
      );
    });
  }
}

extension ContentIsarQueryObject
    on QueryBuilder<ContentIsar, ContentIsar, QFilterCondition> {
  QueryBuilder<ContentIsar, ContentIsar, QAfterFilterCondition>
  constraintsElement(FilterQuery<ConstraintIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'constraints');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ConstraintIsarSchema = Schema(
  name: r'ConstraintIsar',
  id: 5563536924822260265,
  properties: {
    r'explanation': PropertySchema(
      id: 0,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
    r'value': PropertySchema(id: 2, name: r'value', type: IsarType.string),
  },

  estimateSize: _constraintIsarEstimateSize,
  serialize: _constraintIsarSerialize,
  deserialize: _constraintIsarDeserialize,
  deserializeProp: _constraintIsarDeserializeProp,
);

int _constraintIsarEstimateSize(
  ConstraintIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.explanation.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _constraintIsarSerialize(
  ConstraintIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.explanation);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.value);
}

ConstraintIsar _constraintIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConstraintIsar(
    explanation: reader.readStringOrNull(offsets[0]) ?? '',
    name: reader.readStringOrNull(offsets[1]) ?? '',
    value: reader.readStringOrNull(offsets[2]) ?? '',
  );
  return object;
}

P _constraintIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ConstraintIsarQueryFilter
    on QueryBuilder<ConstraintIsar, ConstraintIsar, QFilterCondition> {
  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'explanation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'explanation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'value',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'value',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'value', value: ''),
      );
    });
  }

  QueryBuilder<ConstraintIsar, ConstraintIsar, QAfterFilterCondition>
  valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'value', value: ''),
      );
    });
  }
}

extension ConstraintIsarQueryObject
    on QueryBuilder<ConstraintIsar, ConstraintIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TestCaseIsarSchema = Schema(
  name: r'TestCaseIsar',
  id: -1949334182442051103,
  properties: {
    r'explanation': PropertySchema(
      id: 0,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'inputJson': PropertySchema(
      id: 1,
      name: r'inputJson',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'output': PropertySchema(id: 3, name: r'output', type: IsarType.string),
  },

  estimateSize: _testCaseIsarEstimateSize,
  serialize: _testCaseIsarSerialize,
  deserialize: _testCaseIsarDeserialize,
  deserializeProp: _testCaseIsarDeserializeProp,
);

int _testCaseIsarEstimateSize(
  TestCaseIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.explanation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inputJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.output.length * 3;
  return bytesCount;
}

void _testCaseIsarSerialize(
  TestCaseIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.explanation);
  writer.writeString(offsets[1], object.inputJson);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.output);
}

TestCaseIsar _testCaseIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestCaseIsar(
    explanation: reader.readStringOrNull(offsets[0]),
    inputJson: reader.readStringOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]) ?? '',
    output: reader.readStringOrNull(offsets[3]) ?? '',
  );
  return object;
}

P _testCaseIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TestCaseIsarQueryFilter
    on QueryBuilder<TestCaseIsar, TestCaseIsar, QFilterCondition> {
  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'explanation'),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'explanation'),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'explanation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'explanation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'inputJson'),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'inputJson'),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'inputJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'inputJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'inputJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'inputJson', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  inputJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'inputJson', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> outputEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> outputBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'output',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'output',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition> outputMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'output',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'output', value: ''),
      );
    });
  }

  QueryBuilder<TestCaseIsar, TestCaseIsar, QAfterFilterCondition>
  outputIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'output', value: ''),
      );
    });
  }
}

extension TestCaseIsarQueryObject
    on QueryBuilder<TestCaseIsar, TestCaseIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ApproachIsarSchema = Schema(
  name: r'ApproachIsar',
  id: -444794557540444736,
  properties: {
    r'codingPattern': PropertySchema(
      id: 0,
      name: r'codingPattern',
      type: IsarType.string,
    ),
    r'cons': PropertySchema(id: 1, name: r'cons', type: IsarType.stringList),
    r'explanation': PropertySchema(
      id: 2,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'implementations': PropertySchema(
      id: 3,
      name: r'implementations',
      type: IsarType.objectList,

      target: r'ImplementationIsar',
    ),
    r'key': PropertySchema(id: 4, name: r'key', type: IsarType.string),
    r'name': PropertySchema(id: 5, name: r'name', type: IsarType.string),
    r'pros': PropertySchema(id: 6, name: r'pros', type: IsarType.stringList),
    r'spaceComplexity': PropertySchema(
      id: 7,
      name: r'spaceComplexity',
      type: IsarType.string,
    ),
    r'spaceExplanation': PropertySchema(
      id: 8,
      name: r'spaceExplanation',
      type: IsarType.string,
    ),
    r'spaceExplanationForQuiz': PropertySchema(
      id: 9,
      name: r'spaceExplanationForQuiz',
      type: IsarType.string,
    ),
    r'timeComplexity': PropertySchema(
      id: 10,
      name: r'timeComplexity',
      type: IsarType.string,
    ),
    r'timeExplanation': PropertySchema(
      id: 11,
      name: r'timeExplanation',
      type: IsarType.string,
    ),
    r'timeExplanationForQuiz': PropertySchema(
      id: 12,
      name: r'timeExplanationForQuiz',
      type: IsarType.string,
    ),
    r'trickDetails': PropertySchema(
      id: 13,
      name: r'trickDetails',
      type: IsarType.stringList,
    ),
    r'trickSummary': PropertySchema(
      id: 14,
      name: r'trickSummary',
      type: IsarType.string,
    ),
  },

  estimateSize: _approachIsarEstimateSize,
  serialize: _approachIsarSerialize,
  deserialize: _approachIsarDeserialize,
  deserializeProp: _approachIsarDeserializeProp,
);

int _approachIsarEstimateSize(
  ApproachIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.codingPattern;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.cons.length * 3;
  {
    for (var i = 0; i < object.cons.length; i++) {
      final value = object.cons[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.explanation.length * 3;
  bytesCount += 3 + object.implementations.length * 3;
  {
    final offsets = allOffsets[ImplementationIsar]!;
    for (var i = 0; i < object.implementations.length; i++) {
      final value = object.implementations[i];
      bytesCount += ImplementationIsarSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pros.length * 3;
  {
    for (var i = 0; i < object.pros.length; i++) {
      final value = object.pros[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.spaceComplexity.length * 3;
  {
    final value = object.spaceExplanation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spaceExplanationForQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.timeComplexity.length * 3;
  {
    final value = object.timeExplanation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.timeExplanationForQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.trickDetails.length * 3;
  {
    for (var i = 0; i < object.trickDetails.length; i++) {
      final value = object.trickDetails[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.trickSummary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _approachIsarSerialize(
  ApproachIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.codingPattern);
  writer.writeStringList(offsets[1], object.cons);
  writer.writeString(offsets[2], object.explanation);
  writer.writeObjectList<ImplementationIsar>(
    offsets[3],
    allOffsets,
    ImplementationIsarSchema.serialize,
    object.implementations,
  );
  writer.writeString(offsets[4], object.key);
  writer.writeString(offsets[5], object.name);
  writer.writeStringList(offsets[6], object.pros);
  writer.writeString(offsets[7], object.spaceComplexity);
  writer.writeString(offsets[8], object.spaceExplanation);
  writer.writeString(offsets[9], object.spaceExplanationForQuiz);
  writer.writeString(offsets[10], object.timeComplexity);
  writer.writeString(offsets[11], object.timeExplanation);
  writer.writeString(offsets[12], object.timeExplanationForQuiz);
  writer.writeStringList(offsets[13], object.trickDetails);
  writer.writeString(offsets[14], object.trickSummary);
}

ApproachIsar _approachIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ApproachIsar(
    codingPattern: reader.readStringOrNull(offsets[0]),
    cons: reader.readStringList(offsets[1]) ?? const [],
    explanation: reader.readStringOrNull(offsets[2]) ?? '',
    implementations:
        reader.readObjectList<ImplementationIsar>(
          offsets[3],
          ImplementationIsarSchema.deserialize,
          allOffsets,
          ImplementationIsar(),
        ) ??
        const [],
    key: reader.readStringOrNull(offsets[4]) ?? '',
    name: reader.readStringOrNull(offsets[5]) ?? '',
    pros: reader.readStringList(offsets[6]) ?? const [],
    spaceComplexity: reader.readStringOrNull(offsets[7]) ?? '',
    spaceExplanation: reader.readStringOrNull(offsets[8]),
    spaceExplanationForQuiz: reader.readStringOrNull(offsets[9]),
    timeComplexity: reader.readStringOrNull(offsets[10]) ?? '',
    timeExplanation: reader.readStringOrNull(offsets[11]),
    timeExplanationForQuiz: reader.readStringOrNull(offsets[12]),
    trickDetails: reader.readStringList(offsets[13]) ?? const [],
    trickSummary: reader.readStringOrNull(offsets[14]),
  );
  return object;
}

P _approachIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readObjectList<ImplementationIsar>(
                offset,
                ImplementationIsarSchema.deserialize,
                allOffsets,
                ImplementationIsar(),
              ) ??
              const [])
          as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringList(offset) ?? const []) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringList(offset) ?? const []) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ApproachIsarQueryFilter
    on QueryBuilder<ApproachIsar, ApproachIsar, QFilterCondition> {
  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'codingPattern'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'codingPattern'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'codingPattern',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'codingPattern',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'codingPattern',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'codingPattern', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  codingPatternIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'codingPattern', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cons',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cons',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cons', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cons', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', length, true, length, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, true, 0, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, false, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, true, length, include);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', length, include, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  consLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'explanation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'explanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'explanation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'explanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'implementations', length, true, length, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'implementations', 0, true, 0, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'implementations', 0, false, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'implementations', 0, true, length, include);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'implementations',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'implementations',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'key',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'key',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pros',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pros',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pros', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pros', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', length, true, length, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, true, 0, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, false, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, true, length, include);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', length, include, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  prosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spaceComplexity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spaceComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spaceComplexity',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spaceComplexity', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceComplexityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'spaceComplexity', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spaceExplanation'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spaceExplanation'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spaceExplanation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spaceExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spaceExplanation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spaceExplanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'spaceExplanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spaceExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spaceExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spaceExplanationForQuiz',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spaceExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spaceExplanationForQuiz',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spaceExplanationForQuiz',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  spaceExplanationForQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'spaceExplanationForQuiz',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeComplexity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeComplexity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeComplexity',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeComplexity', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeComplexityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timeComplexity', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeExplanation'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeExplanation'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeExplanation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeExplanation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeExplanation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeExplanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timeExplanation', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeExplanationForQuiz'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeExplanationForQuiz',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeExplanationForQuiz',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeExplanationForQuiz',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeExplanationForQuiz', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  timeExplanationForQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'timeExplanationForQuiz',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'trickDetails',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'trickDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'trickDetails',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trickDetails', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'trickDetails', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'trickDetails', length, true, length, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'trickDetails', 0, true, 0, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'trickDetails', 0, false, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'trickDetails', 0, true, length, include);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'trickDetails', length, include, 999999, true);
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickDetailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trickDetails',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'trickSummary'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'trickSummary'),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'trickSummary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'trickSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'trickSummary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trickSummary', value: ''),
      );
    });
  }

  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  trickSummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'trickSummary', value: ''),
      );
    });
  }
}

extension ApproachIsarQueryObject
    on QueryBuilder<ApproachIsar, ApproachIsar, QFilterCondition> {
  QueryBuilder<ApproachIsar, ApproachIsar, QAfterFilterCondition>
  implementationsElement(FilterQuery<ImplementationIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'implementations');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ImplementationIsarSchema = Schema(
  name: r'ImplementationIsar',
  id: 1043403521725883480,
  properties: {
    r'code': PropertySchema(id: 0, name: r'code', type: IsarType.string),
    r'language': PropertySchema(
      id: 1,
      name: r'language',
      type: IsarType.string,
    ),
  },

  estimateSize: _implementationIsarEstimateSize,
  serialize: _implementationIsarSerialize,
  deserialize: _implementationIsarDeserialize,
  deserializeProp: _implementationIsarDeserializeProp,
);

int _implementationIsarEstimateSize(
  ImplementationIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.code.length * 3;
  bytesCount += 3 + object.language.length * 3;
  return bytesCount;
}

void _implementationIsarSerialize(
  ImplementationIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.code);
  writer.writeString(offsets[1], object.language);
}

ImplementationIsar _implementationIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImplementationIsar(
    code: reader.readStringOrNull(offsets[0]) ?? '',
    language: reader.readStringOrNull(offsets[1]) ?? 'python',
  );
  return object;
}

P _implementationIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? 'python') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ImplementationIsarQueryFilter
    on QueryBuilder<ImplementationIsar, ImplementationIsar, QFilterCondition> {
  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'code',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'code',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'code', value: ''),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'code', value: ''),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'language',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'language',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<ImplementationIsar, ImplementationIsar, QAfterFilterCondition>
  languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'language', value: ''),
      );
    });
  }
}

extension ImplementationIsarQueryObject
    on QueryBuilder<ImplementationIsar, ImplementationIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ComparisonRowIsarSchema = Schema(
  name: r'ComparisonRowIsar',
  id: 8879584555510407339,
  properties: {
    r'approach': PropertySchema(
      id: 0,
      name: r'approach',
      type: IsarType.string,
    ),
    r'cons': PropertySchema(id: 1, name: r'cons', type: IsarType.stringList),
    r'pros': PropertySchema(id: 2, name: r'pros', type: IsarType.stringList),
    r'space': PropertySchema(id: 3, name: r'space', type: IsarType.string),
    r'time': PropertySchema(id: 4, name: r'time', type: IsarType.string),
  },

  estimateSize: _comparisonRowIsarEstimateSize,
  serialize: _comparisonRowIsarSerialize,
  deserialize: _comparisonRowIsarDeserialize,
  deserializeProp: _comparisonRowIsarDeserializeProp,
);

int _comparisonRowIsarEstimateSize(
  ComparisonRowIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.approach.length * 3;
  bytesCount += 3 + object.cons.length * 3;
  {
    for (var i = 0; i < object.cons.length; i++) {
      final value = object.cons[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.pros.length * 3;
  {
    for (var i = 0; i < object.pros.length; i++) {
      final value = object.pros[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.space.length * 3;
  bytesCount += 3 + object.time.length * 3;
  return bytesCount;
}

void _comparisonRowIsarSerialize(
  ComparisonRowIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.approach);
  writer.writeStringList(offsets[1], object.cons);
  writer.writeStringList(offsets[2], object.pros);
  writer.writeString(offsets[3], object.space);
  writer.writeString(offsets[4], object.time);
}

ComparisonRowIsar _comparisonRowIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ComparisonRowIsar(
    approach: reader.readStringOrNull(offsets[0]) ?? '',
    cons: reader.readStringList(offsets[1]) ?? const [],
    pros: reader.readStringList(offsets[2]) ?? const [],
    space: reader.readStringOrNull(offsets[3]) ?? '',
    time: reader.readStringOrNull(offsets[4]) ?? '',
  );
  return object;
}

P _comparisonRowIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ComparisonRowIsarQueryFilter
    on QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QFilterCondition> {
  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'approach',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'approach',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'approach',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'approach', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  approachIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'approach', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cons',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cons',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cons', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cons', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', length, true, length, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, true, 0, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, false, 999999, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', 0, true, length, include);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'cons', length, include, 999999, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  consLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pros',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pros',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pros',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pros', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pros', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', length, true, length, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, true, 0, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, false, 999999, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', 0, true, length, include);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'pros', length, include, 999999, true);
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  prosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'space',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'space',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'space',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'space', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  spaceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'space', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'time',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'time',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'time',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'time', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QAfterFilterCondition>
  timeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'time', value: ''),
      );
    });
  }
}

extension ComparisonRowIsarQueryObject
    on QueryBuilder<ComparisonRowIsar, ComparisonRowIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ComparisonTableIsarSchema = Schema(
  name: r'ComparisonTableIsar',
  id: -1224617018299255477,
  properties: {
    r'columns': PropertySchema(
      id: 0,
      name: r'columns',
      type: IsarType.stringList,
    ),
    r'rows': PropertySchema(
      id: 1,
      name: r'rows',
      type: IsarType.objectList,

      target: r'ComparisonRowIsar',
    ),
  },

  estimateSize: _comparisonTableIsarEstimateSize,
  serialize: _comparisonTableIsarSerialize,
  deserialize: _comparisonTableIsarDeserialize,
  deserializeProp: _comparisonTableIsarDeserializeProp,
);

int _comparisonTableIsarEstimateSize(
  ComparisonTableIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.columns.length * 3;
  {
    for (var i = 0; i < object.columns.length; i++) {
      final value = object.columns[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.rows.length * 3;
  {
    final offsets = allOffsets[ComparisonRowIsar]!;
    for (var i = 0; i < object.rows.length; i++) {
      final value = object.rows[i];
      bytesCount += ComparisonRowIsarSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _comparisonTableIsarSerialize(
  ComparisonTableIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.columns);
  writer.writeObjectList<ComparisonRowIsar>(
    offsets[1],
    allOffsets,
    ComparisonRowIsarSchema.serialize,
    object.rows,
  );
}

ComparisonTableIsar _comparisonTableIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ComparisonTableIsar(
    columns:
        reader.readStringList(offsets[0]) ??
        const ['Approach', 'Time', 'Space', 'Pros', 'Cons'],
    rows:
        reader.readObjectList<ComparisonRowIsar>(
          offsets[1],
          ComparisonRowIsarSchema.deserialize,
          allOffsets,
          ComparisonRowIsar(),
        ) ??
        const [],
  );
  return object;
}

P _comparisonTableIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ??
              const ['Approach', 'Time', 'Space', 'Pros', 'Cons'])
          as P;
    case 1:
      return (reader.readObjectList<ComparisonRowIsar>(
                offset,
                ComparisonRowIsarSchema.deserialize,
                allOffsets,
                ComparisonRowIsar(),
              ) ??
              const [])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ComparisonTableIsarQueryFilter
    on
        QueryBuilder<
          ComparisonTableIsar,
          ComparisonTableIsar,
          QFilterCondition
        > {
  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'columns',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'columns',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'columns',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'columns', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'columns', value: ''),
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'columns', length, true, length, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'columns', 0, true, 0, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'columns', 0, false, 999999, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'columns', 0, true, length, include);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'columns', length, include, 999999, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  columnsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'columns',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rows', length, true, length, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rows', 0, true, 0, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rows', 0, false, 999999, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rows', 0, true, length, include);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rows', length, include, 999999, true);
    });
  }

  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rows',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ComparisonTableIsarQueryObject
    on
        QueryBuilder<
          ComparisonTableIsar,
          ComparisonTableIsar,
          QFilterCondition
        > {
  QueryBuilder<ComparisonTableIsar, ComparisonTableIsar, QAfterFilterCondition>
  rowsElement(FilterQuery<ComparisonRowIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rows');
    });
  }
}
