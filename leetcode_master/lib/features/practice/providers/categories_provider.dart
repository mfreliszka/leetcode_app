import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/category_list_screen.dart';

/// Provider for fetching categories
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(seconds: 1));

  // Mock data for now
  return const [
    Category(
      id: 'arrays-hashing',
      name: 'Arrays & Hashing',
      icon: '🔢',
      problemCount: 9,
      solvedCount: 3,
    ),
    Category(
      id: 'two-pointers',
      name: 'Two Pointers',
      icon: '👆',
      problemCount: 5,
      solvedCount: 0,
    ),
    Category(
      id: 'sliding-window',
      name: 'Sliding Window',
      icon: '🪟',
      problemCount: 6,
      solvedCount: 2,
    ),
    Category(
      id: 'stack',
      name: 'Stack',
      icon: '📚',
      problemCount: 7,
      solvedCount: 1,
    ),
    Category(
      id: 'binary-search',
      name: 'Binary Search',
      icon: '🔍',
      problemCount: 7,
      solvedCount: 0,
    ),
    Category(
      id: 'linked-list',
      name: 'Linked List',
      icon: '🔗',
      problemCount: 11,
      solvedCount: 0,
    ),
    Category(
      id: 'trees',
      name: 'Trees',
      icon: '🌲',
      problemCount: 15,
      solvedCount: 0,
    ),
    Category(
      id: 'tries',
      name: 'Tries',
      icon: '🔤',
      problemCount: 3,
      solvedCount: 0,
      isPremium: true,
    ),
    Category(
      id: 'heap-priority-queue',
      name: 'Heap / Priority Queue',
      icon: '⛰️',
      problemCount: 7,
      solvedCount: 0,
    ),
    Category(
      id: 'backtracking',
      name: 'Backtracking',
      icon: '↩️',
      problemCount: 9,
      solvedCount: 0,
    ),
    Category(
      id: 'graphs',
      name: 'Graphs',
      icon: '🕸️',
      problemCount: 13,
      solvedCount: 0,
    ),
    Category(
      id: 'dynamic-programming',
      name: 'Dynamic Programming',
      icon: '📊',
      problemCount: 19,
      solvedCount: 0,
    ),
    Category(
      id: 'greedy',
      name: 'Greedy',
      icon: '💰',
      problemCount: 8,
      solvedCount: 0,
    ),
    Category(
      id: 'intervals',
      name: 'Intervals',
      icon: '📏',
      problemCount: 6,
      solvedCount: 0,
    ),
    Category(
      id: 'math-geometry',
      name: 'Math & Geometry',
      icon: '📐',
      problemCount: 8,
      solvedCount: 0,
      isPremium: true,
    ),
    Category(
      id: 'bit-manipulation',
      name: 'Bit Manipulation',
      icon: '0️⃣',
      problemCount: 7,
      solvedCount: 0,
    ),
  ];
});
