# App Design Document: Leetcode Master

## 1. App Overview & Philosophy

**App Name**: Leetcode Master
**Theme**: **Dark Mode Only** (Strict adherence to LeetCode's dark aesthetic).
**Core Philosophy**: A professional, distraction-free environment to master algorithmic patterns. The app guides users from Brute Force to Optimized to Optimal solutions, focusing on pattern recognition rather than rote memorization.

**Target Audience**:

* Software Engineers preparing for technical interviews.
* Developers seeking to refine algorithmic intuition.

### 1.1 Tech Stack & Architecture

* **Framework**: Flutter (Android & iOS).
* **State Management**: `flutter_riverpod` (Riverpod) for reactive state and dependency injection.
* **Backend**: Cloud Run Functions for Firebase (API Layer).
* **Database**: Cloud Firestore (User data, progress).
* **Authentication**: `firebase_auth` & `firebase_ui_auth` (Optional login, required for Premium/Sync).
* **Code Display**: `flutter_code_editor` for syntax-highlighted, read-only code snippets.
* **Networking**: HTTP client (e.g., Dio) with caching interceptors to reduce Cloud Run invocations.
* **Config**: API Endpoint URLs defined in a dedicated `api_config.dart` file for easy environment switching.

### 1.2 Design System & Components

**Visual Style (LeetCode Imitation)**:

* **Backgrounds**: Dark Grey (`#282828`), Black (`#1A1A1A` for code blocks).
* **Accents**: LeetCode Orange (`#ffa116`) for primary actions/active states.
* **Text**: Off-white (`#eff2f5`) for primary text, Grey (`#8c8c8c`) for secondary.
* **Typography**: Clean Sans-Serif (Inter/Roboto) for UI; Monospace (JetBrains Mono/Fira Code) for code.
* **No Emojis**: strict prohibition on emojis; use Material symbols or text badges.

**Component Strategy**:
To ensure consistency and maintainability, the app will rely on a strict set of reusable widgets defined in a `components/` directory:

* `LCMButton` (Primary, Secondary, Ghost variants).
* `LCMCard` (Standard background, rounded corners, padding).
* `LCMBadge` (Difficulty indicators: Easy/Med/Hard).
* `LCMCodeBlock` (Wrapper around `flutter_code_editor`).
* `LCMListItem` (Standard list tile for problems/categories).

---

## 2. Data Layer & API Strategy

**Cloud Run Functions**:

* All static content (Categories, Questions, Solutions, Code Snippets) is fetched via REST endpoints hosted on Cloud Run.

**Caching Mechanism**:

* To minimize Cloud Run costs and improve speed, the app implements a local cache (e.g., `hive` or memory cache via Riverpod `keepAlive`).
* **Policy**: Fetch fresh data only if cache is expired (e.g., 24h TTL) or manually refreshed.

**Premium Logic**:

* API responses include a `is_premium` boolean flag for categories and questions.
* Front-end logic hides or locks these items based on the user's subscription status in Firebase Auth.

---

## 3. Main Navigation Structure

### 3.1 Global Navigation

**Bottom Navigation Bar**: Dark Grey background, unselected icons grey, selected icons Orange (`#ffa116`).

**Four Main Tabs**:

1. **Practice** (List Icon) - Pattern-based learning.
2. **Quizzes** (Lightning Icon) - Random or targeted sets.
3. **Progress** (Chart Icon) - Analytics.
4. **Settings** (Gear Icon) - Account & Config.

---

## 4. Practice Screen - Category Browser

### 4.1 Category View (Tree Structure)

**Layout**: Vertical list of `LCMCard` components representing data structures/patterns.

**Data Source**: `GET /categories` (Cached).

**Category Card Component**:

* **Left**: Category Icon (Minimalist vector, white/grey).
* **Center**:
* Title: e.g., "Arrays & Hashing".
* Progress Bar: Thin line, Orange fill.
* Stats: "8/12" text.


* **Right**:
* Chevron icon.
* *Conditional*: Lock Icon (If category is `is_premium` and user is Free).



**Categories**:

* Arrays & Hashing
* Two Pointers
* Sliding Window
* Stack
* Binary Search
* Linked List
* Trees
* Tries
* Heap / Priority Queue
* Backtracking
* Graphs
* 1-D / 2-D DP
* Bit Manipulation
* Math & Geometry

### 4.2 Category Detail & Problem List

**Header**:

* Title & Description.
* Estimated mastery time.

**Problem List (Grouped by Difficulty)**:

* **Easy** (Green Text Badge)
* **Medium** (Yellow Text Badge)
* **Hard** (Red Text Badge)

**Problem Item Component**:

* **Status Indicator**: Checkmark (Solved), Empty Circle (Unsolved).
* **Title**: "1. Two Sum".
* **Premium Indicator**: Small "Premium" text badge (if applicable).

---

## 5. Problem Workspace & Learning Flow

### 5.1 Problem Overview

**Layout**:

1. **Problem Statement**: Text description using standard markdown rendering.
2. **Examples**: Grey blocks (`#3a3a3a`) showing Input/Output.
3. **Constraints**: Bulleted list of bounds.

**Action**: "Start Learning" button (Orange).

### 5.2 Learning Approaches (The Core Loop)

Instead of emojis or gamification, use a stepper interface: `Approach 1` -> `Approach 2` -> `Approach 3`.

**Approach 1: Brute Force** (Default Unlocked)

* **Badge**: `Time: O(n^2)` | `Space: O(1)`
* **Visuals**: Static diagram or text explanation.
* **Code**: `LCMCodeBlock` displaying the brute force solution.
* **Action**: "Mark as Read & Next".

**Approach 2: Optimized** (Unlocks after Brute Force)

* **Condition**: User must view Approach 1 to unlock.
* **Badge**: `Time: O(n log n)` | `Space: O(n)`
* **Comparison**: Text explaining why this is better than Approach 1.
* **Code**: `LCMCodeBlock`.

**Approach 3: Optimal** (Unlocks after Optimized)

* **Badge**: `Time: O(n)` | `Space: O(n)`
* **"The Pattern"**: A highlighted text box explaining the specific algorithmic trick (e.g., "Use a HashMap to store complements").
* **Code**: `LCMCodeBlock`.

### 5.3 Code Snippet Component (`flutter_code_editor`)

* **Theme**: Dracula or Monokai (matches Dark Mode).
* **Features**:
* Read-only.
* Syntax highlighting.
* Copy to clipboard button.
* Language toggle (Python, Java, C++, JavaScript) - selection persists via Riverpod/SharedPrefs.



---

## 6. Quizzes Screen

**Purpose**: Test knowledge without the guided "Approach" hand-holding.

**Modes**:

1. **Daily Challenge**: One random problem fetched from API.
2. **Weakness Focus**: Generates a set of 5 problems from categories where the user has low completion rates.

**Quiz Interface**:

* Shows Problem Statement only.
* User must "Mentally Solve" or "Reveal Solution".
* "Reveal Solution" jumps to the Optimal Approach view of the Problem Workspace.

---

## 7. Progress Screen

**Data Source**: Cloud Firestore (User Document).

**Anonymous vs Authenticated**:

* **Anonymous**: Shows local session stats (temporarily stored). Prompt to "Sign In to Save Progress".
* **Authenticated**: Syncs with Firestore.

**Metrics**:

* **Donut Chart**: Total Solved / Total Available.
* **Difficulty Breakdown**: Easy/Med/Hard counts.
* **Category Matrix**: Grid showing completion % per category.

---

## 8. Settings & Authentication

### 8.1 Authentication (Firebase UI)

* **Status**: "Not Signed In" or "User Email".
* **Actions**:
* Sign In / Register (if anonymous).
* Sign Out (if logged in).


* **Rationale**: Auth is optional for basic usage, required for Premium features and cross-device sync.

### 8.2 Premium (Monetization)

* **Upgrade Banner**: Visible if user is Free tier.
* **Features**:
* Unlock advanced categories (Graph, DP).
* Unlock specific "Company Tagged" questions (future feature).


* **Payment**: Calls Cloud Function to handle payment provider intent (Stripe/RevenueCat logic).

### 8.3 Application Preferences

* **Language**: Default coding language for snippets.
* **Cache**: "Clear Offline Cache" button.
* **Version**: App version string.
* **Legal**: Terms & Privacy Policy links.

---

## 9. Color Palette Reference

| Color Name | Hex Code | Usage |
| --- | --- | --- |
| **Background** | `#282828` | Main Scaffold Background |
| **Card Bg** | `#3a3a3a` | Component Backgrounds |
| **Primary** | `#ffa116` | Buttons, Active Icons, Highlights |
| **Text Main** | `#eff2f5` | Headings, Body Text |
| **Text Muted** | `#8c8c8c` | Metadata, Unselected Icons |
| **Easy** | `#00b8a3` | Difficulty Badge |
| **Medium** | `#ffc01e` | Difficulty Badge |
| **Hard** | `#ff375f` | Difficulty Badge |