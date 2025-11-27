INSERT INTO users (first_name, last_name, password, role, birthdate, email) VALUES
('Иван', 'Иванов', 'hashed_user_pass', 'USER', '1995-05-15', 'ivan@example.com'),
('Анна', 'Смирнова', 'hashed_admin_pass', 'ADMIN', '1988-11-20', 'anna@example.com'),
('Петр', 'Сидоров', 'hashed_manager_pass', 'MANAGER', '2001-01-01', 'petr@example.com');



INSERT INTO genre (name) VALUES
('Фантастика'),
('Детектив'),
('Роман'),
('Научпоп'),
('Поэзия');


INSERT INTO books (title, author, isbn, page_count, price, publication_year, stock) VALUES
('Автостопом по Галактике', 'Дуглас Адамс', '9785170917630', 416, 550.00, '2016-01-01', 50),
('Шерлок Холмс. Сборник', 'Артур Конан Дойл', '9785170925765', 640, 780.50, '2018-03-10', 12),
('Мастер и Маргарита', 'Михаил Булгаков', '9785041049963', 448, 450.00, '2019-07-25', 5),
('Космос: Смерть и жизнь', 'Карл Саган', '9785170842215', 250, 999.00, '2020-05-01', 20);


INSERT INTO book_genre (book_id, genre_id) VALUES
(1, (SELECT id FROM genre WHERE name = 'Фантастика')),
(2, (SELECT id FROM genre WHERE name = 'Детектив')),
(3, (SELECT id FROM genre WHERE name = 'Фантастика')),
(3, (SELECT id FROM genre WHERE name = 'Роман')),
(4, (SELECT id FROM genre WHERE name = 'Научпоп'));


INSERT INTO orders (user_id, status) VALUES
((SELECT id FROM users WHERE email = 'ivan@example.com'), 'IN_CART');

INSERT INTO order_item (order_id, book_id, quantity, price) VALUES
(currval('orders_id_seq'), 1, 1, 550.00),
(currval('orders_id_seq'), 4, 2, 999.00);

INSERT INTO orders (user_id, total_cost, status) VALUES
((SELECT id FROM users WHERE email = 'anna@example.com'), 780.50, 'PAID');

INSERT INTO order_item (order_id, book_id, quantity, price) VALUES
(currval('orders_id_seq'), 2, 1, 780.50);