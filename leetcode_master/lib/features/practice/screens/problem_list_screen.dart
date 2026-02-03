import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';
import '../providers/problems_provider.dart';

/// Screen showing list of problems for a category
class ProblemListScreen extends ConsumerWidget {
  const ProblemListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problemsAsync = ref.watch(problemsProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: problemsAsync.when(
        data: (problems) => _buildProblemList(context, problems),
        loading: () => const Center(
          child: CircularProgressIndicator(color: LCMColors.primary),
        ),
        error: (error, stack) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildProblemList(BuildContext context, List<Problem> problems) {
    // Group problems by difficulty
    final easyProblems =
        problems.where((p) => p.difficulty == Difficulty.easy).toList();
    final mediumProblems =
        problems.where((p) => p.difficulty == Difficulty.medium).toList();
    final hardProblems =
        problems.where((p) => p.difficulty == Difficulty.hard).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: LCMDimensions.paddingMD),
      children: [
        if (easyProblems.isNotEmpty) ...[
          _buildDifficultySection(context, 'Easy', easyProblems, Difficulty.easy),
        ],
        if (mediumProblems.isNotEmpty) ...[
          _buildDifficultySection(context, 'Medium', mediumProblems, Difficulty.medium),
        ],
        if (hardProblems.isNotEmpty) ...[
          _buildDifficultySection(context, 'Hard', hardProblems, Difficulty.hard),
        ],
      ],
    );
  }

  Widget _buildDifficultySection(
    BuildContext context,
    String label,
    List<Problem> problems,
    Difficulty difficulty,
  ) {
    final color = switch (difficulty) {
      Difficulty.easy => LCMColors.easy,
      Difficulty.medium => LCMColors.medium,
      Difficulty.hard => LCMColors.hard,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LCMDimensions.paddingMD,
            vertical: LCMDimensions.paddingSM,
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: LCMDimensions.paddingSM),
              Text(
                '$label (${problems.length})',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        ...problems.map((problem) => LCMListItem(
              title: problem.title,
              difficulty: problem.difficulty,
              isSolved: problem.isSolved,
              isPremium: problem.isPremium,
              isLocked: problem.isPremium, // TODO: Check user subscription
              onTap: () {
                context.go(
                  '/practice/category/$categoryId/problem/${problem.id}',
                );
              },
            )),
        const Divider(height: LCMDimensions.paddingMD),
      ],
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
              'Failed to load problems',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: LCMDimensions.paddingMD),
            LCMButton(
              label: 'Retry',
              onPressed: () => ref.invalidate(problemsProvider(categoryId)),
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }
}

// Temporary Problem class (will use generated one later)
class Problem {
  const Problem({
    required this.id,
    required this.title,
    required this.difficulty,
    this.isSolved = false,
    this.isPremium = false,
  });

  final String id;
  final String title;
  final Difficulty difficulty;
  final bool isSolved;
  final bool isPremium;
}
