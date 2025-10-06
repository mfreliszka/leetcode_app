import '../domain/problem_repository.dart';
import '../domain/models.dart';

class MockProblemRepository implements ProblemRepository {
  @override
  Future<List<Problem>> listProblemsByCategory(String categoryId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    switch (categoryId) {
      case 'arrays':
        return const [
          Problem(id: 'two-sum', title: 'Two Sum', difficulty: 'Easy'),
          Problem(id: 'max-subarray', title: 'Maximum Subarray', difficulty: 'Medium'),
        ];
      case 'strings':
        return const [
          Problem(id: 'valid-anagram', title: 'Valid Anagram', difficulty: 'Easy'),
          Problem(id: 'longest-substring', title: 'Longest Substring Without Repeating', difficulty: 'Medium'),
        ];
      case 'graphs':
        return const [
          Problem(id: 'bfs', title: 'Breadth-First Search', difficulty: 'Easy'),
          Problem(id: 'dijkstra', title: 'Dijkstra Shortest Path', difficulty: 'Medium'),
        ];
      case 'dp':
        return const [
          Problem(id: 'climb-stairs', title: 'Climbing Stairs', difficulty: 'Easy'),
          Problem(id: 'edit-distance', title: 'Edit Distance', difficulty: 'Hard'),
        ];
      default:
        return const [];
    }
  }
}