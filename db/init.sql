CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO users (name, email) VALUES
('Jan Novak', 'jan@example.com'),
('Petra Svobodova', 'petra@example.com'),
('Karel Dvorak', 'karel@example.com');