import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';
import '../models/problem.dart';
import '../models/question_set.dart';
import '../providers/problems_provider.dart';
import '../providers/question_sets_provider.dart';

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
    final questionSetsAsync = ref.watch(questionSetsProvider);
    final selectedSetId = ref.watch(selectedQuestionSetProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          questionSetsAsync.when(
            data: (sets) =>
                _buildFilterButton(context, ref, sets, selectedSetId),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: problemsAsync.when(
        data: (problems) => _buildProblemList(context, problems, selectedSetId),
        loading: () => const Center(
          child: CircularProgressIndicator(color: LCMColors.primary),
        ),
        error: (error, stack) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    WidgetRef ref,
    List<QuestionSet> sets,
    String? selectedSetId,
  ) {
    final isFiltered = selectedSetId != null && selectedSetId.isNotEmpty;

    return PopupMenuButton<String?>(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.filter_list,
            color: isFiltered ? LCMColors.primary : LCMColors.textSecondary,
          ),
          if (isFiltered)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: LCMColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      tooltip: 'Filter by set',
      onSelected: (value) {
        ref.read(selectedQuestionSetProvider.notifier).state =
            (value == null || value.isEmpty) ? null : value;
      },
      itemBuilder: (context) => [
        PopupMenuItem<String?>(
          value: '',
          child: Row(
            children: [
              Icon(
                (selectedSetId?.isEmpty ?? true) ? Icons.check : Icons.list,
                size: 18,
                color: (selectedSetId?.isEmpty ?? true)
                    ? LCMColors.primary
                    : LCMColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Text(
                'All Problems',
                style: TextStyle(
                  color: (selectedSetId?.isEmpty ?? true)
                      ? LCMColors.primary
                      : LCMColors.textPrimary,
                  fontWeight: (selectedSetId?.isEmpty ?? true)
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        ...sets.map(
          (set) => PopupMenuItem<String?>(
            value: set.id,
            child: Row(
              children: [
                Icon(
                  selectedSetId == set.id
                      ? Icons.check
                      : Icons.bookmark_outline,
                  size: 18,
                  color: selectedSetId == set.id
                      ? LCMColors.primary
                      : LCMColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    set.name,
                    style: TextStyle(
                      color: selectedSetId == set.id
                          ? LCMColors.primary
                          : LCMColors.textPrimary,
                      fontWeight: selectedSetId == set.id
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProblemList(
    BuildContext context,
    List<Problem> problems,
    String? selectedSetId,
  ) {
    // Apply filter if a set is selected
    final filteredProblems = selectedSetId == null
        ? problems
        : problems
              .where((p) => p.questionSetIds.contains(selectedSetId))
              .toList();

    if (filteredProblems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(LCMDimensions.paddingLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.filter_list_off,
                size: 48,
                color: LCMColors.textSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: LCMDimensions.paddingMD),
              Text(
                'No problems match filter',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: LCMColors.textSecondary,
                ),
              ),
              const SizedBox(height: LCMDimensions.paddingSM),
              Text(
                'Try selecting a different set',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: LCMColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Group problems by difficulty
    final easyProblems = filteredProblems
        .where((p) => p.difficulty == Difficulty.easy)
        .toList();
    final mediumProblems = filteredProblems
        .where((p) => p.difficulty == Difficulty.medium)
        .toList();
    final hardProblems = filteredProblems
        .where((p) => p.difficulty == Difficulty.hard)
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: LCMDimensions.paddingMD),
      children: [
        if (easyProblems.isNotEmpty) ...[
          _buildDifficultySection(
            context,
            'Easy',
            easyProblems,
            Difficulty.easy,
          ),
        ],
        if (mediumProblems.isNotEmpty) ...[
          _buildDifficultySection(
            context,
            'Medium',
            mediumProblems,
            Difficulty.medium,
          ),
        ],
        if (hardProblems.isNotEmpty) ...[
          _buildDifficultySection(
            context,
            'Hard',
            hardProblems,
            Difficulty.hard,
          ),
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
        ...problems.map(
          (problem) => LCMListItem(
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
          ),
        ),
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
            const Icon(Icons.error_outline, size: 48, color: LCMColors.error),
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
