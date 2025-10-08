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
    return conn


def init_schema(conn: sqlite3.Connection) -> None:
    cur = conn.cursor()
    cur.executescript(
        """
        CREATE TABLE IF NOT EXISTS problems (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            difficulty TEXT NOT NULL,
            is_neetcode_150 INTEGER NOT NULL,
            is_blind_75 INTEGER NOT NULL,
            category_id INTEGER NOT NULL,
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
            time_complexity TEXT NOT NULL,
            time_explanation TEXT,
            space_complexity TEXT NOT NULL,
            space_explanation TEXT,
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
        """
    )
    conn.commit()


def insert_problem(conn: sqlite3.Connection, doc: Dict[str, Any]) -> None:
    cur = conn.cursor()

    # Problems
    content = doc.get("content", {})
    cur.execute(
        """
        INSERT INTO problems (id, title, difficulty, is_neetcode_150, is_blind_75, category_id, statement, input_format, output_format)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(id) DO UPDATE SET
            title=excluded.title,
            difficulty=excluded.difficulty,
            is_neetcode_150=excluded.is_neetcode_150,
            is_blind_75=excluded.is_blind_75,
            category_id=excluded.category_id,
            statement=excluded.statement,
            input_format=excluded.input_format,
            output_format=excluded.output_format
        """,
        (
            doc["id"],
            doc["title"],
            doc["difficulty"],
            1 if doc.get("is_neetcode_150") else 0,
            1 if doc.get("is_blind_75") else 0,
            doc.get("category_id", 0),
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
        cur.execute(
            """
            INSERT INTO approaches (
                problem_id, key, name, time_complexity, time_explanation, space_complexity, space_explanation, explanation,
                trick_summary, trick_details_json, pros_json, cons_json
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                doc["id"],
                ap.get("key", ""),
                ap.get("name", ""),
                ap.get("time_complexity", ""),
                ap.get("time_explanation", ""),
                ap.get("space_complexity", ""),
                ap.get("space_explanation", ""),
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
        init_schema(conn)
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