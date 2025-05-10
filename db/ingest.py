import subprocess

def ingest_table(table_name, file_path):
    print(f"Loading {file_path} into {table_name}")
    command = f"""
    psql -h db -U postgres -d addressdb -c "\\copy {table_name} FROM '{file_path}' WITH (FORMAT CSV, HEADER);"
    """
    subprocess.run(command, shell=True, check=True)

if __name__ == "__main__":
    ingest_table("canonical_addresses", "data/11211_Addresses.csv")
    ingest_table("transactions", "data/transactions_2_11211.csv")
