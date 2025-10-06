class Category {
  final int id;
  final String name;
  final bool premium;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.premium,
    required this.description,
  });

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'] as int,
        name: map['name'] as String,
        premium: (map['premium'] as bool?) ?? false,
        description: (map['description'] as String?) ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'premium': premium ? 1 : 0,
        'description': description,
      };
}