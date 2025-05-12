import subprocess

def ingest_table(table_name, file_path):
    print(f"Loading {file_path} into {table_name}")
    truncate_cmd = f'psql -h db -U postgres -d addressdb -c "TRUNCATE {table_name};"'
    subprocess.run(truncate_cmd, shell=True, check=True)

    copy_cmd = f'psql -h db -U postgres -d addressdb -c "\\copy {table_name} FROM \'{file_path}\' WITH (FORMAT CSV, HEADER);"'
    subprocess.run(copy_cmd, shell=True, check=True)


if __name__ == "__main__":
    ingest_table("canonical_addresses", "data/11211_Addresses.csv")
    ingest_table("transactions", "data/transactions_2_11211.csv")
