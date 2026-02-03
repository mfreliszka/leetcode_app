import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_set.dart';

/// Provider for available question sets
final questionSetsProvider = FutureProvider<List<QuestionSet>>((ref) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(milliseconds: 300));

  return const [
    QuestionSet(
      id: 'blind_75',
      name: 'Blind 75',
      description: 'The 75 most popular LeetCode questions',
      problemCount: 75,
    ),
    QuestionSet(
      id: 'neetcode_150',
      name: 'NeetCode 150',
      description: 'Curated 150 problems by NeetCode',
      problemCount: 150,
    ),
    QuestionSet(
      id: 'grind_75',
      name: 'Grind 75',
      description: 'Updated Blind 75 by Tech Interview Handbook',
      problemCount: 75,
    ),
    QuestionSet(
      id: 'leetcode_75',
      name: 'LeetCode 75',
      description: 'Official LeetCode study plan',
      problemCount: 75,
    ),
  ];
});

/// State notifier for the currently selected question set filter
final selectedQuestionSetProvider = StateProvider<String?>((ref) => null);
