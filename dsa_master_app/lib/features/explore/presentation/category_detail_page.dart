import 'package:flutter/material.dart';
import '../../explore/data/mock_problem_repository.dart';
import '../../explore/domain/models.dart';
import 'package:go_router/go_router.dart';

class CategoryDetailPage extends StatelessWidget {
  final String categoryId;
  const CategoryDetailPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final repo = MockProblemRepository();
    return Scaffold(
      appBar: AppBar(title: Text('Category: $categoryId')),
      body: FutureBuilder<List<Problem>>(
        future: repo.listProblemsByCategory(categoryId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!;
          if (items.isEmpty) {
            return const Center(child: Text('No problems yet'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final p = items[index];
              return ListTile(
                title: Text(p.title),
                subtitle: Text(p.difficulty),
                trailing: const Icon(Icons.play_arrow),
                onTap: () => context.go('/practice/${p.id}'),
              );
            },
          );
        },
      ),
    );
  }
}