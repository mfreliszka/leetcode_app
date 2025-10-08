import 'package:isar_community/isar.dart';
import '../db/isar_database.dart';
import '../models/isar/problem_isar.dart';
import '../models/problem_content.dart';

class ProblemContentRepository {
  Future<ProblemContent?> fetchByProblemId(int id) async {
    final isar = await IsarDatabase.instance.isar;
    final p = await isar.problemIsars.get(id);
    if (p == null) return null;

    final approaches = p.approaches.map((a) {
      final code = a.implementations.isNotEmpty ? a.implementations.first.code : null;
      final implMap = <String, String>{};
      for (final impl in a.implementations) {
        if (impl.language.isNotEmpty && impl.code.isNotEmpty) {
          implMap[impl.language] = impl.code;
        }
      }
      return ApproachInfo(
        key: a.key,
        name: a.name,
        codingPattern: a.codingPattern,
        timeComplexity: a.timeComplexity,
        timeExplanation: a.timeExplanation,
        spaceComplexity: a.spaceComplexity,
        spaceExplanation: a.spaceExplanation,
        explanation: a.explanation,
        trickSummary: a.trickSummary,
        trickDetails: a.trickDetails,
        pros: a.pros,
        cons: a.cons,
        code: code,
        implementations: implMap,
      );
    }).toList();

    final constraints = p.content?.constraints
            .map((c) => ConstraintInfo(name: c.name, value: c.value, explanation: c.explanation))
            .toList() ??
        const <ConstraintInfo>[];
    final testCases = p.testCases
        .map((t) => TestCaseInfo(name: t.name, inputJson: t.inputJson, output: t.output, explanation: t.explanation))
        .toList();
    final notes = p.content?.notes ?? const <String>[];

    ComparisonTableInfo? table;
    final ct = p.comparisonTable;
    if (ct != null) {
      table = ComparisonTableInfo(
        columns: ct.columns,
        rows: ct.rows
            .map((r) => ComparisonRowInfo(
                  approach: r.approach,
                  time: r.time,
                  space: r.space,
                  pros: r.pros,
                  cons: r.cons,
                ))
            .toList(),
      );
    }

    return ProblemContent(
      problemId: p.id,
      statement: p.content?.statement ?? '',
      inputFormat: p.content?.inputFormat ?? '',
      outputFormat: p.content?.outputFormat ?? '',
      constraints: constraints,
      notes: notes,
      testCases: testCases,
      approaches: approaches,
      comparisonTable: table,
    );
  }
}