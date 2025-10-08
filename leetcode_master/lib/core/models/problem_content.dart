class ConstraintInfo {
  final String name;
  final String value;
  final String explanation;

  const ConstraintInfo({this.name = '', this.value = '', this.explanation = ''});
}

class TestCaseInfo {
  final String name;
  final String? inputJson;
  final String output;
  final String? explanation;

  const TestCaseInfo({this.name = '', this.inputJson, this.output = '', this.explanation});
}

class ComparisonRowInfo {
  final String approach;
  final String time;
  final String space;
  final List<String> pros;
  final List<String> cons;

  const ComparisonRowInfo({
    this.approach = '',
    this.time = '',
    this.space = '',
    this.pros = const [],
    this.cons = const [],
  });
}

class ComparisonTableInfo {
  final List<String> columns;
  final List<ComparisonRowInfo> rows;

  const ComparisonTableInfo({this.columns = const ['Approach', 'Time', 'Space', 'Pros', 'Cons'], this.rows = const []});
}

class ApproachInfo {
  final String key; // 'brute_force' | 'optimized' | 'optimal'
  final String name;
  final String? codingPattern;
  final String timeComplexity;
  final String? timeExplanation;
  final String spaceComplexity;
  final String? spaceExplanation;
  final String explanation;
  final String? trickSummary;
  final List<String> trickDetails;
  final List<String> pros;
  final List<String> cons;
  final String? code; // first implementation code snippet (fallback)
  final Map<String, String> implementations; // language -> code

  const ApproachInfo({
    this.key = '',
    this.name = '',
    this.codingPattern,
    this.timeComplexity = '',
    this.timeExplanation,
    this.spaceComplexity = '',
    this.spaceExplanation,
    this.explanation = '',
    this.trickSummary,
    this.trickDetails = const [],
    this.pros = const [],
    this.cons = const [],
    this.code,
    this.implementations = const {},
  });
}

class ProblemContent {
  final int problemId;
  final String statement;
  final String inputFormat;
  final String outputFormat;
  final List<ConstraintInfo> constraints;
  final List<String> notes;
  final List<TestCaseInfo> testCases;
  final List<ApproachInfo> approaches;
  final ComparisonTableInfo? comparisonTable;

  const ProblemContent({
    required this.problemId,
    this.statement = '',
    this.inputFormat = '',
    this.outputFormat = '',
    this.constraints = const [],
    this.notes = const [],
    this.testCases = const [],
    this.approaches = const [],
    this.comparisonTable,
  });
}