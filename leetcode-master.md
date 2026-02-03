# LeetCode Master - Project Plan

> **Project Type:** MOBILE (Flutter)  
> **Primary Agent:** `mobile-developer`  
> **Created:** 2026-02-03

---

## Goal

Build a professional, dark-mode mobile app to master algorithmic patterns for technical interviews. MVP focuses on the Practice flow (categories → problems → solutions) with Firebase Authentication and Premium tier support.

---

## Decisions Made

| Decision | Choice | Rationale |
|----------|--------|-----------|
| State Management | Riverpod | Explicitly requested in APP.md spec |
| Backend | Cloud Run Functions | Full-stack scope confirmed |
| Content Source | Firestore seeded data | Scalable, supports future CMS |
| MVP Scope | Practice + Auth | Core value prop first |
| Phase 2 | Quizzes + Progress | After core is solid |

---

## Tech Stack

| Layer | Technology | Why |
|-------|------------|-----|
| **Mobile** | Flutter 3.38.9 | Cross-platform, performant |
| **State** | flutter_riverpod | Reactive, DI built-in |
| **Auth** | firebase_auth + firebase_ui_auth | OAuth, email, anonymous |
| **Database** | Cloud Firestore | Realtime sync, offline support |
| **Backend** | Cloud Run Functions (Dart/Python) | Serverless, scales to zero |
| **Code Display** | flutter_code_editor | Syntax highlighting, themes |
| **HTTP** | Dio + caching interceptor | Reduces Cloud Run invocations |
| **Local Cache** | Hive | Fast, lightweight |

---

## File Structure

```
leetcode_master/
├── lib/
│   ├── main.dart                    # App entry, providers
│   ├── app.dart                     # MaterialApp, routing, theme
│   ├── config/
│   │   ├── api_config.dart          # API endpoints
│   │   ├── theme.dart               # LeetCode dark theme
│   │   └── constants.dart           # Colors, dimensions
│   ├── components/                  # Reusable widgets
│   │   ├── lcm_button.dart
│   │   ├── lcm_card.dart
│   │   ├── lcm_badge.dart
│   │   ├── lcm_code_block.dart
│   │   └── lcm_list_item.dart
│   ├── features/
│   │   ├── practice/                # MVP
│   │   │   ├── screens/
│   │   │   │   ├── category_list_screen.dart
│   │   │   │   ├── problem_list_screen.dart
│   │   │   │   └── problem_workspace_screen.dart
│   │   │   ├── providers/
│   │   │   │   ├── categories_provider.dart
│   │   │   │   └── problems_provider.dart
│   │   │   └── models/
│   │   │       ├── category.dart
│   │   │       ├── problem.dart
│   │   │       └── approach.dart
│   │   ├── auth/                    # MVP
│   │   │   ├── screens/
│   │   │   │   └── auth_screen.dart
│   │   │   └── providers/
│   │   │       └── auth_provider.dart
│   │   ├── settings/                # MVP
│   │   │   └── screens/
│   │   │       └── settings_screen.dart
│   │   ├── quiz/                    # Phase 2
│   │   └── progress/                # Phase 2
│   ├── services/
│   │   ├── api_service.dart         # Dio client
│   │   ├── cache_service.dart       # Hive wrapper
│   │   └── premium_service.dart     # Subscription logic
│   └── navigation/
│       └── app_router.dart          # go_router config
├── functions/                       # Cloud Run Functions
│   ├── main.py                      # Entry point
│   ├── categories.py                # GET /categories
│   ├── problems.py                  # GET /problems/{category}
│   └── solutions.py                 # GET /solutions/{problem}
├── firestore/
│   ├── seed_data.json               # Initial content
│   └── question_sets.json           # Set definitions (Blind 75, etc.)
├── pubspec.yaml
└── firebase.json
```

---

## Task Breakdown

### Phase 1: Foundation (P0)

- [x] **T1: Flutter Project Setup**
  - Run `flutter create leetcode_master --org com.dsamaster`
  - Add dependencies to `pubspec.yaml`
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** `flutter pub get` succeeds, `flutter run` shows default app

- [x] **T2: Design System & Theme**
  - Create `config/theme.dart` with LeetCode dark palette
  - Create `config/constants.dart` with color constants
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** Theme applied, colors match spec (#282828, #ffa116, etc.)

- [x] **T3: Component Library**
  - Build `LCMButton`, `LCMCard`, `LCMBadge`, `LCMCodeBlock`, `LCMListItem`
  - All components use theme colors only
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** Each component renders correctly in isolation

---

### Phase 2: Backend API (P1)

- [ ] **T4: Firebase Project Setup**
  - Create Firebase project, enable Firestore + Auth
  - Generate `google-services.json` / `GoogleService-Info.plist`
  - **Agent:** `mobile-developer`
  - **Verify:** Firebase console shows project, flutterfire activated

- [ ] **T5: Firestore Data Model**
  - Define collections: `categories`, `problems`, `approaches`, `users`, `question_sets`
  - `question_sets` schema: `{ id: string, name: string, description: string }`
  - `problems` schema: Add `question_set_ids: string[]` (Foreign Keys to `question_sets`)
  - Create `seed_data.json` with 3 categories, 5 problems each
  - **Agent:** `mobile-developer` | **Skill:** `database-design`
  - **Verify:** Firestore console shows seeded data and Sets collection

- [ ] **T6: Cloud Run Functions - Categories API**
  - `GET /categories` → returns list with `is_premium` flag
  - **Agent:** `mobile-developer` | **Skill:** `api-patterns`
  - **Verify:** `curl https://[url]/categories` returns JSON

- [ ] **T7: Cloud Run Functions - Problems API**
  - `GET /problems/{category_id}` → returns problems grouped by difficulty
  - `GET /solutions/{problem_id}` → returns approaches array
  - **Agent:** `mobile-developer` | **Skill:** `api-patterns`
  - **Verify:** Both endpoints return expected structure

---

### Phase 3: Flutter App - Core Features (P2)

- [x] **T8: Navigation Setup**
  - Configure `go_router` with bottom nav (Practice, Quizzes*, Progress*, Settings)
  - *Quizzes/Progress show "Coming Soon" placeholder
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** ✅ Tab switching works, routes resolve correctly

- [ ] **T9: API Service Layer**
  - Create `ApiService` with Dio + caching interceptor
  - 24h TTL cache policy
  - **Agent:** `mobile-developer` | **Skill:** `api-patterns`
  - **Verify:** API calls succeed, second call uses cache

- [x] **T10: Category List Screen** (with mock data)
  - Fetch categories via provider
  - Display as `LCMCard` list with progress bars
  - Show lock icon for premium categories (if user is free)
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** ✅ Categories display, premium lock visible

- [x] **T11: Problem List Screen** (with mock data)
  - Fetch problems for selected category
  - **Filter UI:** Popup Menu in AppBar (right side) to filter by Question Set (e.g., "Blind 75") or "All"
  - **Filter Logic:** Local intersection (Problem's Category == Selected AND Problem's Set IDs contains Filter)
  - **Visuals:** Show active filter indicator button/icon
  - Group by difficulty (Easy/Med/Hard badges)
  - Show checkmark for solved problems
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** ✅ Problems grouped correctly, filter limits list, active filter shown

- [x] **T12: Problem Workspace Screen** (with mock data)
  - Display problem statement + examples + constraints
  - Stepper UI: Approach 1 → 2 → 3
  - `LCMCodeBlock` with language toggle (Python/Java/C++/JS)
  - Unlock logic: Approach N+1 unlocks after viewing N
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** ✅ Stepper progresses, code displays with syntax highlighting

---

### Phase 4: Authentication & Premium (P2)

- [ ] **T13: Firebase Auth Integration**
  - Setup `firebase_ui_auth` with email + Google sign-in
  - Anonymous auth for guest users
  - **Agent:** `mobile-developer`
  - **Verify:** Sign in/out works, user state persists

- [ ] **T14: User State Provider**
  - `AuthProvider` with subscription status
  - Gate premium content based on user tier
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** Free user sees locks, premium user unlocks all

- [x] **T15: Settings Screen**
  - Show auth status, sign in/out button
  - Premium upgrade banner (UI only for MVP)
  - Language preference, cache clear
  - **Agent:** `mobile-developer` | **Skill:** `mobile-design`
  - **Verify:** ✅ Settings UI complete (functionality pending Firebase)

---

### Phase X: Verification (MANDATORY)

- [ ] **Build Verification**
  - `flutter analyze` → 0 errors
  - `flutter build apk --release` → success
  - `flutter build ios --release` (if on macOS)

- [ ] **Runtime Verification**
  - Run on Android emulator/device
  - Run on iOS simulator/device (if available)
  - Complete full flow: Browse → Select Category → View Problem → Progress through Approaches

- [ ] **Rule Compliance**
  - [ ] No emojis in UI (per spec)
  - [ ] Dark mode only (no light theme toggle)
  - [ ] All colors from spec palette

- [ ] **Scripts** (if applicable)
  ```bash
  python .agent/skills/mobile-design/scripts/mobile_audit.py .
  ```

---

## Done When

- [ ] Flutter app runs on Android/iOS
- [ ] Categories load from Cloud Run API
- [ ] Problems display with difficulty badges
- [ ] Approach stepper works with code snippets
- [ ] Firebase Auth sign in/out functional
- [ ] Premium users can access locked content
- [ ] Phase X verification passes

---

## Phase 2 (Future)

| Feature | Priority |
|---------|----------|
| Quiz Screen - Daily Challenge | High |
| Quiz Screen - Weakness Focus | High |
| Progress Screen - Donut Chart | Medium |
| Progress Screen - Category Matrix | Medium |
| Company Tags (Premium) | Low |

---

## Notes

- **Content Strategy:** Seed with Blind 75 problems initially, expand later
- **Monetization:** Premium tier gates Graph/DP categories + certain problems
- **Offline:** Hive cache allows offline browsing of already-loaded content
