import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../explore/data/mock_category_repository.dart';
import '../../explore/domain/models.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockCategoryRepository();
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Categories')),
      body: FutureBuilder<List<Category>>(
        future: repo.listCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!;
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final cat = items[index];
              return ListTile(
                title: Text(cat.name),
                subtitle: Text('${cat.problemCount} problems'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/explore/${cat.id}'),
              );
            },
          );
        },
      ),
    );
  }
}