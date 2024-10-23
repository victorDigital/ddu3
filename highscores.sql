-- Create highscores table
CREATE TABLE IF NOT EXISTS highscores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    score INTEGER
);

-- Insert example data
INSERT INTO highscores (name, score) VALUES
('Player1', 100),
('Player2', 200);