DSA Master — Development Plan

Goal
- Build a Flutter app (Android-first, multi-platform ready) that integrates Supabase for auth, data, and realtime features, following CONTEXT.md.

Guiding Principles
- Ship in small, verifiable increments; one focused task at a time.
- Keep scope tight per milestone; defer non-essentials.
- Follow Flutter docs for project setup and Supabase Flutter docs for client usage.

Naming and Structure
- App folder name: `dsa_master_app` (replaces the placeholder `leetcode_app` in CONTEXT.md).
- Create the Flutter app inside the project root: `/Users/mfreliszka/Dev/dsa_master/dsa_master_app`.

Environment
- Use `.env` at project root for secrets managed locally (already present).
- Keys used by the app: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, optional Google client IDs.
- Load values in Flutter via `flutter_dotenv`.

Milestones and Tasks

0) Workstation and Project Prep
- Verify Flutter SDK installed and `flutter doctor` passes.
- Confirm Supabase project exists and credentials in `.env` are valid.
- Decide minimum supported SDK versions; Android minSdk 21+.

1) Scaffold Flutter App (multi-platform)
- Command: `flutter create dsa_master_app` (web/desktop support included by default).
- Run app on Android emulator to ensure baseline build.

2) Add Core Dependencies and Config
- Add packages: `supabase_flutter`, `flutter_dotenv`, `go_router`.
- Configure assets and env loading in `pubspec.yaml`.
- Create `lib/core/config/env.dart` and `lib/core/config/supabase_client.dart`.
- Initialize `Supabase` in `main.dart` using env variables.

3) App Shell and Routing
- Add `lib/app.dart` with `MaterialApp` and themes (light/dark).
- Add `lib/core/routing/app_router.dart` using `go_router`.
- Create placeholder pages: welcome, login, home.

4) Auth (MVP)
- Email/password sign-up/sign-in via `supabase_flutter`.
- Basic session persistence and redirect to home on sign-in.

5) Data Reads (Explore + Problems)
- Create read-only repositories for categories, problems, and approaches.
- Display categories and a problem list; page stubs per CONTEXT.md.

6) Practice Flow (Stub)
- Show problem detail with constraints, hints, and approaches content.
- Track user progress flags locally; wire Supabase tables later.

7) Progress and Achievements (Phase 1)
- Display streak calendar and achievements grid with mock data.
- Prepare repository interfaces for later Supabase integration.

8) Subscriptions (Phase 1)
- Add premium upsell page; stub purchase service (no Google Play yet).

9) Integration and RLS (Phase 2)
- Implement RLS-backed user tables; wire reads/writes.
- Add XP ledger updates and level compute via backend functions.

10) Polish, QA, and Release Prep
- Basic error handling, loading states, and analytics hooks.
- Build and test on Android; prepare Play Store artifacts (future).

Folder Layout (target)
- Mirror the feature-first, clean architecture in CONTEXT.md under `lib/`.
- Use `core/`, `shared/`, `features/`, and `state/` directories.

Dependencies and Snippets
- Add packages:
  - `flutter pub add supabase_flutter flutter_dotenv go_router`
- Supabase init example:
  - In `main.dart`: call `Supabase.initialize(url: envUrl, anonKey: envKey);`
- Env loader example:
  - Load `.env` early with `DotEnv().load()` and read `SUPABASE_URL`, `SUPABASE_ANON_KEY`.

Acceptance Criteria per Early Milestones
- 1) App scaffolds and runs a blank screen on Android.
- 2) Supabase initializes successfully using `.env` values; no runtime errors.
- 3) Router navigates between Welcome, Login, and Home.
- 4) Email auth works and session persists; home greets the user.

Immediate Next Step
- Scaffold the Flutter app: `flutter create dsa_master_app` at project root.