import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/lcm_badge.dart';
import '../../../components/lcm_code_block.dart';
import '../models/approach.dart';
import '../models/problem.dart';
// Note: Problem class is now imported from models/problem.dart

/// Provider for fetching problems by category
final problemsProvider = FutureProvider.family<List<Problem>, String>((
  ref,
  categoryId,
) async {
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
        questionSetIds: ['blind_75', 'neetcode_150', 'grind_75'],
      ),
      Problem(
        id: '242',
        title: '242. Valid Anagram',
        difficulty: Difficulty.easy,
        isSolved: true,
        questionSetIds: ['blind_75', 'neetcode_150', 'grind_75'],
      ),
      Problem(
        id: '1',
        title: '1. Two Sum',
        difficulty: Difficulty.easy,
        isSolved: true,
        questionSetIds: ['blind_75', 'neetcode_150', 'grind_75', 'leetcode_75'],
      ),
      Problem(
        id: '49',
        title: '49. Group Anagrams',
        difficulty: Difficulty.medium,
        questionSetIds: ['blind_75', 'neetcode_150'],
      ),
      Problem(
        id: '347',
        title: '347. Top K Frequent Elements',
        difficulty: Difficulty.medium,
        questionSetIds: ['blind_75', 'neetcode_150', 'grind_75'],
      ),
      Problem(
        id: '271',
        title: '271. Encode and Decode Strings',
        difficulty: Difficulty.medium,
        isPremium: true,
        questionSetIds: ['blind_75', 'neetcode_150'],
      ),
      Problem(
        id: '238',
        title: '238. Product of Array Except Self',
        difficulty: Difficulty.medium,
        questionSetIds: ['blind_75', 'neetcode_150', 'grind_75'],
      ),
      Problem(
        id: '36',
        title: '36. Valid Sudoku',
        difficulty: Difficulty.medium,
        questionSetIds: ['neetcode_150'],
      ),
      Problem(
        id: '128',
        title: '128. Longest Consecutive Sequence',
        difficulty: Difficulty.medium,
        questionSetIds: ['blind_75', 'neetcode_150'],
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
      Problem(id: '15', title: '15. 3Sum', difficulty: Difficulty.medium),
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

/// Provider for fetching problem detail by ID
final problemDetailProvider = FutureProvider.family<ProblemDetail, String>((
  ref,
  problemId,
) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(milliseconds: 300));

  // Mock problem details lookup
  return _mockProblemDetails[problemId] ?? _createPlaceholderDetail(problemId);
});

/// Create a placeholder detail for problems without mock data
ProblemDetail _createPlaceholderDetail(String problemId) {
  return ProblemDetail(
    id: problemId,
    title: 'Problem #$problemId',
    difficulty: Difficulty.medium,
    description: 'Problem description coming soon...',
    examples: const [
      Example(
        input: 'Example input',
        output: 'Example output',
        explanation: 'This is a placeholder problem.',
      ),
    ],
    constraints: const ['Constraints coming soon'],
    approaches: [
      Approach(
        id: '1',
        order: 1,
        name: 'Coming Soon',
        timeComplexity: 'TBD',
        spaceComplexity: 'TBD',
        explanation: 'Detailed explanation will be added soon.',
        code: const {CodeLanguage.python: '# Coming soon...'},
      ),
    ],
  );
}

/// Mock problem details database
const _mockProblemDetails = <String, ProblemDetail>{
  '1': ProblemDetail(
    id: '1',
    title: '1. Two Sum',
    difficulty: Difficulty.easy,
    description:
        'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.\n\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.\n\nYou can return the answer in any order.',
    examples: [
      Example(
        input: 'nums = [2,7,11,15], target = 9',
        output: '[0,1]',
        explanation: 'Because nums[0] + nums[1] == 9, we return [0, 1].',
      ),
      Example(input: 'nums = [3,2,4], target = 6', output: '[1,2]'),
    ],
    constraints: [
      '2 <= nums.length <= 10^4',
      '-10^9 <= nums[i] <= 10^9',
      '-10^9 <= target <= 10^9',
      'Only one valid answer exists.',
    ],
    approaches: [
      Approach(
        id: '1-1',
        order: 1,
        name: 'Brute Force',
        timeComplexity: 'O(n²)',
        spaceComplexity: 'O(1)',
        explanation:
            'Check every pair of numbers to see if they sum to target. For each element, iterate through the rest of the array.',
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
      Approach(
        id: '1-2',
        order: 2,
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
  ),
  '217': ProblemDetail(
    id: '217',
    title: '217. Contains Duplicate',
    difficulty: Difficulty.easy,
    description:
        'Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.',
    examples: [
      Example(
        input: 'nums = [1,2,3,1]',
        output: 'true',
        explanation: 'The element 1 occurs at indices 0 and 3.',
      ),
      Example(
        input: 'nums = [1,2,3,4]',
        output: 'false',
        explanation: 'All elements are distinct.',
      ),
    ],
    constraints: ['1 <= nums.length <= 10^5', '-10^9 <= nums[i] <= 10^9'],
    approaches: [
      Approach(
        id: '217-1',
        order: 1,
        name: 'Brute Force',
        timeComplexity: 'O(n²)',
        spaceComplexity: 'O(1)',
        explanation: 'Compare each element with every other element.',
        code: {
          CodeLanguage.python: '''def containsDuplicate(nums):
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] == nums[j]:
                return True
    return False''',
        },
      ),
      Approach(
        id: '217-2',
        order: 2,
        name: 'HashSet',
        timeComplexity: 'O(n)',
        spaceComplexity: 'O(n)',
        explanation:
            'Use a set to track seen elements. If we encounter an element already in the set, return true.',
        pattern: 'Use a HashSet for O(1) lookup of seen elements',
        code: {
          CodeLanguage.python: '''def containsDuplicate(nums):
    seen = set()
    for num in nums:
        if num in seen:
            return True
        seen.add(num)
    return False''',
        },
      ),
    ],
  ),
  '242': ProblemDetail(
    id: '242',
    title: '242. Valid Anagram',
    difficulty: Difficulty.easy,
    description:
        'Given two strings s and t, return true if t is an anagram of s, and false otherwise.\n\nAn Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.',
    examples: [
      Example(input: 's = "anagram", t = "nagaram"', output: 'true'),
      Example(input: 's = "rat", t = "car"', output: 'false'),
    ],
    constraints: [
      '1 <= s.length, t.length <= 5 * 10^4',
      's and t consist of lowercase English letters.',
    ],
    approaches: [
      Approach(
        id: '242-1',
        order: 1,
        name: 'Sorting',
        timeComplexity: 'O(n log n)',
        spaceComplexity: 'O(n)',
        explanation:
            'Sort both strings and compare. Anagrams will have identical sorted forms.',
        code: {
          CodeLanguage.python: '''def isAnagram(s, t):
    return sorted(s) == sorted(t)''',
        },
      ),
      Approach(
        id: '242-2',
        order: 2,
        name: 'Character Count',
        timeComplexity: 'O(n)',
        spaceComplexity: 'O(1)',
        explanation:
            'Count character frequencies. For anagrams, both strings have identical character counts.',
        pattern: 'Use frequency counting for string comparison',
        code: {
          CodeLanguage.python: '''def isAnagram(s, t):
    if len(s) != len(t):
        return False
    count = {}
    for c in s:
        count[c] = count.get(c, 0) + 1
    for c in t:
        count[c] = count.get(c, 0) - 1
        if count[c] < 0:
            return False
    return True''',
        },
      ),
    ],
  ),
};
