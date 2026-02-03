import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/lcm_badge.dart';
import '../screens/problem_list_screen.dart';

/// Provider for fetching problems by category
final problemsProvider =
    FutureProvider.family<List<Problem>, String>((ref, categoryId) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(milliseconds: 500));

  // Mock data based on category
  return switch (categoryId) {
    'arrays-hashing' => const [
        Problem(
          id: '217',
          title: '217. Contains Duplicate',
          difficulty: Difficulty.easy,
          isSolved: true,
        ),
        Problem(
          id: '242',
          title: '242. Valid Anagram',
          difficulty: Difficulty.easy,
          isSolved: true,
        ),
        Problem(
          id: '1',
          title: '1. Two Sum',
          difficulty: Difficulty.easy,
          isSolved: true,
        ),
        Problem(
          id: '49',
          title: '49. Group Anagrams',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '347',
          title: '347. Top K Frequent Elements',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '271',
          title: '271. Encode and Decode Strings',
          difficulty: Difficulty.medium,
          isPremium: true,
        ),
        Problem(
          id: '238',
          title: '238. Product of Array Except Self',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '36',
          title: '36. Valid Sudoku',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '128',
          title: '128. Longest Consecutive Sequence',
          difficulty: Difficulty.medium,
        ),
      ],
    'two-pointers' => const [
        Problem(
          id: '125',
          title: '125. Valid Palindrome',
          difficulty: Difficulty.easy,
        ),
        Problem(
          id: '167',
          title: '167. Two Sum II',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '15',
          title: '15. 3Sum',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '11',
          title: '11. Container With Most Water',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '42',
          title: '42. Trapping Rain Water',
          difficulty: Difficulty.hard,
        ),
      ],
    'sliding-window' => const [
        Problem(
          id: '121',
          title: '121. Best Time to Buy and Sell Stock',
          difficulty: Difficulty.easy,
          isSolved: true,
        ),
        Problem(
          id: '3',
          title: '3. Longest Substring Without Repeating Characters',
          difficulty: Difficulty.medium,
          isSolved: true,
        ),
        Problem(
          id: '424',
          title: '424. Longest Repeating Character Replacement',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '567',
          title: '567. Permutation in String',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '76',
          title: '76. Minimum Window Substring',
          difficulty: Difficulty.hard,
        ),
        Problem(
          id: '239',
          title: '239. Sliding Window Maximum',
          difficulty: Difficulty.hard,
        ),
      ],
    'stack' => const [
        Problem(
          id: '20',
          title: '20. Valid Parentheses',
          difficulty: Difficulty.easy,
          isSolved: true,
        ),
        Problem(
          id: '155',
          title: '155. Min Stack',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '150',
          title: '150. Evaluate Reverse Polish Notation',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '22',
          title: '22. Generate Parentheses',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '739',
          title: '739. Daily Temperatures',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '853',
          title: '853. Car Fleet',
          difficulty: Difficulty.medium,
        ),
        Problem(
          id: '84',
          title: '84. Largest Rectangle in Histogram',
          difficulty: Difficulty.hard,
        ),
      ],
    _ => const [],
  };
});
