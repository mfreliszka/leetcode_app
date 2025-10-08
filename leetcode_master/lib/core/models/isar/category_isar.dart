import 'package:isar_community/isar.dart';

part 'category_isar.g.dart';

@Collection()
class CategoryIsar {
  Id id;
  String name;
  bool premium; // premium category flag
  String? description;

  CategoryIsar({
    required this.id,
    required this.name,
    required this.premium,
    this.description,
  });
}