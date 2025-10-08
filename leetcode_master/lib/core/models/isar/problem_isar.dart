import 'package:isar_community/isar.dart';

part 'problem_isar.g.dart';

@Collection()
class ProblemIsar {
  Id id; // problem id

  // Top-level fields from template
  int categoryId;
  String categoryName;
  String title;
  String difficulty; // "easy" | "medium" | "hard"
  int estimatedMinutes;
  bool isPremium;
  bool isNeetcode150;
  bool isBlind75;

  // Content object from template
  ContentIsar? content;

  // Top-level lists from template
  List<TestCaseIsar> testCases;
  List<ApproachIsar> approaches;

  // Comparison table from template
  ComparisonTableIsar? comparisonTable;

  ProblemIsar({
    required this.id,
    required this.categoryId,
    this.categoryName = '',
    required this.title,
    required this.difficulty,
    this.estimatedMinutes = 15,
    this.isPremium = false,
    this.isNeetcode150 = false,
    this.isBlind75 = false,
    ContentIsar? content,
    this.testCases = const [],
    this.approaches = const [],
    this.comparisonTable,
  }) : content = content ?? ContentIsar();
}

@Embedded()
class ContentIsar {
  String statement;
  String inputFormat;
  String outputFormat;
  List<ConstraintIsar> constraints;
  List<String> notes;

  ContentIsar({
    this.statement = '',
    this.inputFormat = '',
    this.outputFormat = '',
    this.constraints = const [],
    this.notes = const [],
  });
}

@Embedded()
class ConstraintIsar {
  String name;
  String value;
  String explanation;

  ConstraintIsar({
    this.name = '',
    this.value = '',
    this.explanation = '',
  });
}

@Embedded()
class TestCaseIsar {
  String name;
  String? inputJson; // store input as JSON string for simplicity
  String output;
  String? explanation;

  TestCaseIsar({
    this.name = '',
    this.inputJson,
    this.output = '',
    this.explanation,
  });
}

@Embedded()
class ApproachIsar {
  String key; // 'brute_force' | 'optimized' | 'optimal'
  String name;
  String? codingPattern;

  String timeComplexity;
  String? timeExplanation;
  String? timeExplanationForQuiz;

  String spaceComplexity;
  String? spaceExplanation;
  String? spaceExplanationForQuiz;

  String explanation;
  String? trickSummary;
  List<String> trickDetails;
  List<String> pros;
  List<String> cons;
  List<ImplementationIsar> implementations;

  ApproachIsar({
    this.key = '',
    this.name = '',
    this.codingPattern,
    this.timeComplexity = '',
    this.timeExplanation,
    this.timeExplanationForQuiz,
    this.spaceComplexity = '',
    this.spaceExplanation,
    this.spaceExplanationForQuiz,
    this.explanation = '',
    this.trickSummary,
    this.trickDetails = const [],
    this.pros = const [],
    this.cons = const [],
    this.implementations = const [],
  });
}

@Embedded()
class ImplementationIsar {
  String language; // python|javascript|java|cpp
  String code;

  ImplementationIsar({
    this.language = 'python',
    this.code = '',
  });
}

@Embedded()
class ComparisonRowIsar {
  String approach;
  String time;
  String space;
  List<String> pros;
  List<String> cons;

  ComparisonRowIsar({
    this.approach = '',
    this.time = '',
    this.space = '',
    this.pros = const [],
    this.cons = const [],
  });
}

@Embedded()
class ComparisonTableIsar {
  List<String> columns;
  List<ComparisonRowIsar> rows;

  ComparisonTableIsar({
    this.columns = const ['Approach', 'Time', 'Space', 'Pros', 'Cons'],
    this.rows = const [],
  });
}

// Quiz materialized collections

@Collection()
class QuizPatternMapIsar {
  Id id; // auto or problemId composite key materialized as Id

  int problemId;
  String optimalApproachKey;
  String optimalApproachName;
  String? optimalCodingPattern;

  String difficulty;
  int categoryId;
  bool isPremium;

  QuizPatternMapIsar({
    required this.id,
    required this.problemId,
    required this.optimalApproachKey,
    required this.optimalApproachName,
    this.optimalCodingPattern,
    required this.difficulty,
    required this.categoryId,
    required this.isPremium,
  });
}

@Collection()
class QuizApproachIdentifierIsar {
  Id id; // unique per (problemId, approachKey, language)

  int problemId;
  String approachKey;
  String approachName;
  String language;
  String codeSnippetShort;

  QuizApproachIdentifierIsar({
    required this.id,
    required this.problemId,
    required this.approachKey,
    required this.approachName,
    required this.language,
    required this.codeSnippetShort,
  });
}

@Collection()
class QuizComplexityFactsIsar {
  Id id; // unique per (problemId, approachKey)

  int problemId;
  String approachKey;
  String timeComplexity;
  String? timeExplanationForQuiz;
  String spaceComplexity;
  String? spaceExplanationForQuiz;

  QuizComplexityFactsIsar({
    required this.id,
    required this.problemId,
    required this.approachKey,
    required this.timeComplexity,
    this.timeExplanationForQuiz,
    required this.spaceComplexity,
    this.spaceExplanationForQuiz,
  });
}