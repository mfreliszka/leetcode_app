I have a flutter mobile app design here that I did couple of months ago. I want to update and change the description with following things:



- the app should have only dark mode, and UI should imitate Leetcode dark mode, its colors, fonts and style



- the app components should be defined in components files to make them reusable, easier to maintain and update and to make them look the same across all the screens in the app



- this app will be an online app using Cloud Run Functions for Firebase through firebase_core and cloud_firestore packages from pub.dev. No local sqlite or isar needed.



- the app will be using flutter_riverpod and riverpod for state management



- The the categories and questions and code snippets will be fetched from my cloud run firebase functions api.



- the calls to my cloud run functions api should have caching mechanism to reduce the number of calls to the api and to make the app faster



- the endpoint urls should be defined in a separate file to make it easier to change them in the future



- the code snippets will be displayed in an app using flutter_code_editor package from pub.dev



- app will consist of 4 main screens: practice, quizzes, progress, settings



- app will let user create an account using firebase auth (firebase_auth and firebase_ui_auth packages from pub.dev) but account won't be required to use an app. Account will be used mainly to purchase premium.



- for now all categories and questions will be free, but I want an option to hide some categories or questions for premium users only for the future



- No emojis should be used inside the app





Here is the old app design:

```



## 1. App Overview & Philosophy







**App Name**: Leetcode Master







**Core Philosophy**: Transform LeetCode preparation from a chore into an engaging journey. Users don't just memorize solutions—they understand the evolution from brute force through optimized to optimal, building intuition for pattern recognition.







**Target Audience**: 



- Software engineering students



- Job seekers preparing for technical interviews



- Developers wanting to improve algorithmic thinking



### 1.1 Tech stack



- Android (material design) and iOS (cupertino design) Flutter app



- Frontend and backend: Flutter



- Fully offline



- Uses SQLite with sqflite plugin (SQLite plugin for Flutter https://pub.dev/packages/sqflite) for local database storage



- Uses shared_preferences flutter plugin for relatively small collection of key-values to save



- User progress is saved locally on device



- User is able to buy premium subscription to unlock all categories











## 2. Main Navigation Structure







### 2.1 Tab Bar (Bottom Navigation)



**Four Main Tabs**:







1. **Practice** (🏠 icon)



   - Browse all problems by category



   



2. **Quizes** (⚡ icon - highlighted/emphasized)



   - Active problem solving interface



   



3. **Progress** (📊 icon)



   - Stats, achievements, streaks



   



4. **Settings** (settings icon)



   - Settings, premium







**Visual Design**:



- Icons use line design when inactive, filled when active



- Active tab has accent color with small indicator line on top



- Practice tab has subtle pulsing animation when there's an active problem







---











## 3. Practice Screen - Category Browser







### 3.1 Category Grid View



**Visual Hierarchy Matching the Image**:







Display categories in a tree-like structure with expandable sections:







**Top Level** (Always visible):



- Arrays & Hashing



- Two Pointers



- Stack



- Binary Search



- Sliding Window



- Linked List



- Trees (premium required)



- Tries (premium required)



- Heap/Priority Queue (premium required)



- Intervals (premium required)



- Greedy algorithms (premium required)



- Backtracking (premium required)



- Graphs (premium required)



- Advanced Graphs (premium required)



- 1-D DP (premium required)



- 2-D DP (premium required)



- Bit Manipulation (premium required)



- Math & Geometry (premium required)







**Each Category Card Shows**:



- Icon representing the category (custom designed)



- Category name



- Problem count: "12 problems"



- Completion circle: "8/12 completed"



- Lock icon (if premium category and user is free)



- Difficulty distribution mini-bar: Green/Yellow/Red segments







### 3.2 Category Detail Screen



**Accessed by tapping a category card**







**Header**:



- Category name with icon



- Description: Brief explanation of when this pattern is used



- Your stats: "8/12 completed (66%)"



- Estimated time: "~6 hours to master"







**Problem List** (Scrollable):



Organized by difficulty:







**Easy Problems** (Green section header):



- Problem cards with:



  - Number/Title: "1. Two Sum"



  - Completion checkmark (if solved)



  - Lock icon (if premium)







**Medium Problems** (Orange section header):



- Problem cards with:



  - Number/Title: "1. Two Sum"



  - Completion checkmark (if solved)



  - Lock icon (if premium)







**Hard Problems** (Red section header):



- Problem cards with:



  - Number/Title: "1. Two Sum"



  - Completion checkmark (if solved)



  - Lock icon (if premium)







**Card Interaction**:



- Tap to open Problem Detail screen



- Swipe right to bookmark



- Long press to see quick preview











### 3.3 Problem Overview Screen



**Accessed by tapping a problem card from Category Detail Screen problem list**







**Header**:



- Back button



- Problem title: "Two Sum"



- Difficulty badge: Easy/Medium/Hard



- Bookmark icon (toggle)



- Share icon







**Content Sections** (Vertical scroll):







**1. Problem Statement Card**:



- Clear problem description



- Example inputs/outputs formatted nicely



- "Read Full Description" expandable section







**2. Constraints Card**:



- Time/space limits



- Input constraints



- Edge cases to consider







**3. Your Status Card**:



- If not started: "Not Started - Start Learning!"



- If in progress: "You've viewed Brute Force approach"



- If completed: "Completed! View your solution"







**4. Learning Approaches** (The Core Feature):



Three distinct cards with progression indicator:







**Card 1: Brute Force** (Always unlocked):



- Icon: 🐌 (representing slow but straightforward)



- Title: "Brute Force Solution"



- Time Complexity badge: O(n²)



- Space Complexity badge: O(1)



- Status: Locked/Unlocked/Completed (checkmark)



- "Start Learning" button







**Card 2: Optimized** (Unlocks after viewing Brute Force):



- Icon: 🏃 (representing faster)



- Title: "Optimized Solution"



- Time Complexity badge: O(n log n)



- Space Complexity badge: O(n)



- Status indicator



- "Learn This Approach" button



- Lock with message: "Complete Brute Force first" (if locked)







**Card 3: Optimal** (Unlocks after viewing Optimized):



- Icon: 🚀 (representing optimal)



- Title: "Optimal Solution"



- Time Complexity badge: O(n)



- Space Complexity badge: O(n)



- Special badge: "⭐ THE TRICK"



- Status indicator



- "Discover the Trick!" button



- Lock with message: "Complete Optimized first" (if locked)







**5. Discussion Stats** (Social Proof):



- "1,247 developers have mastered this"



- Average completion time: "18 minutes"



- Success rate: "87% pass rate"







**Bottom CTA**:



- Large button: "Start Learning This Problem" or "Continue Learning"







### 3.4 Solution Learning Screen



**When user taps on an approach card**







**Navigation**:



- Stepper at top showing which approach (1 of 3, 2 of 3, 3 of 3)



- Progress bar for current approach



- Exit button (saves progress)







**Content Layout** (Vertical scroll with smooth reading experience):







**Section 1: Approach Overview**:



- Header: "Brute Force Solution" (or Optimized/Optimal)



- One-line summary: "Check every possible pair using nested loops"



- When to use: "Good for: Understanding the problem, Small inputs"



- Visual difficulty indicator







**Section 2: Complexity Analysis** (Highlighted box):



- Time Complexity: O(n²) 



  - Tap to expand: Detailed explanation why it's O(n²)



- Space Complexity: O(1)



  - Tap to expand: Detailed explanation



- Why this complexity: Brief explanation from the code snippet







**Section 3: Step-by-Step Explanation**:



- Animated walkthrough available



- Text explanation broken into digestible steps



- "Show Animation" button that plays visual demonstration







**Section 4: Code Implementation**:



- Syntax-highlighted Python code (from your snippets)



- Line-by-line comments



- Zoom/expand button for fullscreen code view



- Copy code button



- Language selector: Python/JavaScript/Java (if you expand later)







**Section 5: Interactive Example**:



- Pre-loaded example: nums = [3, 4, 5, 6], target = 7



- "Step Through" button that shows execution step-by-step



- Current values highlighted



- Visual representation (array visualization)







**Section 6: The Key Insight** (For Optimal approach):



- Special highlighted section with lightbulb icon



- "💡 THE TRICK" banner



- The core insight that makes this optimal



- Example from your snippet: "Complement Lookup Pattern - Instead of checking all pairs, ask: 'What number do I NEED to make target?'"







**Section 7: Compare with Previous Approaches** (If not first approach):



- Side-by-side comparison table



- What improved (time/space)



- What trade-offs were made







**Bottom Navigation**:



- "Mark as Understood" button



- Progress indicator: e.g., "1 of 3 approaches completed"



- "Next Approach" button (if available)







**Gamification in Learning Screen**:



- Confetti animation when completing an approach



- XP earned notification: "+20 XP for understanding Brute Force!"



- Bonus XP for completing all three approaches: "+50 XP bonus!"



- Achievement unlock: "Pattern Master - Learned all approaches for 5 problems"







---











## 4. Progress Screen - Analytics & Achievements







### 4.1 Header Stats



**Big Numbers** (Horizontal cards):



- Total Problems Solved: 47/150







### 4.2 Streak Calendar



**Visual Calendar**:



- Current month view



- Days with activity highlighted (green squares like GitHub)



- Streak counter: "🔥 5 Day Streak"



- Longest streak: "Best: 12 days"







### 4.3 Category Mastery



**List of all categories with progress bar of the one completed**:



- Shows completion % for each category



- Color-coded by difficulty



- Tap a category to see details







## 5. Settings Screen







### 5.1 Settings Menu







**App Settings**:



- Language Preference (for code examples, python, javascript, java, c++)



- Theme: Light/Dark/Auto







**Subscription Management**:



- Current Plan: Free/Premium



- "Upgrade to Premium" (if free)



- Manage Subscription (if premium)



- Restore Purchases







**Support & Legal**:



- Help Center



- FAQ



- Send Feedback



- Report a Bug



- Terms of Service



- Privacy Policy



- Licenses







**Danger Zone**:



- Reset Progress (with confirmation)







```



Please adjust the app design file to my needs. Output only app design file as markdown