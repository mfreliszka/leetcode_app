#!/usr/bin/env python3
"""
Initialize the local SQLite database schema for the app, optimized for fast reads
and future quiz features. This script only creates tables, indexes, and PRAGMAs.

Usage:
  python scripts/init_sqlite_schema.py --db problems.db
"""

import argparse
import sqlite3


PRAGMAS = [
    "PRAGMA journal_mode=WAL;",
    "PRAGMA synchronous=NORMAL;",
    "PRAGMA temp_store=MEMORY;",
    # Negative cache size sets size in KB; -20000 ~ 20MB
    "PRAGMA cache_size=-20000;",
    # Page size (set before creating tables for best effect on new DBs)
    "PRAGMA page_size=4096;",
]


DDL = """
CREATE TABLE IF NOT EXISTS problems (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    difficulty TEXT NOT NULL,
    is_premium INTEGER NOT NULL DEFAULT 0,
    is_neetcode_150 INTEGER NOT NULL DEFAULT 0,
    is_blind_75 INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER NOT NULL,
    category_name TEXT,
    statement TEXT NOT NULL,
    input_format TEXT,
    output_format TEXT
);

CREATE TABLE IF NOT EXISTS constraints (
    problem_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    value TEXT NOT NULL,
    explanation TEXT,
    PRIMARY KEY (problem_id, name),
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS test_cases (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    input_json TEXT NOT NULL,
    output TEXT NOT NULL,
    explanation TEXT,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS approaches (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    key TEXT NOT NULL,
    name TEXT NOT NULL,
    coding_pattern TEXT,
    time_complexity TEXT NOT NULL,
    time_explanation TEXT,
    time_explanation_for_quiz TEXT,
    space_complexity TEXT NOT NULL,
    space_explanation TEXT,
    space_explanation_for_quiz TEXT,
    explanation TEXT,
    trick_summary TEXT,
    trick_details_json TEXT,
    pros_json TEXT,
    cons_json TEXT,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS implementations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    approach_id INTEGER NOT NULL,
    language TEXT NOT NULL,
    code TEXT NOT NULL,
    FOREIGN KEY (approach_id) REFERENCES approaches(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comparison_rows (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    approach TEXT NOT NULL,
    time TEXT NOT NULL,
    space TEXT NOT NULL,
    pros_json TEXT,
    cons_json TEXT,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

-- Quiz-optimized materialized tables for fast reads
CREATE TABLE IF NOT EXISTS quiz_pattern_map (
    problem_id INTEGER PRIMARY KEY,
    optimal_approach_key TEXT,
    optimal_approach_name TEXT,
    optimal_coding_pattern TEXT,
    difficulty TEXT,
    category_id INTEGER,
    is_premium INTEGER,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quiz_approach_identifier (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    approach_id INTEGER NOT NULL,
    approach_key TEXT NOT NULL,
    approach_name TEXT NOT NULL,
    language TEXT NOT NULL,
    code_snippet_short TEXT NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    FOREIGN KEY (approach_id) REFERENCES approaches(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quiz_complexity_facts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    approach_id INTEGER NOT NULL,
    approach_key TEXT NOT NULL,
    time_complexity TEXT NOT NULL,
    time_explanation_for_quiz TEXT,
    space_complexity TEXT NOT NULL,
    space_explanation_for_quiz TEXT,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    FOREIGN KEY (approach_id) REFERENCES approaches(id) ON DELETE CASCADE
);

-- Indexes for blazing-fast reads
CREATE INDEX IF NOT EXISTS idx_problems_difficulty ON problems(difficulty);
CREATE INDEX IF NOT EXISTS idx_problems_category ON problems(category_id);
CREATE INDEX IF NOT EXISTS idx_problems_premium ON problems(is_premium);

CREATE INDEX IF NOT EXISTS idx_constraints_problem ON constraints(problem_id);
CREATE INDEX IF NOT EXISTS idx_test_cases_problem ON test_cases(problem_id);
CREATE INDEX IF NOT EXISTS idx_approaches_problem_key ON approaches(problem_id, key);
CREATE INDEX IF NOT EXISTS idx_implementations_approach_lang ON implementations(approach_id, language);
CREATE INDEX IF NOT EXISTS idx_comparison_rows_problem ON comparison_rows(problem_id);

CREATE INDEX IF NOT EXISTS idx_quiz_pattern_map_diff_cat ON quiz_pattern_map(difficulty, category_id);
CREATE INDEX IF NOT EXISTS idx_quiz_approach_identifier_lang ON quiz_approach_identifier(language);
CREATE INDEX IF NOT EXISTS idx_quiz_complexity_facts_problem ON quiz_complexity_facts(problem_id);
"""


def main():
    parser = argparse.ArgumentParser(description="Initialize SQLite schema for app")
    parser.add_argument("--db", default="problems.db", help="SQLite database file path")
    args = parser.parse_args()

    conn = sqlite3.connect(args.db)
    try:
        cur = conn.cursor()
        for p in PRAGMAS:
            cur.execute(p)
        cur.executescript(DDL)
        conn.commit()
        print(f"Initialized schema with PRAGMAs. Database: {args.db}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()