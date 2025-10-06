import '../domain/hint_repository.dart';
import '../domain/models.dart';

class MockHintRepository implements HintRepository {
  const MockHintRepository();

  @override
  Future<List<Hint>> listHintsByProblem(String problemId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return [
      Hint(id: 'h-$problemId-1', problemId: problemId, text: 'Consider using a set/map for faster lookups.'),
      Hint(id: 'h-$problemId-2', problemId: problemId, text: 'Think about complements: target - current value.'),
    ];
  }
}