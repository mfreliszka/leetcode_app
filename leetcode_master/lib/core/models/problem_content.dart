class ApproachInfo {
  final String name;
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  final String? code;
  final List<String> pros;
  final List<String> cons;

  ApproachInfo({
    required this.name,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    this.code,
    this.pros = const [],
    this.cons = const [],
  });

  factory ApproachInfo.fromMap(Map<String, dynamic> m) {
    return ApproachInfo(
      name: m['name'] as String,
      timeComplexity: m['time'] as String,
      spaceComplexity: m['space'] as String,
      explanation: m['explanation'] as String,
      code: m['code'] as String?,
      pros: (m['pros'] as List?)?.cast<String>() ?? const [],
      cons: (m['cons'] as List?)?.cast<String>() ?? const [],
    );
  }
}

class ProblemContent {
  final int problemId;
  final List<ApproachInfo> approaches;

  ProblemContent({required this.problemId, required this.approaches});

  factory ProblemContent.fromMap(Map<String, dynamic> m) {
    final id = m['problem_id'] as int;
    final steps = (m['approaches'] as List).map((e) => ApproachInfo.fromMap(e as Map<String, dynamic>)).toList();
    return ProblemContent(problemId: id, approaches: steps);
  }
}