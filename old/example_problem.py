# VALID ANAGRAM
# Given two strings s and t, return True if the two strings are anagrams of each other,
# otherwise return False.
# An anagram is a string that contains the exact same characters as another string,
# but the order of the characters can be different.
#
# Constraints:
# - s and t consist of lowercase English letters


# [BRUTE FORCE - Sorting]
# Time complexity: O(n log n) - Where n is the length of the string
#                  - Sorting both strings takes O(n log n) time each
#                  - Comparison takes O(n) time
#                  - Dominated by sorting: O(n log n) + O(n log n) + O(n) = O(n log n)
# Space complexity: O(n) - Python's sorted() creates new lists of size n for each string
#                   - We create two sorted lists, so technically O(2n) = O(n)
# Explanation: Sort both strings and check if they're equal. If both strings have the same
#              characters with the same frequencies, they'll be identical after sorting.
# Why this complexity: Sorting is the dominant operation, and comparison sort takes O(n log n).
class BruteForceSolution:
    def isAnagram(self, s: str, t: str) -> bool:
        # Early exit: if lengths differ, can't be anagrams
        if len(s) != len(t):
            return False
        
        # Sort both strings and compare
        return sorted(s) == sorted(t)


# [OPTIMIZED - HashMap/Counter]
# Time complexity: O(n) - Where n is the length of the strings
#                  - We iterate through string s once: O(n)
#                  - We iterate through string t once: O(n)
#                  - Total: O(n) + O(n) = O(2n) = O(n)
# Space complexity: O(k) - Where k is the number of unique characters
#                   - For lowercase English letters, k ≤ 26, so O(1) in practice
#                   - In general case, k ≤ n, so worst case O(n)
# Explanation: Count the frequency of each character in both strings using a hash map.
#              Two strings are anagrams if they have identical character frequency counts.
# Why this complexity: Single pass through each string for counting, hash map operations are O(1).
class OptimizedSolution:
    def isAnagram(self, s: str, t: str) -> bool:
        # Early exit: if lengths differ, can't be anagrams
        if len(s) != len(t):
            return False
        
        # Count character frequencies
        count_s = {}
        count_t = {}
        
        for char in s:
            count_s[char] = count_s.get(char, 0) + 1
        
        for char in t:
            count_t[char] = count_t.get(char, 0) + 1
        
        # Compare the two frequency maps
        return count_s == count_t


# [OPTIMAL - Fixed-size Array as Hash Map]
# Time complexity: O(n) - Where n is the length of the strings
#                  - We iterate through string s once: O(n)
#                  - We iterate through string t once: O(n)
#                  - Final validation of counter array: O(26) = O(1)
#                  - Total: O(n) + O(n) + O(1) = O(n)
# Space complexity: O(1) - Fixed array of size 26 for lowercase English letters
#                   - Always uses exactly 26 integers regardless of input size
# Explanation: Use a fixed array of size 26 (for 'a' to 'z') to count character frequencies.
#              Increment for characters in s, decrement for characters in t. If all counts
#              are zero at the end, strings are anagrams.
# Why this complexity: Single pass through each string with O(1) array access operations.
# THE TRICK: Using the constraint that input only contains lowercase English letters!
#            - We can map each character to an index: ord(char) - ord('a') gives us 0-25
#            - This eliminates the hash map overhead and guarantees O(1) space
#            - Instead of building two hash maps and comparing, we use one array with
#              increment/decrement strategy, reducing memory usage and comparisons
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        # Early exit: if lengths differ, can't be anagrams
        if len(s) != len(t):
            return False
        
        # Fixed array for 26 lowercase English letters
        counter = [0] * 26
        
        # Increment for s, decrement for t
        for i in range(len(s)):
            counter[ord(s[i]) - ord('a')] += 1
            counter[ord(t[i]) - ord('a')] -= 1
        
        # If all counts are zero, they're anagrams
        return all(count == 0 for count in counter)


# Test Cases

# Test Case 1: Basic anagram
s1 = "racecar"
t1 = "carrace"
# Output: True
# Explanation: Both strings contain the same characters with the same frequencies:
#              r:2, a:2, c:2, e:1. Order doesn't matter, so they're anagrams.

# Test Case 2: Not an anagram (different characters)
s2 = "jar"
t2 = "jam"
# Output: False
# Explanation: 'jar' has 'r' while 'jam' has 'm'. Different characters means not anagrams.

# Test Case 3: Edge case - empty strings
s3 = ""
t3 = ""
# Output: True
# Explanation: Two empty strings are considered anagrams of each other.

# Test Case 4: Edge case - single character match
s4 = "a"
t4 = "a"
# Output: True
# Explanation: Single identical characters are anagrams.

# Test Case 5: Different lengths
s5 = "abc"
t5 = "abcd"
# Output: False
# Explanation: Different lengths means they can't be anagrams (caught by early exit).


# Summary of Approaches
# | Approach              | Time       | Space    | Pros                              | Cons                           |
# |-----------------------|------------|----------|-----------------------------------|--------------------------------|
# | Sorting               | O(n log n) | O(n)     | Simple to understand and code     | Slower due to sorting overhead |
# | HashMap/Counter       | O(n)       | O(k)≈O(1)| Linear time, flexible for any     | Hash map overhead, two maps    |
# |                       |            |          | character set                     | needed for comparison          |
# | Fixed Array           | O(n)       | O(1)     | Optimal time and space, fastest   | Only works for limited charset |
# |                       |            |          | in practice, single pass possible | (lowercase English here)       |
#
# Winner: Fixed Array (Optimal Solution) - Achieves O(n) time with guaranteed O(1) space by
#         exploiting the constraint of lowercase English letters. Uses a clever increment/decrement
#         strategy in a single array, avoiding the need for hash map overhead or separate counters.