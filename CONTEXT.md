# Leetcode Master - Complete App Documentation

## 1. App Overview & Philosophy

**App Name**: Leetcode Master

**Core Philosophy**: Transform LeetCode preparation from a chore into an engaging journey. Users don't just memorize solutions—they understand the evolution from brute force through optimized to optimal, building intuition for pattern recognition.

**Target Audience**: 
- Software engineering students preparing for technical interviews
- Job seekers targeting FAANG and top tech companies
- Developers wanting to strengthen algorithmic thinking and problem-solving skills

### 1.1 Technical Stack
- **Platform**: Cross-platform mobile app (Android & iOS) built with Flutter
- **Design System**: 
  - Android: Material Design 3 components
  - iOS: Cupertino design patterns
- **Architecture**: Frontend and backend logic in Flutter
- **Storage**: 
  - SQLite with sqflite plugin (https://pub.dev/packages/sqflite) for problem database, user solutions, and quiz history
  - shared_preferences plugin for lightweight key-value storage (settings, flags, streaks)
- **Data Persistence**: Fully offline-first architecture; all user progress saved locally on device
- **Monetization**: Freemium model with in-app purchase for premium subscription to unlock advanced categories

### 1.2 Color Palette & Visual Identity
- **Difficulty Colors**:
  - Easy: Green (#4CAF50)
  - Medium: Orange (#FF9800)
  - Hard: Red (#F44336)
- **Accent Color**: Blue (#2196F3) for active states and CTAs
- **Approach Icons**:
  - Brute Force: 🐌 (Turtle emoji or custom snail icon)
  - Optimized: 🏃 (Runner emoji or custom running figure)
  - Optimal: 🚀 (Rocket emoji or custom rocket icon)

---

## 2. Main Navigation Structure

### 2.1 Bottom Tab Navigation
**Four Primary Tabs** (visible on all main screens):

1. **Practice** (🏠 Home icon)
   - Browse and explore problems organized by category
   - Primary learning interface
   
2. **Quizes** (⚡ Lightning bolt icon - **emphasized**)
   - Quick pattern recognition challenges
   - Daily quizzes and timed challenges
   - **Visual emphasis**: Slightly larger icon, bright color treatment
   
3. **Progress** (📊 Chart/graph icon)
   - Personal statistics, achievements, and streaks
   - Category mastery visualization
   
4. **Settings** (⚙️ Settings/gear icon)
   - App preferences, subscription management, support

**Interaction Design**:
- Icons use **outline/line style** when inactive
- Icons **fill** when active, with accent color (#2196F3)
- Active tab displays a **2px indicator line** at the top of the icon
- Practice tab shows a **subtle pulsing animation** (0.8s cycle) when user has an active in-progress problem
- Smooth tab switching with 200ms fade transition

**Navigation State Persistence**:
- App remembers last visited screen within each tab
- Deep linking supported for sharing problems or quiz results

---

## 3. Practice Screen - Category Browser

### 3.1 Overview
The Practice screen is the main learning hub where users explore problems organized by algorithmic patterns and data structures. Categories are unlocked progressively: free users access foundational patterns, while premium subscribers unlock advanced topics.

### 3.2 Category Grid Layout
**Visual Structure**: Vertically scrollable grid with 2 columns (portrait) or 3 columns (landscape)

**Category Order** (as displayed):

**Free Categories** (Available to all users):
1. Arrays & Hashing
2. Two Pointers
3. Stack
4. Binary Search
5. Sliding Window
6. Linked List

**Premium Categories** (Require subscription):
7. Trees 🔒
8. Tries 🔒
9. Heap/Priority Queue 🔒
10. Intervals 🔒
11. Greedy Algorithms 🔒
12. Backtracking 🔒
13. Graphs 🔒
14. Advanced Graphs 🔒
15. 1-D Dynamic Programming 🔒
16. 2-D Dynamic Programming 🔒
17. Bit Manipulation 🔒
18. Math & Geometry 🔒

### 3.3 Category Card Design
**Each card displays**:

- **Icon**: Custom-designed icon representing the category concept
  - Example: Arrays & Hashing shows a grid/array icon
  - Example: Trees shows a tree structure diagram
- **Category Name**: Bold, 16sp font
- **Problem Count**: "12 problems" in secondary text (14sp)
- **Completion Status**: 
  - Circular progress indicator: "8/12 completed"
  - Progress ring fills clockwise with accent color
- **Difficulty Distribution**: Horizontal mini-bar chart at bottom
  - Green segment: % of Easy problems
  - Orange segment: % of Medium problems
  - Red segment: % of Hard problems
- **Premium Lock** (if locked):
  - Semi-transparent overlay
  - Lock icon (🔒) in top-right corner
  - Tap behavior: Opens premium upsell modal

**Card States**:
- **Not Started**: 0% completion, grey progress ring
- **In Progress**: Partial completion, blue progress ring
- **Completed**: 100% completion, green checkmark badge, subtle success animation on first completion

**Interaction**:
- Tap: Navigate to Category Detail Screen
- Long press: Show quick stats tooltip (avg. completion time, user's rank)

### 3.4 Category Detail Screen
**Accessed by**: Tapping a category card from the main Practice screen

**Screen Header**:
- Back button (top-left)
- Category icon and name (centered, 20sp bold)
- Bookmark all button (top-right, star icon)

**Stats Panel** (Expandable card below header):
- **Category Description**: 2-3 sentences explaining when to use this pattern
  - Example for Two Pointers: "Use when you need to search or compare elements from both ends of a sorted array. Common in pair-finding and array partition problems."
- **Your Progress**: "8/12 completed (66%)" with progress bar
- **Time Estimate**: "~6 hours to master this category"
- **Mastery Level**: Beginner/Intermediate/Advanced based on completion %
  - 0-30%: Beginner
  - 31-70%: Intermediate
  - 71-100%: Advanced

**Problem List** (Main content area):
Organized into three expandable/collapsible sections:

**Section 1: Easy Problems** (Green header bar):
- Header shows: "Easy (4 problems, 3 completed)"
- Expand/collapse chevron icon
- Individual problem cards with:
  - **Problem Number**: "#1"
  - **Problem Title**: "Two Sum"
  - **Completion Checkmark**: Green ✓ if solved
  - **Time to Complete**: "~15 min" (estimated)
  - **Premium Lock**: 🔒 icon if requires subscription

**Section 2: Medium Problems** (Orange header bar):
- Same structure as Easy
- Header: "Medium (6 problems, 4 completed)"

**Section 3: Hard Problems** (Red header bar):
- Same structure as Easy
- Header: "Hard (2 problems, 1 completed)"

**Problem Card Interactions**:
- **Tap**: Open Problem Overview Screen
- **Swipe Right**: Bookmark the problem (star icon appears)
- **Swipe Left**: Mark as "Want to Review" (flag icon appears)
- **Long Press**: Show quick preview modal with:
  - Problem statement (first 2 sentences)
  - Difficulty and estimated time
  - Quick start button

**Sorting & Filter Options** (Toolbar above problem list):
- Sort by: Default order / Difficulty / Completion status / Time estimate
- Filter: Show all / Not started / In progress / Completed / Bookmarked

### 3.5 Problem Overview Screen
**Accessed by**: Tapping a problem card from Category Detail Screen

**Screen Header**:
- Back button (top-left)
- Problem title: "Two Sum" (18sp bold)
- Difficulty badge: Color-coded pill (Easy/Medium/Hard)
- Action icons (top-right):
  - Bookmark toggle (star icon)
  - Share button (share icon)

**Content Layout** (Vertical scroll with distinct card sections):

#### Section 1: Problem Statement Card
**Visual Style**: White/elevated card with 16dp padding

- **Problem Description**: Clean, formatted text with proper line spacing
- **Example Test Cases**: 
  - Input/Output pairs in monospace font
  - Visually separated boxes
  - Example 1, Example 2, etc.
- **Expandable Section**: 
  - "Read Full Description" button
  - Expands to show additional examples and clarifications

#### Section 2: Constraints Card
**Visual Style**: Light blue background card

- **Time/Space Limits**: 
  - Maximum execution time allowed
  - Memory constraints
- **Input Constraints**:
  - Range of input sizes
  - Data type specifications
  - Example: "1 ≤ nums.length ≤ 10⁴"
- **Edge Cases to Consider**:
  - Bullet list of scenarios to think about
  - Example: "Empty array, duplicate elements, negative numbers"

#### Section 3: Your Status Card
**Visual Style**: Dynamic card that changes based on progress

**State 1 - Not Started**:
- Icon: 🎯
- Text: "Not Started - Ready to begin your journey!"
- CTA: Large "Start Learning" button

**State 2 - In Progress**:
- Icon: 📖
- Text: "You've viewed the Brute Force approach"
- Progress indicator: "1/3 approaches completed"
- CTA: "Continue Learning" button
- Mini checklist:
  - ✓ Brute Force understood
  - ⭕ Optimized (locked)
  - ⭕ Optimal (locked)

**State 3 - Completed**:
- Icon: 🎉
- Text: "Completed! You've mastered all approaches"
- Trophy icon with confetti animation (plays once on first view)
- CTA: "Review Your Solutions" button
- "Retake Challenge" secondary button

#### Section 4: Learning Approaches (Core Feature)
**Visual Style**: Three vertically stacked cards with connection lines showing progression

**Approach Card 1: Brute Force**
- **Icon**: 🐌 Turtle/snail (representing straightforward but slow)
- **Title**: "Brute Force Solution"
- **Subtitle**: "Start here - understand the basics"
- **Complexity Badges**:
  - Time: Red pill badge "O(n²)"
  - Space: Green pill badge "O(1)"
- **Status Indicator**: 
  - Locked: Grey with lock icon
  - Available: Blue with "Start" button
  - Completed: Green with checkmark ✓
- **CTA Button**: "Start Learning" (Blue, full width)
- **Always unlocked**: No prerequisites

**Approach Card 2: Optimized**
- **Icon**: 🏃 Runner (representing improved speed)
- **Title**: "Optimized Solution"
- **Subtitle**: "Faster approach with trade-offs"
- **Complexity Badges**:
  - Time: Orange pill badge "O(n log n)"
  - Space: Orange pill badge "O(n)"
- **Status Indicator**: 
  - Locked: Grey overlay with message "Complete Brute Force first"
  - Available: Blue with "Learn This Approach" button
  - Completed: Green with checkmark ✓
- **Unlock Requirement**: Must complete Brute Force approach
- **Progressive Disclosure**: Connection line from Brute Force card shows unlock path

**Approach Card 3: Optimal**
- **Icon**: 🚀 Rocket (representing peak efficiency)
- **Title**: "Optimal Solution"
- **Subtitle**: "The clever trick that makes it optimal"
- **Special Badge**: "⭐ THE TRICK" (gold badge, animated shimmer)
- **Complexity Badges**:
  - Time: Green pill badge "O(n)"
  - Space: Yellow pill badge "O(n)"
- **Status Indicator**:
  - Locked: Grey overlay with message "Complete Optimized first"
  - Available: Gold with "Discover the Trick!" button
  - Completed: Gold with checkmark ✓
- **Unlock Requirement**: Must complete Optimized approach
- **Special Treatment**: Emphasized visual treatment to create excitement

**Visual Connection**:
- Dotted lines connecting the three cards vertically
- Animated progression indicator showing unlock flow
- Greyed-out connections for locked approaches

#### Section 5: Community Stats Card
**Visual Style**: Light grey card with social proof elements

- **Completion Stats**:
  - "1,247 developers have mastered this problem"
  - Trophy icon
- **Time Benchmarks**:
  - "Average completion time: 18 minutes"
  - Clock icon
- **Success Metrics**:
  - "87% pass rate on first attempt"
  - Progress bar visualization
- **Difficulty Rating**:
  - Community-voted difficulty (may differ from official)
  - "Users rate this: 4.2/5.0 difficulty"

#### Bottom Fixed CTA
**Position**: Sticky footer button (always visible)

- **Primary Action**: 
  - "Start Learning This Problem" (if not started)
  - "Continue Learning" (if in progress, shows approach name)
  - "Review Solutions" (if completed)
- **Visual Style**: 
  - Large button (48dp height)
  - Full width with 16dp horizontal margins
  - Accent color background
  - Elevation/shadow for depth

### 3.6 Solution Learning Screen
**Accessed by**: Tapping on any approach card (Brute Force/Optimized/Optimal)

**Screen Structure**: Full-screen immersive learning experience

#### Top Navigation Bar
- **Exit Button** (top-left): X icon
  - Tap behavior: Shows confirmation modal if progress not marked as understood
  - "Your progress will be saved. Continue later?"
- **Approach Stepper** (centered):
  - Shows current position: "1 of 3", "2 of 3", "3 of 3"
  - Dots indicator below: ⚫⚪⚪
  - Current approach name displayed
- **Progress Bar** (below stepper):
  - Horizontal bar showing scroll progress through current approach content
  - Fills as user scrolls down

#### Main Content Area (Vertically scrollable)

**Content Section 1: Approach Overview**
- **Header**: Large text "Brute Force Solution" with icon
- **One-Line Summary**: 
  - Bold text explaining the core idea
  - Example: "Check every possible pair using nested loops"
- **When to Use**: 
  - 2-3 bullet points
  - Example: "Good for: Understanding the problem, Small inputs (<100 elements), Interview discussion starter"
- **Visual Difficulty Indicator**: 
  - Easy/Medium/Hard badge
  - Implementation complexity rating (1-5 stars)

**Content Section 2: Complexity Analysis**
**Visual Style**: Highlighted box with colored border (blue for time, green for space)

- **Time Complexity**:
  - Large text: "O(n²)"
  - **Tap to Expand**: Accordion that reveals:
    - Why this complexity: "Two nested loops, each iterating through n elements"
    - Best case, Average case, Worst case breakdown
    - Visual diagram (optional): nested loop visualization
- **Space Complexity**:
  - Large text: "O(1)"
  - **Tap to Expand**: Accordion that reveals:
    - What memory is used: "Only constant space for loop counters"
    - Space usage diagram
- **Summary Line**: 
  - Example: "We sacrifice time efficiency for simplicity and minimal memory usage"

**Content Section 3: Step-by-Step Explanation**
**Visual Style**: Numbered steps with clear hierarchy

- **Text Walkthrough**:
  - Step 1, Step 2, Step 3... format
  - Each step is 1-2 sentences
  - Digestible chunks with proper spacing
- **Interactive Animation Button**:
  - "▶️ Show Visual Animation" button
  - Tap behavior: Opens modal with animated visualization
  - Animation shows:
    - Array elements
    - Current pointers/indices
    - Comparisons being made
    - Step-by-step execution
  - Playback controls: Play/Pause, Speed control (0.5x, 1x, 2x)

**Content Section 4: Code Implementation**
**Visual Style**: Code block with dark theme, syntax highlighting

- **Code Display**:
  - Syntax-highlighted Python code (or user's selected language)
  - Line numbers on the left
  - Inline comments explaining key lines
  - Scrollable horizontally if code is wide
- **Code Actions Toolbar** (above code block):
  - Language selector: Python / JavaScript / Java / C++ (tabs)
  - Copy button: Copies code to clipboard with toast notification
  - Fullscreen button: Opens code in fullscreen modal with zoom capability
- **Code Quality**: 
  - Clean, production-ready code
  - Follows language best practices
  - Includes type hints (Python) or type declarations

**Content Section 5: Interactive Example**
**Visual Style**: Sandbox/playground card with light background

- **Pre-loaded Test Case**:
  - Example: nums = [3, 4, 5, 6], target = 7
  - Input displayed in a formatted box
- **"Step Through Execution" Button**:
  - Interactive debugger-style interface
  - Shows current step in algorithm
  - Highlights current line of code
  - Displays variable values at each step
- **Visual Array Representation**:
  - Array elements shown as boxes
  - Current element(s) highlighted
  - Pointers/indices shown with arrows
  - Comparisons visualized with connecting lines
- **Execution Controls**:
  - Previous step, Next step, Reset buttons
  - Auto-play with speed control
- **Variable Tracker**:
  - Shows current values of all variables
  - Updates as user steps through

**Content Section 6: The Key Insight** (Optimal approach only)
**Visual Style**: Special highlighted section with gradient background, larger text

- **Header**: "💡 THE TRICK" banner with animated lightbulb icon
- **Core Insight Box**:
  - The "aha moment" that makes this approach optimal
  - Example: "Instead of checking all pairs (O(n²)), ask: 'What number do I NEED to make the target?' Then use a hash map to check if you've seen it in O(1) time."
- **Pattern Name**: 
  - "This uses the: **Complement Lookup Pattern**"
  - Link to pattern library (if exists)
- **Visual Diagram**: 
  - Illustrates the mental model shift
  - Before/After comparison
- **Why It Works**:
  - 2-3 sentences explaining the mathematical/logical foundation
- **When to Recognize This Pattern**:
  - Bullet list of problem characteristics that signal this approach
  - Example: "Look for: pair problems, sum targets, O(n²) brute force"

**Content Section 7: Comparison with Previous Approaches**
**(Displayed for Optimized and Optimal approaches only)**
**Visual Style**: Two-column comparison table

- **Side-by-Side Table**:
  - Columns: Brute Force | Optimized | Optimal
  - Rows:
    - Time Complexity
    - Space Complexity
    - Code Complexity (Easy/Medium/Hard)
    - Interview Readiness (Low/Medium/High)
- **What Improved**:
  - Highlighted improvements with ⬆️ icons
  - Example: "Time: O(n²) → O(n) (100x faster on n=1000)"
- **Trade-offs Made**:
  - Highlighted trade-offs with ⚖️ icon
  - Example: "Space: O(1) → O(n) (uses extra hash map)"
- **Evolution Summary**:
  - One sentence tying the progression together
  - Example: "We traded space for time by pre-computing lookups"

#### Bottom Navigation Bar (Fixed)
**Visual Style**: Sticky footer with action buttons

- **Left Section**:
  - "Mark as Understood" button (checkbox/checkmark icon)
  - Tap behavior: 
    - Saves progress
    - Shows confetti animation
    - Awards XP
    - Unlocks next approach (if applicable)
    - Toast notification: "+20 XP earned!"
- **Center Section**:
  - Progress indicator: "1 of 3 approaches completed"
  - Mini progress dots: ⚫⚪⚪
- **Right Section**:
  - "Next Approach" button (arrow icon)
  - Enabled only if current approach is marked as understood
  - Tap behavior: Navigates to next approach learning screen
  - Disabled state: Grey with lock icon if prerequisites not met

#### Gamification Elements
**Visual Feedback for Engagement**:

- **Completion Animation**:
  - Confetti drops from top of screen
  - Success sound effect (if sound enabled)
  - Haptic feedback (vibration)
- **XP Notifications**:
  - Toast message slides in from top: "+20 XP for understanding Brute Force!"
  - XP particles float upward
- **Bonus XP**:
  - "+50 XP Bonus!" for completing all three approaches
  - "Streak Bonus: +10 XP" if solved on consecutive days
- **Achievement Unlocks**:
  - Modal overlay appears: "🏆 Achievement Unlocked!"
  - Example: "Pattern Master - Learned all approaches for 5 problems"
  - Shows progress toward next achievement

---

## 4. Quizes Screen - Pattern Recognition Challenges

### 4.1 Overview
The Quizes screen is designed to reinforce pattern recognition skills through quick, engaging challenges. Unlike the Practice screen where users learn solutions step-by-step, quizzes test their ability to **identify which algorithmic pattern or approach applies** to a given problem **before** seeing any solutions.

**Core Learning Goal**: Train users to recognize patterns quickly, simulating the real interview experience where you must choose an approach under time pressure.

### 4.2 Quiz Home Screen
**Accessed by**: Tapping the Quizes tab in bottom navigation

**Screen Header**:
- Title: "Pattern Recognition" (24sp bold)
- Subtitle: "Master the art of choosing the right approach"
- Current streak indicator: "🔥 3 Day Quiz Streak"

#### Daily Challenge Section
**Visual Style**: Prominent hero card at top, gradient background

- **Header**: "⚡ Daily Challenge" with calendar icon showing today's date
- **Content**:
  - Difficulty: Medium (dynamic, changes daily)
  - Time limit: "5 minutes"
  - Reward: "+50 XP" (larger reward than regular quizzes)
  - Status: "Not Started" / "In Progress" / "Completed ✓"
- **Visual Elements**:
  - Large circular timer icon
  - Countdown if already started: "3:42 remaining"
  - Star multiplier if completed in under 3 min: "2x XP"
- **CTA Button**: "Start Daily Challenge" (full width, gold/accent color)
- **Completion State**:
  - If already completed today: "✓ Completed! Next challenge in 18h 23m"
  - Shows score: "Perfect Score: 5/5 correct"
  - "Share Results" button

#### Quiz Categories Section
**Visual Style**: Grid of quiz category cards (2 columns)

**Quick Quiz Types**:

**1. Pattern Matcher Quiz Card**:
- Icon: 🎯 Target icon
- Title: "Pattern Matcher"
- Description: "Match problems to their optimal pattern"
- Question count: "20 questions available"
- Difficulty selector: Easy / Medium / Hard (chips)
- User's best score: "Best: 15/20 (75%)"
- Time: "~10 minutes"
- CTA: "Start Quiz" button
- **Free/Premium**: Free for Easy, Premium lock 🔒 for Medium/Hard

**2. Approach Identifier Quiz Card**:
- Icon: 🔍 Magnifying glass
- Title: "Approach Identifier"
- Description: "Identify the approach from code snippets"
- Question count: "15 questions"
- Format: "Multiple choice"
- Best score: "Best: 12/15 (80%)"
- Time: "~8 minutes"
- CTA: "Start Quiz"
- **Free/Premium**: Premium only 🔒

**3. Complexity Quiz Card**:
- Icon: ⏱️ Stopwatch
- Title: "Time Complexity Master"
- Description: "Calculate time complexity of solutions"
- Question count: "25 questions"
- Format: "Multiple choice + explanation"
- Best score: "Best: 20/25 (80%)"
- Time: "~12 minutes"
- CTA: "Start Quiz"
- **Free/Premium**: Premium only 🔒

**4. Speed Challenge Card**:
- Icon: ⚡ Lightning bolt
- Title: "Lightning Round"
- Description: "Quick-fire pattern recognition"
- Question count: "10 questions"
- Time limit: "30 seconds per question"
- Format: "Timed multiple choice"
- Best time: "Best: 3:15"
- CTA: "Start Challenge"
- **Free/Premium**: Free

#### Practice Quiz Section
**Visual Style**: Expandable section with category breakdown

- **Header**: "Practice by Category" (expandable)
- **Content**: List of all problem categories (matching Practice screen)
  - Each category shows: "Arrays & Hashing - 12 quiz questions"
  - Tap behavior: Opens category-specific quiz
  - Shows completion: "8/12 answered correctly"
  - Locked for premium categories

#### Recent History Section
**Visual Style**: Horizontal scrolling cards

- **Header**: "Recent Quizzes"
- **Card Content**:
  - Quiz type and date
  - Score: "15/20 correct (75%)"
  - Time taken: "Completed in 8:23"
  - Difficulty: Easy/Medium/Hard badge
  - Tap behavior: Review quiz results
- **Empty State**: "Complete your first quiz to see history here"

### 4.3 Quiz Configuration Screen
**Accessed by**: Tapping "Start Quiz" on any quiz card

**Screen Header**:
- Back button
- Quiz type title: "Pattern Matcher Quiz"
- Difficulty badge (if applicable)

#### Configuration Options Panel

**1. Difficulty Selection** (for applicable quizzes):
- Three option cards: Easy / Medium / Hard
- Shows:
  - Question count for each: "Easy: 10 questions"
  - Average success rate: "87% average"
  - Recommended time: "~5 minutes"
- Visual indicator of selected difficulty

**2. Question Count Slider**:
- "Number of Questions" label
- Slider: 5 - 10 - 15 - 20 - 25
- Shows estimated time below: "~12 minutes"

**3. Timer Option**:
- Toggle: "Enable Timer" (on/off switch)
- If enabled:
  - Shows time limit per question: "45 seconds per question"
  - Warning icon: "Unanswered questions will count as wrong"

**4. Question Source**:
- Radio buttons:
  - ⭕ "All Problems"
  - ⭕ "Unsolved Problems Only"
  - ⭕ "Problems I've Completed"
  - ⭕ "Bookmarked Problems"

**5. Mode Selection**:
- Toggle between:
  - **Practice Mode**: See correct answer immediately after each question
  - **Test Mode**: See all results at the end only

#### Ready to Start Section
**Visual Style**: Summary card with all selected options

- Displays:
  - Difficulty: Medium
  - Questions: 15
  - Timer: 45s per question
  - Mode: Test Mode
  - Estimated time: ~11 minutes
- **Start Button**: Large, prominent "Start Quiz Now" (accent color)
- Note: "Your progress will be saved if you exit"

### 4.4 Active Quiz Screen - Pattern Matcher
**Accessed by**: Starting a quiz from configuration screen

**Core Functionality**: User reads a problem statement and must identify which pattern/approach is optimal, without seeing any code or solutions.

#### Top Status Bar (Fixed)
- **Progress Indicator**: "Question 3 of 15" (progress bar)
- **Timer** (if enabled): 
  - Countdown: "00:38" remaining (turns red below 10 seconds)
  - Circular progress ring depleting
- **Exit Button**: X icon (top-left)
  - Tap: Shows "Exit Quiz?" confirmation modal
  - Options: "Save & Exit" / "Continue Quiz"

#### Question Display Area

**Problem Statement Card**:
**Visual Style**: Large, readable card with problem text

- **Problem Title**: "Find Two Numbers That Add to Target"
- **Problem Description**:
  - Clear, concise problem statement (simplified from full LeetCode problem)
  - 2-4 sentences maximum
  - Example: "Given an array of integers and a target sum, return the indices of two numbers that add up to the target. You may assume each input has exactly one solution."
- **Example Test Case**:
  - Input: nums = [2, 7, 11, 15], target = 9
  - Output: [0, 1]
  - Explanation: "nums[0] + nums[1] = 2 + 7 = 9"
- **Constraints** (collapsible):
  - Tap "Show Constraints" to expand
  - Shows: Array length, value ranges, etc.

**Pattern/Approach Options**:
**Visual Style**: Vertical list of selectable cards (single choice)

**Question Format**: "Which pattern/approach would give the optimal solution?"

**Answer Options** (randomized order):
1. ⭕ **Two Pointers**
   - Brief hint: "Iterate from both ends"
   - Complexity preview: "O(n log n) time"
   
2. ⭕ **Hash Map / Hash Set**
   - Brief hint: "Store values for quick lookup"
   - Complexity preview: "O(n) time, O(n) space"
   
3. ⭕ **Sliding Window**
   - Brief hint: "Maintain a window of elements"
   - Complexity preview: "O(n) time"
   
4. ⭕ **Binary Search**
   - Brief hint: "Search in sorted data"
   - Complexity preview: "O(n log n) time"
   
5. ⭕ **Brute Force**
   - Brief hint: "Check all possible pairs"
   - Complexity preview: "O(n²) time"

**Interaction**:
- Tap an option to select (radio button checked)
- Selected card highlights with accent color border
- Can change selection before submitting

**Additional Elements**:
- **Hint Button** (optional, costs points):
  - "💡 Use Hint (-5 points)"
  - Tap: Shows elimination hint: "Not Sliding Window or Binary Search"
  - Greys out eliminated options
- **Skip Button**:
  - "Skip Question" (bottom)
  - Marks as unanswered, moves to next

#### Answer Submission Area (Fixed Bottom)

**In Practice Mode** (immediate feedback):
- **Submit Button**: "Submit Answer" (full width)
- Tap behavior:
  - Shows immediate result overlay on current screen
  - ✓ Correct: Green overlay, "Correct! +10 points"
  - ✗ Wrong: Red overlay, "Incorrect"
  - Shows correct answer: "Correct answer: Hash Map"
  - **Explanation Card** (expandable):
    - "Why Hash Map is optimal:"
    - 2-3 sentences explaining the reasoning
    - Complexity comparison
  - "Next Question" button appears after 2 seconds

**In Test Mode** (no immediate feedback):
- **Submit Button**: "Submit & Next" (full width)
- Tap behavior:
  - Instantly moves to next question
  - No feedback shown until quiz end
  - Visual confirmation: "Answer recorded ✓"

### 4.5 Quiz Results Screen
**Accessed by**: Completing all questions or exiting quiz

**Screen Header**:
- Title: "Quiz Complete!" (if finished) or "Quiz Results" (if exited early)
- Close button (X) to return to Quiz Home

#### Score Overview Section
**Visual Style**: Hero card with large score display

- **Score Visualization**:
  - Circular progress ring with percentage: "80%"
  - Center text: "12/15 correct"
  - Color-coded:
    - Green: 80-100%
    - Orange: 60-79%
    - Red: 0-59%
- **Performance Rating**:
  - Excellent: 90-100%
  - Great: 80-89%
  - Good: 70-79%
  - Fair: 60-69%
  - Needs Practice: 0-59%
- **Time Taken**: "Completed in 8:23"
- **XP Earned**: "+120 XP" (with particle animation)
- **Accuracy by Difficulty**:
  - Easy: 5/5 (100%)
  - Medium: 5/7 (71%)
  - Hard: 2/3 (67%)

#### Detailed Results Section
**Visual Style**: List of all questions with expand/collapse

**Question Review Cards**:
- **Correct Answer** (green checkmark):
  - Question number and title
  - "✓ Your answer: Hash Map - Correct!"
  - Time taken: "Answered in 32s"
  - Tap to expand: Shows problem and explanation
  
- **Wrong Answer** (red X):
  - Question number and title
  - "✗ Your answer: Two Pointers"
  - "Correct answer: Hash Map"
  - Tap to expand:
    - Shows full problem statement
    - Explanation of correct answer
    - Why your answer was wrong
    - "Study This Pattern" button → links to relevant problems
  
- **Skipped Question** (grey):
  - Question number and title
  - "⊝ Skipped"
  - Tap to expand: Shows correct answer and explanation

#### Pattern Weakness Analysis
**Visual Style**: Insight card with recommendations

- **Header**: "Your Pattern Strengths"
- **Strength Breakdown**:
  - Hash Map: 5/5 correct (100%) ⭐
  - Two Pointers: 3/4 correct (75%)
  - Sliding Window: 2/3 correct (67%)
  - Binary Search: 2/3 correct (67%)
- **Recommendation Section**:
  - "Focus on: Sliding Window and Binary Search"
  - "Suggested Problems" button → links to Practice screen filtered by weak patterns

#### Action Buttons (Bottom)
- **Primary Actions**:
  - "Retake Quiz" button (restart with same settings)
  - "New Quiz" button (return to quiz configuration)
- **Secondary Actions**:
  - "Share Results" button (generates shareable image/link)
  - "Review Mistakes" button (filters to only wrong answers)
  - "Save to History" (auto-saved, but shown as confirmation)

### 4.6 Alternative Quiz Format: Approach Identifier
**Available for Premium users**

**Question Format**: Shows a code snippet and asks user to identify the approach

**Question Display**:
- **Code Snippet** (syntax highlighted):
  - 10-15 lines of code
  - Implements one of the approaches (Brute Force/Optimized/Optimal)
  - No comments or function name hints
- **Question**: "What approach does this code represent?"
- **Multiple Choice Options**:
  1. Brute Force (O(n²))
  2. Optimized with Sorting (O(n log n))
  3. Optimal with Hash Map (O(n))
  4. Two Pointers (O(n))

**Answer Feedback**:
- Shows correct approach name
- Explains key characteristics that identify this approach
- Example: "This is Hash Map because we see a dictionary/object used for O(1) lookups"

### 4.7 Alternative Quiz Format: Complexity Quiz
**Available for Premium users**

**Question Format**: Shows code and asks for time/space complexity

**Question Display**:
- **Code Snippet**: 5-20 lines showing an algorithm
- **Two-Part Question**:
  1. "What is the time complexity?"
  2. "What is the space complexity?"
- **Answer Options** (for each):
  - O(1)
  - O(log n)
  - O(n)
  - O(n log n)
  - O(n²)
  - O(2ⁿ)

**Answer Feedback**:
- Shows correct complexities
- **Detailed Explanation**:
  - Line-by-line analysis
  - "The outer loop runs n times, inner loop runs n times → n × n = O(n²)"
  - Highlights loops, recursion, data structure operations

### 4.8 Quiz State Persistence
**Auto-Save Functionality**:
- Quiz progress saved after each question
- User can close app and resume later
- Resume prompt on return: "You have an in-progress quiz. Continue?"
- Saved state includes:
  - Current question number
  - Answered questions and selections
  - Time remaining (if timed)
  - Configuration settings

### 4.9 Gamification Integration
**XP Rewards**:
- Base XP per correct answer: 10 XP
- Speed bonus (under 30s): +5 XP
- Perfect quiz bonus: +50 XP
- Daily challenge completion: +50 XP
- Streak bonus: +10 XP per day of streak

**Achievements**:
- "Quiz Master": Complete 10 quizzes
- "Perfect Score": Get 100% on any quiz
- "Speed Demon": Complete lightning round in under 3 minutes
- "Dedicated Learner": 7-day quiz streak
- "Pattern Expert": 90%+ accuracy on 20+ quiz questions

**Leaderboard** (Optional future feature):
- Weekly leaderboard for quiz scores
- Friends comparison
- Global rankings

---

## 5. Progress Screen - Analytics & Achievements

### 5.1 Screen Header
- Title: "Your Progress" (24sp bold)
- Time period selector: "This Week" / "This Month" / "All Time" (segmented control)

### 5.2 Hero Stats Section
**Visual Style**: Horizontal scrollable cards showing key metrics

**Card 1: Total Problems Solved**:
- Large number: "47"
- Subtitle: "out of 150 problems"
- Progress bar: 31% filled
- Comparison: "↑ 5 more than last week"

**Card 2: Current Streak**:
- Large flame icon: 🔥
- Number: "5 Days"
- Subtitle: "Keep it going!"
- Next milestone: "10 days → unlock badge"

**Card 3: Total XP**:
- Large number: "1,240 XP"
- Progress to next level: "240 XP to Level 6"
- Progress bar
- Rank: "Top 15% of users"

**Card 4: Quiz Accuracy**:
- Large percentage: "82%"
- Subtitle: "Quiz success rate"
- Trend: "↑ 7% improvement"

### 5.3 Streak Calendar
**Visual Style**: Month view calendar, GitHub-style contribution graph

- **Current Month Display**:
  - Grid of days (7 columns × 4-5 rows)
  - Each day is a square
  - Color intensity shows activity level:
    - Grey: No activity
    - Light green: 1-2 problems solved
    - Medium green: 3-4 problems solved
    - Dark green: 5+ problems solved
- **Streak Counter** (above calendar):
  - "🔥 5 Day Streak"
  - Best streak: "Longest: 12 days"
- **Today's Goal**:
  - "Solve 1 problem to maintain your streak"
  - Progress: 0/1 completed today
- **Month Navigation**:
  - Left/right arrows to view previous months
  - Shows total active days per month

### 5.4 Category Mastery Section
**Visual Style**: Vertical list of category cards

**Header**: "Category Progress" (18sp bold)

**Each Category Shows**:
- **Category Name** with icon
- **Progress Bar**:
  - Filled based on completion %
  - Color-coded by category
- **Completion Stats**:
  - "8/12 completed (66%)"
- **Mastery Badge** (if 100% complete):
  - Gold trophy icon
  - "Mastered" badge
- **Difficulty Breakdown** (expandable):
  - Easy: 4/4 ✓
  - Medium: 4/6
  - Hard: 0/2
- **Time Investment**:
  - "6.5 hours spent"
- **Tap Behavior**: Navigate to that category's detail screen

**Sorting Options**:
- Sort by: Progress % / Name / Time Spent / Recently Active

### 5.5 Achievements Section
**Visual Style**: Grid of achievement badges (2-3 columns)

**Header**: "Achievements" (18sp bold)
**Subtitle**: "12 of 45 unlocked"

**Achievement Card**:
- **Icon**: Custom badge design (locked badges are greyed out)
- **Achievement Name**: "Problem Solver"
- **Description**: "Solve 10 problems"
- **Progress**: "10/10" with progress bar (for locked achievements)
- **Unlock Date**: "Unlocked 3 days ago" (for completed)
- **Rarity**: "Rare - 23% of users" (optional)

**Achievement Categories**:
- **Problem Solving**:
  - First Problem: Solve 1 problem
  - Problem Solver: Solve 10 problems
  - Century Club: Solve 100 problems
  - All Star: Solve all problems in a category
  
- **Pattern Mastery**:
  - Pattern Recognition: Complete 3 approaches for 1 problem
  - Pattern Expert: Complete 3 approaches for 10 problems
  - Pattern Master: Complete 3 approaches for 25 problems
  
- **Consistency**:
  - Getting Started: 3-day streak
  - Committed: 7-day streak
  - Dedicated: 30-day streak
  - Unstoppable: 100-day streak
  
- **Quiz Performance**:
  - Quiz Taker: Complete 5 quizzes
  - Perfect Score: Get 100% on a quiz
  - Quiz Master: Complete 50 quizzes
  - Lightning Fast: Complete speed challenge under 3 min

**Locked Achievement Display**:
- Greyed out badge with lock icon
- Shows progress: "7/10 problems solved"
- Tap to see full requirements

### 5.6 Activity Graph Section
**Visual Style**: Line or bar chart showing activity over time

**Header**: "Activity Trend"

**Chart Options** (tabs):
- **Daily**: Last 7 days
- **Weekly**: Last 8 weeks  
- **Monthly**: Last 6 months

**Metrics Displayed**:
- Problems solved per day/week/month
- Quiz scores over time
- Time spent per day/week/month

**Chart Interaction**:
- Tap on data point to see exact numbers
- Zoom/pan for detailed view

### 5.7 Personal Bests Section
**Visual Style**: List of milestone cards

**Records Tracked**:
- Longest Streak: "12 days (Sep 2024)"
- Most Problems in a Day: "8 problems (Oct 1)"
- Fastest Problem Solution: "4:23 (Two Sum)"
- Best Quiz Score: "100% on Pattern Matcher"
- Most Active Category: "Arrays & Hashing (23 problems)"

### 5.8 Empty State
**When user has no progress**:
- Friendly illustration
- Encouraging message: "Start your journey! Complete your first problem to see your stats here."
- "Browse Problems" CTA button

---

## 6. Settings Screen

### 6.1 Screen Header
- Title: "Settings" (24sp bold)
- Subtitle: Current app version (e.g., "Version 1.2.0")

### 6.2 Account Section (If future login feature added)
**Currently**: Not implemented (app is fully local)
**Placeholder for future**:
- Profile picture
- Username
- Email
- "Edit Profile" button

### 6.3 App Preferences Section

**Code Language Preference**:
- Label: "Preferred Programming Language"
- Subtitle: "Code examples will be shown in this language"
- Options: Python (default) / JavaScript / Java / C++
- Visual: Dropdown or radio selection
- Note: Applies to all code snippets in learning screens

**Theme Selection**:
- Label: "Appearance"
- Options:
  - ⭕ Light Mode
  - ⭕ Dark Mode
  - ⭕ Auto (System Default)
- Visual: Three option cards with preview thumbnails
- Live preview of change

**Difficulty Display**:
- Label: "Show Difficulty Colors"
- Toggle: On/Off
- Description: "Display color-coded difficulty indicators"

**Notifications** (Future feature):
- Label: "Daily Reminder"
- Toggle: On/Off
- Time picker (if enabled): "Remind me at 7:00 PM"
- Description: "Get reminded to solve at least one problem"

### 6.4 Subscription Management Section

**Current Plan Card**:
- **If Free User**:
  - Badge: "Free Plan"
  - Features included:
    - 6 basic categories
    - Unlimited problem attempts
    - Basic quizzes
    - Progress tracking
  - **"Upgrade to Premium" CTA Button** (accent color, prominent)

- **If Premium User**:
  - Badge: "Premium" (gold background)
  - Features included:
    - All 18 categories unlocked
    - Advanced quizzes
    - All premium problems
    - Priority support
  - Subscription details:
    - Billing: "Monthly - $9.99/month"
    - Next billing date: "Renews on Nov 15, 2025"
  - **"Manage Subscription" Button**

**Premium Benefits Showcase** (For free users):
- **Header**: "Unlock Premium Features"
- **Benefits List**:
  - ✓ 12 additional advanced categories
  - ✓ Trees, Graphs, Dynamic Programming, and more
  - ✓ Advanced quiz modes
  - ✓ Approach Identifier & Complexity quizzes
  - ✓ Ad-free experience (if ads exist)
  - ✓ Priority customer support
- **Pricing**:
  - Monthly: $9.99/month
  - Yearly: $79.99/year (save 33%)
- **"Start Free Trial" Button**: "7 days free, then $9.99/month"
- **Restore Purchases**: "Already purchased? Restore here"

**Restore Purchases Button**:
- For users who purchased on another device
- Tap behavior: Checks App Store/Play Store for purchase history
- Success: "Premium restored!"
- Failure: "No purchases found"

### 6.5 Data & Privacy Section

**Data Storage**:
- Label: "Storage Used"
- Shows: "App data: 45 MB"
- Breakdown:
  - Problem database: 30 MB
  - User progress: 10 MB
  - Cache: 5 MB
- "Clear Cache" button

**Export Progress**:
- Label: "Export Your Data"
- Description: "Download your progress as JSON file"
- "Export Data" button
- Format: JSON file with all solved problems, quiz results, achievements

**Import Progress** (Future feature):
- Label: "Import Progress"
- Description: "Restore from previous backup"
- "Import Data" button

### 6.6 Support & Information Section

**Help & Support**:
- **Help Center**: Opens in-app help documentation
- **FAQ**: Common questions and answers
- **Send Feedback**: Opens email composer or feedback form
  - Pre-filled with app version, device info
- **Report a Bug**: Similar to feedback, marked as bug report
- **Contact Support**: Email: support@leetcodemaster.com

**Legal & Policies**:
- **Terms of Service**: Opens web view or PDF
- **Privacy Policy**: Opens web view or PDF
- **Licenses**: Shows open source licenses for libraries used
  - sqflite, shared_preferences, etc.
  - Proper attribution for all dependencies

**About**:
- **Rate This App**: Links to App Store/Play Store rating
- **Share App**: Opens share sheet with app link
- **Follow Us**: Links to social media (if exists)
- **App Version**: Displays current version number
- **Check for Updates**: Opens store page

### 6.7 Danger Zone Section
**Visual Style**: Red section header, separated from other settings

**Reset Progress**:
- Label: "Reset All Progress"
- Description: "⚠️ This will delete all your progress, stats, and achievements"
- **"Reset Progress" Button** (red, destructive style)
- Tap behavior:
  - Shows confirmation modal:
    - "Are you absolutely sure?"
    - "This action cannot be undone. All your progress will be permanently deleted."
    - Two buttons: "Cancel" (default) / "Yes, Reset Everything" (destructive)
  - If confirmed:
    - Shows second confirmation: "Type DELETE to confirm"
    - Text input field
    - Only enables final confirm if "DELETE" typed correctly
  - After reset:
    - Clears all local database
    - Resets to onboarding state
    - Shows success message

**Delete Account** (Future feature if login added):
- Similar flow to Reset Progress
- Additional step: Confirms email deletion from servers

---

## 7. Cross-Screen Features & Behaviors

### 7.1 Premium Upsell Modal
**Triggered by**: Tapping any locked content (problem, category, quiz)

**Modal Design**:
- Semi-transparent overlay
- Centered card with rounded corners
- Close button (X) in top-right

**Content**:
- **Header**: "🔒 Premium Feature"
- **Visual**: Illustration of locked content
- **Message**: "Unlock [Feature Name] with Premium"
- **Benefits Summary**:
  - Brief 3-point list of what premium unlocks
- **Pricing**: "$9.99/month or $79.99/year"
- **CTA Buttons**:
  - Primary: "Start Free Trial" (7 days)
  - Secondary: "See All Premium Features"
  - Tertiary: "Maybe Later" (dismisses modal)

### 7.2 Onboarding Flow (First Launch)
**Screens**:

**Screen 1: Welcome**:
- App logo and name
- Tagline: "Master LeetCode, One Pattern at a Time"
- "Get Started" button

**Screen 2: How It Works**:
- Illustration showing three approach cards
- Explanation: "Learn problems through three approaches: Brute Force → Optimized → Optimal"
- Swipe gesture or "Next" button

**Screen 3: Pattern Recognition**:
- Illustration of quiz interface
- Explanation: "Test your pattern recognition skills with engaging quizzes"
- "Next" button

**Screen 4: Track Progress**:
- Illustration of stats/achievements
- Explanation: "Track your improvement and build streaks"
- "Next" button

**Screen 5: Choose Language**:
- "Select your preferred coding language"
- Four cards: Python / JavaScript / Java / C++
- Description: "You can change this anytime in Settings"
- "Continue" button (enabled after selection)

**Screen 6: Ready to Begin**:
- Motivational message
- "Start Learning" button → Navigate to Practice screen
- Skip/finish onboarding

### 7.3 Search Functionality (Future Enhancement)
**Global Search**:
- Search icon in top app bar (optional)
- Search by:
  - Problem name
  - Problem number
  - Pattern/category
  - Keywords
- Recent searches saved
- Quick filters: Difficulty, Completion status

### 7.4 Offline Behavior
**App is fully offline**:
- No internet required after installation
- All content stored locally
- No sync or cloud backup (currently)
- Premium purchases require internet for verification
  - Cached after first verification

### 7.5 Accessibility Features
**Must implement**:
- Screen reader support (TalkBack/VoiceOver)
- Sufficient color contrast (WCAG AA compliant)
- Text scaling support (respect system font size)
- Focus indicators for keyboard navigation
- Alternative text for all icons and images
- Semantic markup for proper navigation

### 7.6 Error States & Empty States
**Network Errors** (for premium verification):
- Friendly error message
- "Retry" button
- "Continue Offline" option

**Empty States**:
- No bookmarked problems: Encouraging message + "Browse Problems" CTA
- No completed problems: Motivational message + "Start Learning" CTA
- No quiz history: "Take your first quiz!" + CTA

**Loading States**:
- Skeleton screens for content loading
- Smooth transitions
- Progress indicators for long operations

### 7.7 Performance Considerations
**Database Optimization**:
- Indexed queries for fast problem lookup
- Lazy loading for problem lists
- Pagination for large data sets

**Image Handling**:
- Vector icons where possible (scalable, small size)
- Compressed images
- Lazy loading of images

**Memory Management**:
- Dispose of controllers properly
- Clear cached data when not needed
- Efficient list rendering (virtualization)

---

## 8. Data Schema Overview (For Developer Reference)

### 8.1 SQLite Database Tables

**Problems Table**:
- problem_id (Primary Key)
- title
- category_id (Foreign Key)
- difficulty (Easy/Medium/Hard)
- description_short
- description_full
- example_input
- example_output
- constraints
- is_premium (boolean)
- estimated_time_minutes
- brute_force_code
- optimized_code
- optimal_code
- brute_force_explanation
- optimized_explanation
- optimal_explanation
- brute_force_complexity_time
- brute_force_complexity_space
- optimized_complexity_time
- optimized_complexity_space
- optimal_complexity_time
- optimal_complexity_space
- key_insight
- pattern_name

**Categories Table**:
- category_id (Primary Key)
- name
- icon
- description
- is_premium (boolean)
- order_index

**User_Progress Table**:
- progress_id (Primary Key)
- problem_id (Foreign Key)
- brute_force_completed (boolean)
- optimized_completed (boolean)
- optimal_completed (boolean)
- completed_date
- time_spent_seconds
- is_bookmarked (boolean)
- notes

**Quiz_History Table**:
- quiz_id (Primary Key)
- quiz_type (pattern_matcher/approach_identifier/complexity)
- difficulty
- total_questions
- correct_answers
- time_taken_seconds
- date_completed
- is_daily_challenge (boolean)

**Quiz_Questions_Answered Table**:
- answer_id (Primary Key)
- quiz_id (Foreign Key)
- problem_id (Foreign Key)
- user_answer
- correct_answer
- is_correct (boolean)
- time_taken_seconds

**Achievements Table**:
- achievement_id (Primary Key)
- name
- description
- icon
- category
- requirement_count
- is_unlocked (boolean)
- unlock_date

**Stats Table**:
- stat_id (Primary Key)
- date
- problems_solved
- quizzes_completed
- time_spent_seconds
- xp_earned

### 8.2 Shared Preferences Keys

**Settings**:
- preferred_language (string: python/javascript/java/cpp)
- theme_mode (string: light/dark/auto)
- notifications_enabled (boolean)
- notification_time (string: HH:mm format)

**User State**:
- current_streak (int)
- longest_streak (int)
- last_activity_date (string: ISO date)
- total_xp (int)
- current_level (int)
- is_premium (boolean)
- onboarding_completed (boolean)

**App State**:
- last_selected_tab (int: 0-3)
- active_quiz_id (int, nullable)

---

## 9. Premium Feature Summary

### 9.1 Free vs Premium Comparison

**Free Tier Includes**:
- 6 foundational categories:
  - Arrays & Hashing
  - Two Pointers
  - Stack
  - Binary Search
  - Sliding Window
  - Linked List
- All problems in free categories (approx. 60-70 problems)
- Complete 3-approach learning system
- Pattern Matcher quiz (Easy difficulty only)
- Lightning Round quiz
- Progress tracking and achievements
- Streak tracking
- Daily challenges (limited)

**Premium Tier Adds**:
- 12 additional advanced categories:
  - Trees, Tries, Heap/Priority Queue
  - Intervals, Greedy, Backtracking
  - Graphs, Advanced Graphs
  - 1-D DP, 2-D DP
  - Bit Manipulation, Math & Geometry
- All problems in premium categories (approx. 80-90 additional problems)
- Advanced quiz modes:
  - Pattern Matcher (Medium & Hard)
  - Approach Identifier quiz
  - Complexity Master quiz
- Daily challenges (full access)
- Priority customer support
- No advertisements (if ads implemented)
- Early access to new features

---

## 10. Future Enhancement Ideas (Not for Initial Release)

### 10.1 Potential Features
- Cloud sync with user accounts
- Social features (friends, compete on leaderboards)
- Custom problem sets
- Video explanations for problems
- Code playground (run code directly in app)
- Interview simulation mode
- Spaced repetition system
- Company-specific problem filters (FAANG, etc.)
- Discussion forum integration
- Collaborative learning (study groups)

### 10.2 Monetization Opportunities
- One-time purchase option (in addition to subscription)
- Lifetime premium unlock
- In-app tips/donations
- Premium+ tier with video content
- Corporate/team licenses

---

## 11. Development Priorities

### 11.1 MVP (Minimum Viable Product) Scope
**Must Have for Launch**:
1. Practice screen with 6 free categories
2. 50-60 problems with 3 approaches each
3. Problem learning screens with code examples
4. Basic Pattern Matcher quiz
5. Progress tracking (streak, stats)
6. Settings (language, theme)
7. Premium purchase flow
8. Onboarding flow

**Can Add Post-Launch**:
- Additional quiz types
- More achievements
- Advanced statistics
- Social features
- Cloud sync

### 11.2 Development Phases

**Phase 1: Core Learning Experience**
- Database setup with initial problems
- Practice screen navigation
- Problem detail and solution learning screens
- Basic progress tracking

**Phase 2: Gamification**
- XP system
- Achievements
- Streak tracking
- Progress visualization

**Phase 3: Quiz System**
- Pattern Matcher quiz
- Quiz results and history
- Daily challenges

**Phase 4: Premium & Polish**
- In-app purchase integration
- Premium content unlock logic
- UI/UX polish
- Bug fixes and optimization

**Phase 5: Marketing & Launch**
- App store assets
- Landing page
- Launch strategy

---

## 12. Key Design Principles

### 12.1 User Experience Guidelines
1. **Progressive Disclosure**: Don't overwhelm users with information. Reveal complexity gradually.
2. **Clear Feedback**: Always show users the result of their actions (success states, errors, loading).
3. **Consistency**: Use the same patterns, colors, and interactions throughout the app.
4. **Accessibility First**: Ensure all users can navigate and understand the app.
5. **Performance**: Keep the app fast and responsive. Optimize database queries and UI rendering.
6. **Offline-First**: App should work flawlessly without internet connection.

### 12.2 Content Guidelines
1. **Clarity**: All problem descriptions, explanations, and code should be clear and concise.
2. **Accuracy**: All complexity analyses and explanations must be technically correct.
3. **Consistency**: Code style should be consistent across all examples.
4. **Completeness**: Every problem must have all three approaches with full explanations.

---

## 13. Success Metrics

### 13.1 Key Performance Indicators (KPIs)
- **Engagement**:
  - Daily Active Users (DAU)
  - Average session duration
  - Problems solved per user
  - Streak retention rate
  
- **Learning Effectiveness**:
  - Quiz accuracy improvement over time
  - Problems completed per category
  - Time to problem completion (decreasing trend = learning)
  
- **Monetization**:
  - Free-to-premium conversion rate
  - Monthly Recurring Revenue (MRR)
  - Churn rate
  - Average Revenue Per User (ARPU)
  
- **Retention**:
  - Day 1, Day 7, Day 30 retention
  - Streak completion rate
  - Return visit frequency

---

This documentation provides a comprehensive guide for developers to implement the Leetcode Master app. All screens, interactions, and features are described in detail without any code implementation, focusing on functionality, user experience, and technical requirements.