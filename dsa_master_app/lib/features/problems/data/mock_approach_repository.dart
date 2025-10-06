import '../domain/approach_repository.dart';
import '../domain/models.dart';

class MockApproachRepository implements ApproachRepository {
  const MockApproachRepository();

  @override
  Future<List<Approach>> listApproachesByProblem(String problemId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return [
      Approach(
        id: 'a-$problemId-1',
        problemId: problemId,
        type: 'brute_force',
        timeComplexity: 'O(n²)',
        spaceComplexity: 'O(1)',
        explanation: 'Try all pairs and check if they sum to target.',
        code: '// pseudocode for brute force\nfor i in [0..n){ for j in [i+1..n){ if a[i]+a[j]==t return [i,j];}}',
        keyInsights: const ['Exhaustive search', 'Simple but slow'],
      ),
      Approach(
        id: 'a-$problemId-2',
        problemId: problemId,
        type: 'optimal',
        timeComplexity: 'O(n)',
        spaceComplexity: 'O(n)',
        explanation: 'Use a hash map to store complements and find a match.',
        code: '// pseudocode for optimal\nmap = {}\nfor i in [0..n){ c = t - a[i]; if map.contains(c) return [map[c], i]; map[a[i]] = i; }',
        keyInsights: const ['Complement lookup pattern', 'Trade space for time'],
      ),
    ];
  }
}