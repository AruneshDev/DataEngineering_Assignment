Known Blockers & Issues Faced During Setup

    .xlsx Files Incompatible with \copy

        The original datasets were in Excel format (.xlsx), but PostgreSQL's \copy command only accepts .csv or .txt.

        Resolution: Converted .xlsx files to .csv using pandas.

    Duplicate Primary Key (hhid) in canonical_addresses

        The hhid field was originally defined as PRIMARY KEY, but the CSV had duplicate entries.

        Resolution: Either dropped the PRIMARY KEY constraint or deduplicated the CSV using pandas.

    Float Value in year_built Column

        CSV had year_built values like 1950.0, but schema expected INTEGER.

        Resolution: Changed year_built column type from INT to NUMERIC in the schema.

    Malformed JSON in open_house Column

        open_house contained complex JSON-like strings that caused JSONB type parsing to fail.

        Resolution:

            Temporarily changed open_house column to TEXT OR

            Dropped the column from the schema during early development.

    Extra Columns in CSV (Schema Mismatch)

        Ingest failed with: extra data after last expected column, due to mismatch between CSV columns and table schema.

        Resolution: Trimmed or aligned the CSV column headers to match the schema exactly.

    Re-ingestion After Table Recreation

        Running psql -f schema.sql resets the tables, but without deduplication, reinserting the same data would fail due to constraints.

        Resolution: Either TRUNCATE and reinsert clean data, or remove constraints.

    Docker File Visibility Issues

        At times, COPY failed because files weren’t visible to the container.

        Resolution: Ensured volumes: section in docker-compose.yml mounts the full project context to /app.

✅ Lessons Learned / Recommendations

    Always clean and validate .csv files before ingestion.

    Avoid strict constraints (e.g., PKs or strict types) in early development.

    Use TEXT for unpredictable fields like dates or freeform JSON blobs.

    Keep schema and CSV headers in sync to avoid COPY command failures.

    Add logging to data cleaning steps for clarity and reproducibility.

