import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';

/// Problem workspace with stepper for approaches
class ProblemWorkspaceScreen extends ConsumerStatefulWidget {
  const ProblemWorkspaceScreen({
    super.key,
    required this.problemId,
  });

  final String problemId;

  @override
  ConsumerState<ProblemWorkspaceScreen> createState() =>
      _ProblemWorkspaceScreenState();
}

class _ProblemWorkspaceScreenState
    extends ConsumerState<ProblemWorkspaceScreen> {
  int _currentApproach = 0;
  int _unlockedApproaches = 1; // Start with only Approach 1 unlocked
  CodeLanguage _selectedLanguage = CodeLanguage.python;

  // Mock data - will be replaced with provider
  final _mockProblem = const _ProblemDetail(
    id: '1',
    title: '1. Two Sum',
    difficulty: Difficulty.easy,
    description:
        'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.\n\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.\n\nYou can return the answer in any order.',
    examples: [
      _Example(
        input: 'nums = [2,7,11,15], target = 9',
        output: '[0,1]',
        explanation: 'Because nums[0] + nums[1] == 9, we return [0, 1].',
      ),
      _Example(
        input: 'nums = [3,2,4], target = 6',
        output: '[1,2]',
        explanation: null,
      ),
    ],
    constraints: [
      '2 <= nums.length <= 10^4',
      '-10^9 <= nums[i] <= 10^9',
      '-10^9 <= target <= 10^9',
      'Only one valid answer exists.',
    ],
    approaches: [
      _Approach(
        name: 'Brute Force',
        timeComplexity: 'O(n^2)',
        spaceComplexity: 'O(1)',
        explanation:
            'Check every pair of numbers to see if they sum to target. For each element, iterate through the rest of the array.',
        pattern: null,
        code: {
          CodeLanguage.python: '''def twoSum(nums, target):
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []''',
          CodeLanguage.java: '''public int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return new int[] {i, j};
            }
        }
    }
    return new int[] {};
}''',
        },
      ),
      _Approach(
        name: 'Two-Pass HashMap',
        timeComplexity: 'O(n)',
        spaceComplexity: 'O(n)',
        explanation:
            'Use a hash map to store values and their indices. First pass: build the map. Second pass: look for complement.',
        pattern: null,
        code: {
          CodeLanguage.python: '''def twoSum(nums, target):
    num_map = {}
    for i, num in enumerate(nums):
        num_map[num] = i
    
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_map and num_map[complement] != i:
            return [i, num_map[complement]]
    return []''',
          CodeLanguage.java: '''public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        map.put(nums[i], i);
    }
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement) && map.get(complement) != i) {
            return new int[] {i, map.get(complement)};
        }
    }
    return new int[] {};
}''',
        },
      ),
      _Approach(
        name: 'One-Pass HashMap',
        timeComplexity: 'O(n)',
        spaceComplexity: 'O(n)',
        explanation:
            'Build the hash map while iterating. For each element, check if its complement already exists in the map.',
        pattern: 'Use a HashMap to store complements for O(1) lookup',
        code: {
          CodeLanguage.python: '''def twoSum(nums, target):
    num_map = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_map:
            return [num_map[complement], i]
        num_map[num] = i
    return []''',
          CodeLanguage.java: '''public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement)) {
            return new int[] {map.get(complement), i};
        }
        map.put(nums[i], i);
    }
    return new int[] {};
}''',
        },
      ),
    ],
  );

  void _markAsReadAndNext() {
    if (_currentApproach < _mockProblem.approaches.length - 1) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_mockProblem.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LCMDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with difficulty badge
            Row(
              children: [
                LCMBadge(difficulty: _mockProblem.difficulty),
              ],
            ),
            const SizedBox(height: LCMDimensions.paddingMD),

            // Problem description
            Text(
              _mockProblem.description,
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
            ..._mockProblem.examples.asMap().entries.map((entry) {
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
            ..._mockProblem.constraints.map((c) => Padding(
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
                )),
            const SizedBox(height: LCMDimensions.paddingLG),
            const Divider(),
            const SizedBox(height: LCMDimensions.paddingMD),

            // Approach stepper
            _buildApproachStepper(),
            const SizedBox(height: LCMDimensions.paddingMD),

            // Current approach content
            _buildApproachContent(_mockProblem.approaches[_currentApproach]),
            const SizedBox(height: LCMDimensions.paddingLG),

            // Action button
            if (_currentApproach < _mockProblem.approaches.length - 1)
              LCMButton(
                label: 'Mark as Read & Next',
                onPressed: _markAsReadAndNext,
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
    );
  }

  Widget _buildExample(int index, _Example example) {
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

  Widget _buildApproachStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_mockProblem.approaches.length, (index) {
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
                            : const Icon(Icons.lock,
                                size: 14, color: LCMColors.textMuted),
                  ),
                ),
                if (index < _mockProblem.approaches.length - 1)
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

  Widget _buildApproachContent(_Approach approach) {
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
}

// Temporary data classes
class _ProblemDetail {
  const _ProblemDetail({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.description,
    required this.examples,
    required this.constraints,
    required this.approaches,
  });

  final String id;
  final String title;
  final Difficulty difficulty;
  final String description;
  final List<_Example> examples;
  final List<String> constraints;
  final List<_Approach> approaches;
}

class _Example {
  const _Example({
    required this.input,
    required this.output,
    this.explanation,
  });

  final String input;
  final String output;
  final String? explanation;
}

class _Approach {
  const _Approach({
    required this.name,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    required this.code,
    this.pattern,
  });

  final String name;
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  final Map<CodeLanguage, String> code;
  final String? pattern;
}
