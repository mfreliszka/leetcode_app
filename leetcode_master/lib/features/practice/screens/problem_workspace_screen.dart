import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';
import '../models/approach.dart';
import '../models/problem.dart';
import '../providers/problems_provider.dart';

/// Problem workspace with stepper for approaches
class ProblemWorkspaceScreen extends ConsumerStatefulWidget {
  const ProblemWorkspaceScreen({super.key, required this.problemId});

  final String problemId;

  @override
  ConsumerState<ProblemWorkspaceScreen> createState() =>
      _ProblemWorkspaceScreenState();
}

class _ProblemWorkspaceScreenState
    extends ConsumerState<ProblemWorkspaceScreen> {
  int _currentApproach = 0;
  int _unlockedApproaches = 1;
  CodeLanguage _selectedLanguage = CodeLanguage.python;

  void _markAsReadAndNext(ProblemDetail problem) {
    if (_currentApproach < problem.approaches.length - 1) {
      setState(() {
        _currentApproach++;
        if (_unlockedApproaches <= _currentApproach) {
          _unlockedApproaches = _currentApproach + 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final problemAsync = ref.watch(problemDetailProvider(widget.problemId));

    return problemAsync.when(
      data: (problem) => _buildContent(context, problem),
      loading: () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Loading...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: LCMColors.primary),
        ),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: LCMColors.error),
              const SizedBox(height: LCMDimensions.paddingMD),
              Text('Failed to load problem: $error'),
              const SizedBox(height: LCMDimensions.paddingMD),
              LCMButton(
                label: 'Retry',
                onPressed: () =>
                    ref.invalidate(problemDetailProvider(widget.problemId)),
                isFullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProblemDetail problem) {
    return Scaffold(
      backgroundColor: LCMColors.background,
      appBar: AppBar(
        title: Text(problem.title),
        backgroundColor: LCMColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: LCMColors.background,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(LCMDimensions.paddingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with difficulty badge
                Row(children: [LCMBadge(difficulty: problem.difficulty)]),
                const SizedBox(height: LCMDimensions.paddingMD),

                // Problem description
                Text(
                  problem.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: LCMColors.textPrimary,
                  ),
                ),
                const SizedBox(height: LCMDimensions.paddingLG),

                // Examples
                const Text(
                  'Examples',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LCMColors.textPrimary,
                  ),
                ),
                const SizedBox(height: LCMDimensions.paddingSM),
                ...problem.examples.asMap().entries.map((entry) {
                  final index = entry.key;
                  final example = entry.value;
                  return _buildExample(index + 1, example);
                }),
                const SizedBox(height: LCMDimensions.paddingMD),

                // Constraints
                const Text(
                  'Constraints',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LCMColors.textPrimary,
                  ),
                ),
                const SizedBox(height: LCMDimensions.paddingSM),
                ...problem.constraints.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '\u2022 ',
                          style: TextStyle(color: LCMColors.primary),
                        ),
                        Expanded(
                          child: Text(
                            c,
                            style: const TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontSize: 13,
                              color: LCMColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: LCMDimensions.paddingLG),
                const Divider(color: LCMColors.border),
                const SizedBox(height: LCMDimensions.paddingMD),

                // Approach stepper
                _buildApproachStepper(problem),
                const SizedBox(height: LCMDimensions.paddingMD),

                // Current approach content
                if (problem.approaches.isNotEmpty)
                  _buildApproachContent(problem.approaches[_currentApproach]),
                const SizedBox(height: LCMDimensions.paddingLG),

                // Action button
                if (_currentApproach < problem.approaches.length - 1)
                  LCMButton(
                    label: 'Mark as Read & Next',
                    onPressed: () => _markAsReadAndNext(problem),
                    icon: Icons.arrow_forward,
                  )
                else
                  LCMButton(
                    label: 'Complete',
                    onPressed: () {
                      // TODO: Mark problem as solved
                      context.pop();
                    },
                    icon: Icons.check,
                  ),
                const SizedBox(height: LCMDimensions.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApproachContent(Approach approach) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Approach title and complexity
        Row(
          children: [
            Expanded(
              child: Text(
                'Approach ${_currentApproach + 1}: ${approach.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: LCMColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: LCMDimensions.paddingSM),

        // Complexity badges
        Wrap(
          spacing: LCMDimensions.paddingSM,
          children: [
            LCMComplexityBadge(label: 'Time', value: approach.timeComplexity),
            LCMComplexityBadge(label: 'Space', value: approach.spaceComplexity),
          ],
        ),
        const SizedBox(height: LCMDimensions.paddingMD),

        // Explanation
        Text(
          approach.explanation,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            color: LCMColors.textPrimary,
          ),
        ),

        // Pattern highlight (for optimal approach)
        if (approach.pattern != null) ...[
          const SizedBox(height: LCMDimensions.paddingMD),
          Container(
            padding: const EdgeInsets.all(LCMDimensions.paddingSM),
            decoration: BoxDecoration(
              color: LCMColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
              border: Border.all(color: LCMColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: LCMColors.primary, size: 20),
                const SizedBox(width: LCMDimensions.paddingSM),
                Expanded(
                  child: Text(
                    approach.pattern!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: LCMColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: LCMDimensions.paddingMD),

        // Code block
        LCMCodeBlock(
          code: approach.code,
          language: _selectedLanguage,
          onLanguageChanged: (lang) => setState(() => _selectedLanguage = lang),
        ),
      ],
    );
  }

  Widget _buildExample(int index, Example example) {
    return Container(
      margin: const EdgeInsets.only(bottom: LCMDimensions.paddingSM),
      padding: const EdgeInsets.all(LCMDimensions.paddingSM),
      decoration: BoxDecoration(
        color: LCMColors.cardBackground,
        borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Example $index',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: LCMColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          _buildExampleRow('Input:', example.input),
          _buildExampleRow('Output:', example.output),
          if (example.explanation != null)
            _buildExampleRow('Explanation:', example.explanation!),
        ],
      ),
    );
  }

  Widget _buildExampleRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: LCMColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 13,
                color: LCMColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApproachStepper(ProblemDetail problem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(problem.approaches.length, (index) {
        final isActive = index == _currentApproach;
        final isUnlocked = index < _unlockedApproaches;
        final isCompleted = index < _currentApproach;

        return GestureDetector(
          onTap: isUnlocked
              ? () => setState(() => _currentApproach = index)
              : null,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive
                        ? LCMColors.primary
                        : isCompleted
                        ? LCMColors.success
                        : isUnlocked
                        ? LCMColors.cardBackground
                        : LCMColors.background,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive || isCompleted
                          ? Colors.transparent
                          : LCMColors.border,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : isUnlocked
                        ? Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? LCMColors.background
                                  : LCMColors.textPrimary,
                            ),
                          )
                        : const Icon(
                            Icons.lock,
                            size: 14,
                            color: LCMColors.textMuted,
                          ),
                  ),
                ),
                if (index < problem.approaches.length - 1)
                  Container(
                    width: 24,
                    height: 2,
                    color: isCompleted ? LCMColors.success : LCMColors.border,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
