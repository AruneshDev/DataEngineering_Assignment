import psycopg2
import usaddress

DB_PARAMS = {
    "host": "db",
    "dbname": "addressdb",
    "user": "postgres",
    "password": "postgres"
}

def parse_address(address):
    try:
        tagged, _ = usaddress.tag(address)
        return {
            "street_number": tagged.get("AddressNumber"),
            "street_name": tagged.get("StreetName"),
            "street_type": tagged.get("StreetNamePostType"),
            "unit_type": tagged.get("OccupancyType"),
            "unit_number": tagged.get("OccupancyIdentifier")
        }
    except usaddress.RepeatedLabelError:
        return {}

def normalize_transactions():
    conn = psycopg2.connect(**DB_PARAMS)
    cur = conn.cursor()

    cur.execute("SELECT id, address_line_1 FROM transactions;")
    rows = cur.fetchall()

    for txn_id, raw_address in rows:
        if not raw_address:
            continue

        parsed = parse_address(raw_address)

        if parsed:
            cur.execute("""
                UPDATE transactions
                SET street_number = %s,
                    street_name = %s,
                    street_type = %s,
                    unit_type = %s,
                    unit_number = %s
                WHERE id = %s;
            """, (
                parsed.get("street_number"),
                parsed.get("street_name"),
                parsed.get("street_type"),
                parsed.get("unit_type"),
                parsed.get("unit_number"),
                txn_id
            ))

    conn.commit()
    cur.close()
    conn.close()
    print("✅ Address normalization complete.")

if __name__ == "__main__":
    normalize_transactions()
