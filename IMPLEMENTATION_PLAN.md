# Leetcode Master – Implementation Plan

This plan translates CONTEXT.md into a phased, incremental Flutter implementation. We will build the app in small, well-defined tasks, validating each milestone with concrete acceptance criteria before moving on.

## Goals
- Deliver an engaging, offline-first Flutter app for LeetCode-style learning.
- Implement core flows: Practice, Quizzes, Progress, Settings.
- Model the learning progression: Brute Force → Optimized → Optimal.
- Persist user progress locally (SQLite + shared_preferences).
- Ship polished UI with animations, haptics, and gamification.

## Assumptions
- Flutter SDK is installed and stable channel is used (>= 3.x).
- Initial content (categories, problems, examples) will be seeded locally from JSON bundled with the app; server is not required.
- Premium/IAP can be stubbed initially, with a gated UX; real purchase integration scheduled later.
- Target devices: iOS 15+, Android 8+.

## Architecture & Conventions
- State management: Riverpod or Provider (lightweight, testable). Start with Riverpod.
- Navigation: `go_router` for typed routes and deep links.
- Data: SQLite (sqflite) for persistent entities; shared_preferences for lightweight flags.
- Layering: feature-first folders, with clear separation of models, data, logic, and UI.

```
lib/
  app/
    app.dart
    theme/
    router/
  core/
    models/
    services/
    db/
    utils/
  features/
    practice/
    quizzes/
    progress/
    settings/
  widgets/
assets/
  data/ (seed JSON)
  icons/
  images/
```

## Packages
- Routing: `go_router`
- State: `flutter_riverpod`
- Persistence: `sqflite`, `path_provider`, `shared_preferences`
- UI: `flutter_svg` (icons), `lottie` (animations)
- IAP: `in_app_purchase` (added when ready)
- Dev: `flutter_lints`

---

## Milestone 0 – Project Scaffold
Foundation for development and CI of an offline-first app.

Tasks
- Initialize Flutter project (`leetcode_master`).
- Add core packages and base theme (Material 3 + Cupertino adapt).
- Configure `go_router` with bottom nav tabs (Practice, Quizzes, Progress, Settings).
- Stub screens with placeholders and route names.
- Set up folder structure and analysis options.

Acceptance Criteria
- App runs on iOS/Android with a bottom tab bar and four placeholder screens.
- Routing is centralized; deep links compile.
- Theming matches difficulty colors and accent color.

---

## Milestone 1 – Data Models & Local Seed
Define models and bootstrap local content for categories and problems.

Tasks
- Create core models: Category, Problem, Approach, Difficulty, Progress.
- Define SQLite schema and DAOs for categories/problems/progress.
- Load seed data from `assets/data/*.json` and populate DB on first launch.
- Add shared_preferences keys for lightweight flags (streaks, settings).

Acceptance Criteria
- First launch populates SQLite from JSON.
- Models serialize/deserialize correctly; migrations handled.
- Unit tests for basic DAO operations.

---

## Milestone 2 – Practice: Category Grid
Implement the main learning hub with category browsing.

Tasks
- Build scrollable grid (2 columns portrait, 3 landscape).
- Card UI: icon, name, problem count, circular progress, mini difficulty bar.
- Locked premium categories: overlay + 🔒 with upsell tap.
- Long-press quick stats tooltip; tap navigates to Category Detail.

Acceptance Criteria
- Grid renders all categories with accurate progress stats.
- Premium categories are gated and upsell modal appears.
- Performance is smooth; adaptive layout works.

---

## Milestone 3 – Practice: Category Detail
Drill-down view with progress, description, and problem sections.

Tasks
- Header: back, icon/name, bookmark-all.
- Stats panel: description, % completion, time estimate, mastery level.
- Problem list: Easy/Medium/Hard collapsible sections with card entries.
- Sorting/filter toolbar: difficulty, completion, time estimate, bookmarked.
- Swipe interactions: bookmark, “Want to Review”.

Acceptance Criteria
- Problems grouped correctly; counts and completion reflect DB state.
- Sorting/filtering work and persist in session.
- Swipe actions update state and UI immediately.

---

## Milestone 4 – Problem Overview
Overview screen with statement, constraints, status, approaches, community stats.

Tasks
- Header: title, difficulty badge, bookmark/share actions.
- Cards: Problem Statement, Constraints, Your Status (Not Started/In Progress/Completed).
- Approaches: Brute Force, Optimized, Optimal cards with lock/progression states.
- Sticky footer CTA (Start/Continue/Review) based on status.

Acceptance Criteria
- Status reflects user progress; CTA text updates accordingly.
- Approach gating enforces completion sequence.
- Share copies a deep link route.

---

## Milestone 5 – Solution Learning Screen
Immersive learning experience per approach with progression and XP.

Tasks
- Top bar: exit with confirmation, stepper (1/3, 2/3, 3/3), scroll progress.
- Content sections: Overview, Complexity analysis (expanders), Step-by-step, Code block, Interactive example.
- Optimal approach: “THE TRICK” special section.
- Bottom bar: Mark as Understood, progress dots, Next Approach unlock.
- Gamification: confetti, haptics, sounds; XP notifications.

Acceptance Criteria
- “Mark as Understood” updates DB and unlocks next approach.
- Interactive example steps through with variable tracker.
- Confetti and haptic feedback trigger on completion.

---

## Milestone 6 – Quizzes
Pattern recognition challenges with Daily Challenge and timed sessions.

Tasks
- Quiz Home: streak indicator, Daily Challenge hero, CTA.
- Quiz Session: timed UI, question types, options, submit/next.
- Scoring, XP rewards, and completion summary.
- Leaderboard hooks (local-only placeholder).

Acceptance Criteria
- Daily Challenge runs with timer and reward multipliers.
- Results persist to history; streak increments correctly.
- UX is responsive under time pressure.

---

## Milestone 7 – Progress Screen
Personal statistics, achievements, and mastery visualization.

Tasks
- Stats: total problems, completion %, time benchmarks.
- Achievements: unlock modals and progress.
- Category mastery visualization; streak tracking.

Acceptance Criteria
- Stats aggregate from DB; charts render correctly.
- Achievement unlocks trigger UI and persistence.
- Streak logic matches quiz activity.

---

## Milestone 8 – Settings & Preferences
User preferences, subscription management, and support.

Tasks
- Preferences: sound, haptics, theme, language (stub), data reset.
- Subscription: upsell, status, restore purchases.
- Support: FAQ, feedback link.

Acceptance Criteria
- Preferences toggle and persist via shared_preferences.
- Premium status toggles gating in Practice and Approaches.
- Reset clears local DB and flags with confirmation.

---

## Milestone 9 – Premium/IAP Integration
Implement real purchase flow and entitlement checks.

Tasks
- Integrate `in_app_purchase` for Android/iOS.
- Entitlement cache and fail-safe states.
- Upsell flow polish and error handling.

Acceptance Criteria
- Purchase completes; entitlement persists locally.
- Locked content unlocks consistently across app launch cycles.
- Store error cases handled gracefully.

---

## Milestone 10 – Polish & Performance
Animations, assets, accessibility, and performance tuning.

Tasks
- Icons/illustrations; lottie animations; micro-interactions.
- Accessibility: semantics, large fonts, contrast.
- Performance: list virtualization, image caching, DB indexing.

Acceptance Criteria
- 60fps animations on mid-tier devices.
- A11y checks pass for text scaling and contrast.
- Cold start and navigation latency within targets.

---

## Data & Persistence Details
- SQLite tables: categories, problems, approaches, progress, quizzes, achievements.
- Migrations: versioned, idempotent; schema evolves safely.
- Seeding: one-time import from `assets/data` with checksum to prevent duplicates.
- Caching: in-memory providers; invalidate on updates.

---

## Testing & QA
- Unit: models, DAOs, gating logic.
- Widget: key screens (Practice grid, Category detail, Problem overview, Learning).
- Golden tests: critical UI states.
- Manual QA checklist per milestone; lightweight E2E smoke.

---

## Security & Privacy
- All data local; no PII beyond optional name/avatar.
- No network access required; IAP-only external calls when enabled.
- Clear reset/erase capability in Settings.

---

## Release Plan
- Internal alpha per milestone; gather feedback.
- Beta after Milestone 7 (core features usable).
- v1.0 after Milestone 10 with IAP live.

---

## Task Board (Initial)
We will work one task at a time and update this list as we proceed.

1) Scaffold Flutter project with tabs and routing
   - Outcome: Running app with four tabs and placeholder screens.
   - Est.: 0.5–1 day
   - DoD: Build succeeds; routes and theme configured.

2) Define models and seed local DB from JSON
   - Outcome: SQLite populated on first run; DAOs tested.
   - Est.: 1–2 days
   - DoD: CRUD works; unit tests pass.

3) Implement Practice category grid with progress and locks
   - Outcome: Browsable categories; premium gating upheld.
   - Est.: 1–2 days
   - DoD: Smooth scroll; correct stats; upsell modal.

4) Build Category detail with grouped problems and filters
   - Outcome: Collapsible sections; swipe actions; filters persist.
   - Est.: 1–2 days
   - DoD: Accurate counts; state updates instantly.

5) Create Problem overview with approach gating and CTA
   - Outcome: Status-driven UI; deep link share.
   - Est.: 1–1.5 days
   - DoD: Brute→Optimized→Optimal enforced.

6) Implement Learning screen with interactive example and XP
   - Outcome: Stepper, code viewer, variable tracker, confetti.
   - Est.: 2–3 days
   - DoD: DB progress updates; unlock flow reliable.

7) Quizzes: Home, sessions, scoring, streaks
   - Outcome: Daily Challenge and session flow with persistence.
   - Est.: 2–3 days
   - DoD: Timer and rewards correct; history saved.

8) Progress screen: stats, achievements, mastery
   - Outcome: Charts and achievements with unlock UX.
   - Est.: 1–2 days
   - DoD: Aggregations correct; polish.

9) Settings: preferences and reset
   - Outcome: Toggles persist; reset works safely.
   - Est.: 0.5–1 day
   - DoD: All toggles functional; confirmation flows.

10) Premium/IAP integration
   - Outcome: Purchases unlock content reliably.
   - Est.: 2–3 days
   - DoD: Store flows stable; entitlement persisted.

11) Polish, performance, accessibility
   - Outcome: Production-quality UX.
   - Est.: 2–3 days
   - DoD: Performance and a11y pass checks.

---

## Next Action
- Start Task 1: Scaffold Flutter project with tabs and routing.
- I will create the project, add core packages, and wire up the bottom navigation with placeholder screens to match CONTEXT.md.