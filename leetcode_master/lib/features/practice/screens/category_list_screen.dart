import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';
import '../providers/categories_provider.dart';

/// Main practice screen showing list of DSA categories
class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildCategoryList(context, categories),
        loading: () => const Center(
          child: CircularProgressIndicator(color: LCMColors.primary),
        ),
        error: (error, stack) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, List<Category> categories) {
    return ListView.separated(
      padding: const EdgeInsets.all(LCMDimensions.paddingMD),
      itemCount: categories.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: LCMDimensions.paddingSM),
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(category: category);
      },
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(LCMDimensions.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: LCMColors.error,
            ),
            const SizedBox(height: LCMDimensions.paddingMD),
            Text(
              'Failed to load categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: LCMDimensions.paddingSM),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LCMDimensions.paddingMD),
            LCMButton(
              label: 'Retry',
              onPressed: () => ref.invalidate(categoriesProvider),
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return LCMCard(
      onTap: () {
        context.go(
          '/practice/category/${category.id}?name=${Uri.encodeComponent(category.name)}',
        );
      },
      child: Row(
        children: [
          // Category icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: LCMColors.background,
              borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
            ),
            child: Center(
              child: Text(
                category.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: LCMDimensions.paddingMD),

          // Title and progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LCMColors.textPrimary,
                        ),
                      ),
                    ),
                    if (category.isPremium) const LCMPremiumBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: category.progress,
                          minHeight: 4,
                          backgroundColor: LCMColors.background,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            LCMColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: LCMDimensions.paddingSM),
                    Text(
                      '${category.solvedCount}/${category.problemCount}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: LCMColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: LCMDimensions.paddingSM),

          // Chevron or lock
          Icon(
            category.isPremium ? Icons.lock_outline : Icons.chevron_right,
            color: LCMColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

// Temporary Category class for now (will be replaced by generated one)
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.problemCount,
    required this.solvedCount,
    this.isPremium = false,
  });

  final String id;
  final String name;
  final String icon;
  final int problemCount;
  final int solvedCount;
  final bool isPremium;

  double get progress => problemCount > 0 ? solvedCount / problemCount : 0;
}
