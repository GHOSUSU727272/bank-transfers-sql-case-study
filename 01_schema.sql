-- PostgreSQL. Synthetic practice schema.
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL
);

CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    currency CHAR(3) NOT NULL
);

CREATE TABLE transfers (
    id INTEGER PRIMARY KEY,
    sender_account_id INTEGER NOT NULL REFERENCES accounts(id),
    receiver_account_id INTEGER NOT NULL REFERENCES accounts(id),
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    status TEXT NOT NULL CHECK (status IN ('pending','completed','failed')),
    created_at TIMESTAMP NOT NULL
);
