-- DSA Master schema for Supabase (Postgres)
-- Creates core tables for categories, problems, approaches, hints,
-- and user learning tracking (approach understanding, hint usage, achievements).

-- Extensions
create extension if not exists pgcrypto;

-- Categories
create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique,
  description text,
  created_at timestamptz not null default now()
);

-- Problems
create table if not exists public.problems (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.categories(id) on delete cascade,
  slug text unique,
  title text not null,
  difficulty text not null check (difficulty in ('Easy','Medium','Hard')),
  description text,
  created_at timestamptz not null default now()
);
create index if not exists idx_problems_category on public.problems(category_id);

-- Approaches (solution strategies per problem)
create table if not exists public.approaches (
  id uuid primary key default gen_random_uuid(),
  problem_id uuid not null references public.problems(id) on delete cascade,
  type text not null, -- e.g. 'brute_force', 'optimal'
  time_complexity text, -- e.g. 'O(n)', 'O(n^2)'
  space_complexity text, -- e.g. 'O(1)', 'O(n)'
  explanation text,
  code text, -- code snippet
  key_insights text[] not null default '{}', -- list of short insights
  created_at timestamptz not null default now()
);
create index if not exists idx_approaches_problem on public.approaches(problem_id);

-- Hints (quick tips per problem)
create table if not exists public.hints (
  id uuid primary key default gen_random_uuid(),
  problem_id uuid not null references public.problems(id) on delete cascade,
  text text not null,
  created_at timestamptz not null default now()
);
create index if not exists idx_hints_problem on public.hints(problem_id);

-- Track user learning: which approaches are understood
create table if not exists public.approach_understanding (
  user_id uuid not null references auth.users(id) on delete cascade,
  problem_id uuid not null references public.problems(id) on delete cascade,
  approach_id uuid not null references public.approaches(id) on delete cascade,
  understood boolean not null default true,
  updated_at timestamptz not null default now(),
  primary key (user_id, approach_id)
);
create index if not exists idx_approach_understanding_user_problem
  on public.approach_understanding(user_id, problem_id);

-- Track user learning: which hints were used
create table if not exists public.hint_usage (
  user_id uuid not null references auth.users(id) on delete cascade,
  problem_id uuid not null references public.problems(id) on delete cascade,
  hint_id uuid not null references public.hints(id) on delete cascade,
  used boolean not null default true,
  updated_at timestamptz not null default now(),
  primary key (user_id, hint_id)
);
create index if not exists idx_hint_usage_user_problem
  on public.hint_usage(user_id, problem_id);

-- Achievements (optional; supports future expansion)
create table if not exists public.achievements (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  icon text,
  created_at timestamptz not null default now()
);

create table if not exists public.user_achievements (
  user_id uuid not null references auth.users(id) on delete cascade,
  achievement_id uuid not null references public.achievements(id) on delete cascade,
  achieved_at timestamptz not null default now(),
  primary key (user_id, achievement_id)
);

-- Row Level Security (RLS) policies
-- Enable RLS on user-specific tables and allow users to manage their own rows
alter table public.approach_understanding enable row level security;
alter table public.hint_usage enable row level security;
alter table public.user_achievements enable row level security;

-- approach_understanding policies
create policy approach_understanding_select_own
  on public.approach_understanding
  for select
  using (auth.uid() = user_id);

create policy approach_understanding_insert_own
  on public.approach_understanding
  for insert
  with check (auth.uid() = user_id);

create policy approach_understanding_update_own
  on public.approach_understanding
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy approach_understanding_delete_own
  on public.approach_understanding
  for delete
  using (auth.uid() = user_id);

-- hint_usage policies
create policy hint_usage_select_own
  on public.hint_usage
  for select
  using (auth.uid() = user_id);

create policy hint_usage_insert_own
  on public.hint_usage
  for insert
  with check (auth.uid() = user_id);

create policy hint_usage_update_own
  on public.hint_usage
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy hint_usage_delete_own
  on public.hint_usage
  for delete
  using (auth.uid() = user_id);

-- user_achievements policies
create policy user_achievements_select_own
  on public.user_achievements
  for select
  using (auth.uid() = user_id);

create policy user_achievements_insert_own
  on public.user_achievements
  for insert
  with check (auth.uid() = user_id);

create policy user_achievements_delete_own
  on public.user_achievements
  for delete
  using (auth.uid() = user_id);

-- Make public reference data readable by everyone (optional)
alter table public.categories enable row level security;
alter table public.problems enable row level security;
alter table public.approaches enable row level security;
alter table public.hints enable row level security;

create policy categories_read_all on public.categories for select using (true);
create policy problems_read_all on public.problems for select using (true);
create policy approaches_read_all on public.approaches for select using (true);
create policy hints_read_all on public.hints for select using (true);

-- Ensure slug column exists if this script is applied after initial creation
alter table public.problems add column if not exists slug text unique;