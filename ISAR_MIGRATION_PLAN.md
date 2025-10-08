# ISAR Migration Plan

This document outlines a step-by-step plan to migrate the app’s local storage from SQLite (`sqflite`) to Isar NoSQL. The plan covers data modeling, dependency changes, initialization, import strategy, repository refactors, performance/indexes, testing, rollout, and backout.

## Goals
- Unify data access across Android/iOS/Desktop/Web.
- Improve read performance and reduce query boilerplate with typed models.
- Map existing hierarchical problem JSONs cleanly to embedded documents.
- Preserve quiz-fast reads via precomputed, indexed collections.

## Scope
- Replace `sqflite` usage with Isar.
- Migrate data model from normalized SQL tables to embedded/linked Isar collections.
- Move first-run import to Isar from JSON assets (or a single aggregated JSON).
- Remove JSON web fallback; Isar supports IndexedDB on web.
- Keep Python factory tooling for generating JSONs; adjust asset pipeline.

## Data Model Design

### Approach: Embedded-first (recommended)
- Store most nested structures as embedded objects inside a `Problem` document for simple reads.
- Materialize quiz-specific data into dedicated collections for O(1) quiz queries without loading full problems.

### Collections and Embedded Types

- Collection: `Problem`
  - Fields: `id (int, primary)`, `title (String)`, `difficulty (String)`, `isPremium (bool)`, `isNeetcode150 (bool)`, `isBlind75 (bool)`, `categoryId (int)`, `categoryName (String)`
  - Content: `statement (String)`, `inputFormat (String)`, `outputFormat (String)`
  - Embedded: `constraints (List<Constraint>)`, `testCases (List<TestCase>)`, `approaches (List<Approach>)`, `comparisonRows (List<ComparisonRow>)`
  - Indexes: `id`, `categoryId`, `difficulty`, `isPremium`

- Embedded: `Constraint`
  - `name (String)`, `value (String)`, `explanation (String)`

- Embedded: `TestCase`
  - `name (String)`, `inputJson (Map<String, dynamic> or String)`, `output (String)`, `explanation (String)`
  - Note: Prefer Isar JSON support for `inputJson`; alternatively store as `String`.

- Embedded: `Approach`
  - `key (String) // 'brute_force' | 'optimized' | 'optimal'`
  - `name (String)`
  - `codingPattern (String? // unified pattern field from template)`
  - `timeComplexity (String)`, `timeExplanation (String)`, `timeExplanationForQuiz (String?)`
  - `spaceComplexity (String)`, `spaceExplanation (String)`, `spaceExplanationForQuiz (String?)`
  - `explanation (String)`
  - `trickSummary (String?)`, `trickDetails (List<String>)`
  - `pros (List<String>)`, `cons (List<String>)`
  - `implementations (List<Implementation>)`

- Embedded: `Implementation`
  - `language (String // python|javascript|java|cpp)`, `code (String)`

- Embedded: `ComparisonRow`
  - `approach (String)`, `time (String)`, `space (String)`, `pros (List<String>)`, `cons (List<String>)`

- Collection: `QuizPatternMap`
  - `problemId (int)`, `optimalApproachKey (String)`, `optimalApproachName (String)`
  - `optimalCodingPattern (String?)`, `difficulty (String)`, `categoryId (int)`, `isPremium (bool)`
  - Indexes: `(categoryId, difficulty, isPremium)`, `problemId`

- Collection: `QuizApproachIdentifier`
  - `problemId (int)`, `approachKey (String)`, `approachName (String)`
  - `language (String)`, `codeSnippetShort (String)`
  - Indexes: `(problemId, approachKey, language)`

- Collection: `QuizComplexityFacts`
  - `problemId (int)`, `approachKey (String)`
  - `timeComplexity (String)`, `timeExplanationForQuiz (String?)`
  - `spaceComplexity (String)`, `spaceExplanationForQuiz (String?)`
  - Indexes: `(problemId, approachKey)`

## Dependency Changes
- Add to `pubspec.yaml`:
  - `isar_community`
  - `isar_community_flutter_libs`
  - `isar_community_generator` (dev)
  - `build_runner` (dev)
- Remove: `sqflite` and `path_provider` (keep if used elsewhere; Isar can operate without it).
- Keep: `shared_preferences`, `go_router`, etc.

## Code Changes (High-Level)

### 1) Define Isar Models
- Create model files under `leetcode_master/lib/core/models/isar/`:
  - `problem_isar.dart` with `@collection` `ProblemIsar` and embedded types.
  - Add `part 'problem_isar.g.dart';` and run codegen.
- Mirrors the fields from the current template; ensure types match usage.

### 2) Isar Database Initialization
- Create `leetcode_master/lib/core/db/isar_database.dart`:
  - Open Isar with the schemas for all collections.
  - Handle schema versioning and migrations.
  - Provide `IsarDatabase.instance.isar` getter.

### 3) First-Run Import Strategy
- Assets: choose one of:
  - A) Aggregate JSON asset `assets/data/all_problems.json` containing an array of problems.
  - B) Directory-based assets `assets/data/problem_content/` (already in `pubspec.yaml`), which include per-problem JSONs.
- Import pipeline:
  - Detect empty Isar (`count` == 0).
  - Load JSON(s) from assets via `rootBundle`.
  - Parse into `ProblemIsar` + embedded types.
  - Compute quiz materialized records (optimal coding pattern, snippets, complexity facts).
  - Batch insert with `writeTxn` + `putAll()` in chunks.

### 4) Repository Refactor
- Replace `AppDatabase` with `IsarDatabase`.
- Update `ProblemRepository` methods:
  - `fetchProblemsByCategory(categoryId)` → Isar filter on `ProblemIsar.categoryId` and sort by `id`.
  - `countByCategory(categoryId)` → `isar.problemIsars.filter().categoryIdEqualTo(categoryId).count()`.
  - `fetchAllProblems()` → `isar.problemIsars.where().sortById().findAll()`.
  - `findById(id)` → `isar.problemIsars.get(id)` or filter by id.
- Decide whether UI uses Isar model directly or map to existing `Problem` DTO.

### 5) Quiz Queries
- Pattern Matcher: query `QuizPatternMap` by `(categoryId, difficulty, isPremium)`.
- Approach Identifier: query `QuizApproachIdentifier` by `problemId` + `language`.
- Complexity Quiz: query `QuizComplexityFacts` by `problemId` or `approachKey`.
- Ensure appropriate composite indexes.

### 6) Remove SQLite Path
- Deprecate `assets/data/problems.db` usage, `AppDatabase`, and `sqflite` imports.
- Remove JSON web fallback; Isar supports web via IndexedDB.

## Indexing Plan
- `ProblemIsar` indexes: `id (primary)`, `categoryId`, `difficulty`, `isPremium`.
- `QuizPatternMap`: composite `(categoryId, difficulty, isPremium)`.
- `QuizApproachIdentifier`: composite `(problemId, approachKey, language)`.
- `QuizComplexityFacts`: composite `(problemId, approachKey)`.
- Avoid indexing large text fields (e.g., code, explanations).

## Migration & Migrations (Schema Evolution)
- Start at schema version `1`.
- For future changes, add migration steps to transform/add fields.
- Use Isar’s migration hooks to add new fields with defaults and backfill materialized quiz collections.

## Testing Plan
- Unit tests:
  - Model round-trip: JSON → Isar models → stored → fetched → mapped to UI models.
  - Repository methods: category filters, counts, find by id.
  - Quiz queries: correctness and performance.
- Integration tests:
  - First-run import success and idempotency.
  - App boot and navigation still work.
- Performance tests:
  - Measure cold/warm query latency vs SQLite.

## Rollout Plan
- Phase 0: Branch creation `feature/isar-migration`.
- Phase 1: Add dependencies, models, codegen, and Isar init.
- Phase 2: Implement importer (assets → Isar) and materialize quiz collections.
- Phase 3: Refactor repositories to Isar; preserve DTOs if needed.
- Phase 4: Replace app wiring (remove `AppDatabase`, ensure feature pages compile).
- Phase 5: Test locally on iOS/Android/Desktop/Web.
- Phase 6: Remove SQLite assets and dependencies.
- Phase 7: Merge after review.

## Asset Strategy
- Preferred: Keep per-problem JSONs under `leetcode_master/assets/data/problem_content/` and import them on first run.
- Alternative: Generate `all_problems.json` for faster single-read import.
- Categories: mirror `categories.json` into Isar or keep as asset if used purely for UI.

## Risks & Mitigations
- Large import time: batch in chunks (e.g., 250–500 docs/txn), show “data setup” progress UI.
- Web bundle size: prefer aggregated JSON, gzip assets.
- Schema changes: versioning + migration helpers; materialized quiz collections rebuilt in migration.
- Codegen friction: add build scripts and CI step for `build_runner`.

## Backout Plan
- Keep SQLite code for one release behind a feature flag; allow toggling data source.
- If issues arise, revert repository to use `AppDatabase` and `problems.db` asset.

## Deliverables
- Isar models and generated code.
- Isar initializer and first-run importer.
- Updated repositories and feature wiring.
- Tests for import and queries.
- Removal of SQLite assets and code.

## Commands & Scripts
- Add dependencies and run codegen:
  - `flutter pub add isar_community isar_community_flutter_libs`
  - `flutter pub add --dev isar_community_generator build_runner`
  - `flutter pub run build_runner build --delete-conflicting-outputs`
- Optional: a one-off Dart script to pre-import JSONs for desktop dev.

## Timeline (Estimate)
- Day 1–2: Models, dependencies, initializer.
- Day 3: Import pipeline and quiz materialization.
- Day 4: Repository refactor and UI wiring.
- Day 5: Tests, performance tuning, cleanup.