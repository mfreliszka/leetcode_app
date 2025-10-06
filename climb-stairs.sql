do $$
declare
  cat_id uuid;
  prob_id uuid;
begin
  -- Upsert category
  insert into public.categories (name, slug, description)
  values ('Dynamic Programming', 'dynamic-programming', 'Problems solvable via optimal substructure and overlapping subproblems.')
  on conflict (slug) do update
    set name = excluded.name,
        description = excluded.description
  returning id into cat_id;
  
  -- Upsert problem
  insert into public.problems (category_id, slug, title, difficulty, description)
  values (
    cat_id,
    'climb-stairs',
    'Climbing Stairs',
    'Easy',
    'Given n steps, return the number of distinct ways to climb to the top when you can climb 1 or 2 steps.'
  )
  on conflict (slug) do update
    set category_id = excluded.category_id,
        title = excluded.title,
        difficulty = excluded.difficulty,
        description = excluded.description
  returning id into prob_id;
  
  -- Replace existing approaches/hints for this problem (idempotent seeding)
  delete from public.approaches where problem_id = prob_id;
  delete from public.hints where problem_id = prob_id;
  
  -- Approach 1: Optimal iterative DP (Fibonacci)
  insert into public.approaches
    (problem_id, type, time_complexity, space_complexity, explanation, code, key_insights)
  values
    (
      prob_id,
      'optimal',
      'O(n)',
      'O(1)',
      $explanation$Use the Fibonacci relation f(n) = f(n-1) + f(n-2).
Keep only the last two states and iterate from 3..n.$explanation$,
      $code$
// Dart
int climbStairs(int n) {
  if (n <= 2) return n;
  int a = 1, b = 2;
  for (int i = 3; i <= n; i++) {
    final c = a + b;
    a = b;
    b = c;
  }
  return b;
}
$code$,
      array[
        'Fibonacci relation: f(n)=f(n-1)+f(n-2)',
        'Iterative DP using two variables'
      ]
    );
    
  -- Approach 2: Bottom-up DP with table
  insert into public.approaches
    (problem_id, type, time_complexity, space_complexity, explanation, code, key_insights)
  values
    (
      prob_id,
      'dp',
      'O(n)',
      'O(n)',
      $explanation$Build a DP table where dp[i] = dp[i-1] + dp[i-2].
Initialize base cases and fill up to n.$explanation$,
      $code$# Python
def climb_stairs(n):
    if n <= 2:
        return n
    dp = [0]*(n+1)
    dp[1] = 1
    dp[2] = 2
    for i in range(3, n+1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]
$code$,
      array[
        'Bottom-up DP transition',
        'Base cases: dp[1]=1, dp[2]=2'
      ]
    );
    
  -- Hints
  insert into public.hints (problem_id, text) values
    (prob_id, 'Recognize the Fibonacci-like recurrence relation.'),
    (prob_id, 'Start from base cases: f(1)=1, f(2)=2.'),
    (prob_id, 'You can optimize space by tracking only the last two states.');
end
$$;