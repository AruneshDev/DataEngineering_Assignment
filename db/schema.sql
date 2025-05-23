DROP TABLE IF EXISTS canonical_addresses;
CREATE TABLE canonical_addresses (
    hhid TEXT ,-- should be primary key but has duplicates
    fname TEXT,
    mname TEXT,
    lname TEXT,
    suffix TEXT,
    address TEXT,
    house TEXT,
    predir TEXT,
    street TEXT,
    strtype TEXT,
    postdir TEXT,
    apttype TEXT,
    aptnbr TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    homeownercd TEXT
);

-- Indexes for address matching (can be adjusted later)
CREATE INDEX idx_canonical_address_lookup ON canonical_addresses(house, street, strtype, aptnbr, zip);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    id TEXT PRIMARY KEY,
    status TEXT,
    price NUMERIC,
    bedrooms INT,
    bathrooms INT,
    square_feet INT,
    address_line_1 TEXT,
    address_line_2 TEXT,
    city TEXT,
    state TEXT,
    zip_code TEXT,
    property_type TEXT,
    year_built NUMERIC,
    presented_by TEXT,
    brokered_by TEXT,
    presented_by_mobile TEXT,
    mls TEXT,
    listing_office_id TEXT,
    listing_agent_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    open_house TEXT,  -- Accept it as TEXT to bypass JSON parsing issues
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    email TEXT,
    list_date TEXT,
    pending_date TEXT,
    presented_by_first_name TEXT,
    presented_by_last_name TEXT,
    presented_by_middle_name TEXT,
    presented_by_suffix TEXT,
    geog TEXT
);

-- DROP TABLE IF EXISTS transactions;
-- CREATE TABLE transactions (
--     id TEXT PRIMARY KEY,
--     status TEXT,
--     price NUMERIC,
--     bedrooms INT,
--     bathrooms INT,
--     square_feet INT,
--     address_line_1 TEXT,
--     address_line_2 TEXT,
--     city TEXT,
--     state TEXT,
--     zip_code TEXT,
--     property_type TEXT,
--     year_built NUMERIC,  -- Changed from INT to NUMERIC to handle float values
--     presented_by TEXT,
--     brokered_by TEXT,
--     presented_by_mobile TEXT,
--     mls TEXT,
--     listing_office_id TEXT,
--     listing_agent_id TEXT,
--     created_at TEXT,  -- Changed from TIMESTAMP to TEXT to avoid format issues
--     updated_at TEXT,  -- Same here
--     -- open_house JSONB,  -- Changed from BOOLEAN to JSONB to support full structure
--     latitude DOUBLE PRECISION,
--     longitude DOUBLE PRECISION,
--     email TEXT,
--     list_date TEXT,  -- Changed to TEXT in case of inconsistent formatting
--     pending_date TEXT,
--     presented_by_first_name TEXT,
--     presented_by_last_name TEXT,
--     presented_by_middle_name TEXT,
--     presented_by_suffix TEXT,
--     geog TEXT
-- );

-- Index for lookup (optional)
CREATE INDEX idx_transaction_address ON transactions(address_line_1, address_line_2, zip_code);
