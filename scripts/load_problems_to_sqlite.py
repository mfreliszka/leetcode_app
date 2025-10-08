#!/usr/bin/env python3
"""
Load problem JSONs (matching problem_template.json schema) into a local SQLite database.

Usage:
  python scripts/load_problems_to_sqlite.py --input data/problems/1004_valid_anagram.json --db problems.db
  python scripts/load_problems_to_sqlite.py --input-dir data/problems --db problems.db
"""

import argparse
import json
import os
import sqlite3
from typing import Any, Dict, List


def connect_db(db_path: str) -> sqlite3.Connection:
    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON;")
    # Performance-oriented PRAGMAs for fast reads
    conn.execute("PRAGMA journal_mode=WAL;")
    conn.execute("PRAGMA synchronous=NORMAL;")
    conn.execute("PRAGMA temp_store=MEMORY;")
    conn.execute("PRAGMA cache_size=-20000;")
    return conn


def verify_schema(conn: sqlite3.Connection) -> None:
    cur = conn.cursor()
    cur.execute("SELECT name FROM sqlite_master WHERE type='table'")
    names = {row[0] for row in cur.fetchall()}
    required = {
        "problems",
        "constraints",
        "test_cases",
        "approaches",
        "implementations",
        "comparison_rows",
        "quiz_pattern_map",
        "quiz_approach_identifier",
        "quiz_complexity_facts",
    }
    missing = sorted(required - names)
    if missing:
        raise SystemExit(
            "Database schema missing tables: "
            + ", ".join(missing)
            + ". Run `python scripts/init_sqlite_schema.py --db <db>` to initialize."
        )


def insert_problem(conn: sqlite3.Connection, doc: Dict[str, Any]) -> None:
    cur = conn.cursor()

    # Problems
    content = doc.get("content", {})
    cur.execute(
        """
        INSERT INTO problems (id, title, difficulty, is_premium, is_neetcode_150, is_blind_75, category_id, category_name, statement, input_format, output_format)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(id) DO UPDATE SET
            title=excluded.title,
            difficulty=excluded.difficulty,
            is_premium=excluded.is_premium,
            is_neetcode_150=excluded.is_neetcode_150,
            is_blind_75=excluded.is_blind_75,
            category_id=excluded.category_id,
            category_name=excluded.category_name,
            statement=excluded.statement,
            input_format=excluded.input_format,
            output_format=excluded.output_format
        """,
        (
            doc["id"],
            doc.get("title", ""),
            doc.get("difficulty", ""),
            1 if doc.get("is_premium") else 0,
            1 if doc.get("is_neetcode_150") else 0,
            1 if doc.get("is_blind_75") else 0,
            doc.get("category_id", 0),
            doc.get("category_name"),
            content.get("statement", ""),
            content.get("input_format", ""),
            content.get("output_format", ""),
        ),
    )

    # Constraints
    cur.execute("DELETE FROM constraints WHERE problem_id = ?", (doc["id"],))
    for c in content.get("constraints", []):
        cur.execute(
            "INSERT OR REPLACE INTO constraints (problem_id, name, value, explanation) VALUES (?, ?, ?, ?)",
            (doc["id"], c.get("name", ""), c.get("value", ""), c.get("explanation", "")),
        )

    # Test cases
    cur.execute("DELETE FROM test_cases WHERE problem_id = ?", (doc["id"],))
    for tc in doc.get("test_cases", []):
        cur.execute(
            "INSERT INTO test_cases (problem_id, name, input_json, output, explanation) VALUES (?, ?, ?, ?, ?)",
            (
                doc["id"],
                tc.get("name", ""),
                json.dumps(tc.get("input", {})),
                str(tc.get("output", "")),
                tc.get("explanation", ""),
            ),
        )

    # Approaches and implementations
    cur.execute("DELETE FROM implementations WHERE approach_id IN (SELECT id FROM approaches WHERE problem_id = ?)", (doc["id"],))
    cur.execute("DELETE FROM approaches WHERE problem_id = ?", (doc["id"],))
    for ap in doc.get("approaches", []):
        trick = ap.get("trick", {})
        # Map approach-specific coding pattern key to a unified column
        coding_pattern = None
        if ap.get("key") == "brute_force":
            coding_pattern = ap.get("brute_force_solution_coding_pattern")
        elif ap.get("key") == "optimized":
            coding_pattern = ap.get("optimized_solution_coding_pattern")
        elif ap.get("key") == "optimal":
            coding_pattern = ap.get("optimal_solution_coding_pattern")
        cur.execute(
            """
            INSERT INTO approaches (
                problem_id, key, name, coding_pattern, time_complexity, time_explanation, time_explanation_for_quiz,
                space_complexity, space_explanation, space_explanation_for_quiz, explanation,
                trick_summary, trick_details_json, pros_json, cons_json
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                doc["id"],
                ap.get("key", ""),
                ap.get("name", ""),
                coding_pattern,
                ap.get("time_complexity", ""),
                ap.get("time_explanation", ""),
                ap.get("time_explanation_for_quiz"),
                ap.get("space_complexity", ""),
                ap.get("space_explanation", ""),
                ap.get("space_explanation_for_quiz"),
                ap.get("explanation", ""),
                trick.get("summary"),
                json.dumps(trick.get("details", [])) if trick else None,
                json.dumps(ap.get("pros", [])),
                json.dumps(ap.get("cons", [])),
            ),
        )
        approach_id = cur.lastrowid

        impls = ap.get("implementations", {})
        for lang, spec in impls.items():
            cur.execute(
                "INSERT INTO implementations (approach_id, language, code) VALUES (?, ?, ?)",
                (approach_id, lang, spec.get("code", "")),
            )

    # Comparison table
    comp = doc.get("comparison_table", {})
    cur.execute("DELETE FROM comparison_rows WHERE problem_id = ?", (doc["id"],))
    for row in comp.get("rows", []):
        cur.execute(
            "INSERT INTO comparison_rows (problem_id, approach, time, space, pros_json, cons_json) VALUES (?, ?, ?, ?, ?, ?)",
            (
                doc["id"],
                row.get("approach", ""),
                row.get("time", ""),
                row.get("space", ""),
                json.dumps(row.get("pros", [])),
                json.dumps(row.get("cons", [])),
            ),
        )

    # Populate quiz materialized tables
    # Pattern map: select optimal approach
    optimal = None
    for ap in doc.get("approaches", []):
        if ap.get("key") == "optimal":
            optimal = ap
            break
    cur.execute("DELETE FROM quiz_pattern_map WHERE problem_id = ?", (doc["id"],))
    if optimal:
        # Resolve coding pattern for optimal
        coding_pattern = optimal.get("optimal_solution_coding_pattern")
        cur.execute(
            "INSERT INTO quiz_pattern_map (problem_id, optimal_approach_key, optimal_approach_name, optimal_coding_pattern, difficulty, category_id, is_premium) VALUES (?, ?, ?, ?, ?, ?, ?)",
            (
                doc["id"],
                optimal.get("key"),
                optimal.get("name"),
                coding_pattern,
                doc.get("difficulty"),
                doc.get("category_id", 0),
                1 if doc.get("is_premium") else 0,
            ),
        )

    # Approach identifier: short code snippets per implementation
    cur.execute("DELETE FROM quiz_approach_identifier WHERE problem_id = ?", (doc["id"],))
    for ap in doc.get("approaches", []):
        # Find approach_id by (problem_id, key, name)
        cur.execute(
            "SELECT id FROM approaches WHERE problem_id = ? AND key = ? AND name = ?",
            (doc["id"], ap.get("key", ""), ap.get("name", "")),
        )
        row = cur.fetchone()
        if not row:
            continue
        approach_id = row[0]
        for lang, spec in ap.get("implementations", {}).items():
            code = (spec or {}).get("code", "")
            snippet = code.strip().split("\n")
            snippet_short = "\n".join(snippet[:8])  # first 8 lines
            cur.execute(
                "INSERT INTO quiz_approach_identifier (problem_id, approach_id, approach_key, approach_name, language, code_snippet_short) VALUES (?, ?, ?, ?, ?, ?)",
                (
                    doc["id"],
                    approach_id,
                    ap.get("key", ""),
                    ap.get("name", ""),
                    lang,
                    snippet_short,
                ),
            )

    # Complexity facts
    cur.execute("DELETE FROM quiz_complexity_facts WHERE problem_id = ?", (doc["id"],))
    for ap in doc.get("approaches", []):
        cur.execute(
            "SELECT id FROM approaches WHERE problem_id = ? AND key = ? AND name = ?",
            (doc["id"], ap.get("key", ""), ap.get("name", "")),
        )
        row = cur.fetchone()
        if not row:
            continue
        approach_id = row[0]
        cur.execute(
            "INSERT INTO quiz_complexity_facts (problem_id, approach_id, approach_key, time_complexity, time_explanation_for_quiz, space_complexity, space_explanation_for_quiz) VALUES (?, ?, ?, ?, ?, ?, ?)",
            (
                doc["id"],
                approach_id,
                ap.get("key", ""),
                ap.get("time_complexity", ""),
                ap.get("time_explanation_for_quiz"),
                ap.get("space_complexity", ""),
                ap.get("space_explanation_for_quiz"),
            ),
        )

    conn.commit()


def load_one(path: str, conn: sqlite3.Connection) -> None:
    with open(path, "r", encoding="utf-8") as f:
        doc = json.load(f)
    insert_problem(conn, doc)
    print(f"Loaded problem {doc.get('id')} - {doc.get('title')} from {path}")


def iter_json_files(input_dir: str) -> List[str]:
    files: List[str] = []
    for root, _, filenames in os.walk(input_dir):
        for fn in filenames:
            if fn.endswith(".json"):
                files.append(os.path.join(root, fn))
    return sorted(files)


def main() -> None:
    parser = argparse.ArgumentParser(description="Load problem JSONs into SQLite")
    parser.add_argument("--input", help="Path to a single problem JSON file")
    parser.add_argument("--input-dir", help="Directory containing problem JSON files")
    parser.add_argument("--db", default="problems.db", help="SQLite database file path")
    args = parser.parse_args()

    if not args.input and not args.input_dir:
        parser.error("Provide --input or --input-dir")

    conn = connect_db(args.db)
    try:
        verify_schema(conn)
        if args.input:
            load_one(args.input, conn)
        else:
            files = iter_json_files(args.input_dir)
            if not files:
                print(f"No JSON files found in {args.input_dir}")
            for path in files:
                load_one(path, conn)
        print(f"Done. Database: {args.db}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()