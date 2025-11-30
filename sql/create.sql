CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    password VARCHAR(128) NOT NULL,
    role VARCHAR(64) NOT NULL,
    birthdate DATE,
    email VARCHAR(128) UNIQUE NOT NULL
);

CREATE INDEX idx_user_email ON users(email);

CREATE TABLE genre (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE books (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    page_count INTEGER CHECK (page_count > 0) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0) NOT NULL,
    publication_year DATE,
    stock INTEGER DEFAULT 0 CHECK (stock >= 0) NOT NULL,
    image_path VARCHAR(512),
    description TEXT
);

CREATE INDEX idx_book_isbn ON books(isbn);

CREATE TABLE book_genre (
    book_id BIGINT REFERENCES books(id) ON DELETE CASCADE,
    genre_id BIGINT REFERENCES genre(id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, genre_id)
);

DROP TYPE IF EXISTS order_status CASCADE;

CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    total_cost NUMERIC(10, 2) CHECK (total_cost >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'IN_CART',
    address VARCHAR(512),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_order_user_status ON orders(user_id, status);

CREATE TABLE order_item (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
    book_id BIGINT REFERENCES books(id) ON DELETE RESTRICT NOT NULL,
    quantity INTEGER CHECK (quantity > 0) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0) NOT NULL
);

CREATE INDEX idx_order_item_order ON order_item(order_id);
