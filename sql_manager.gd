extends Node

var db

func _ready():
    db = SQLite.new()
    var path = "res://database.db"
    if db.open(path) != OK:
        print("Failed to open database")
        return

    # Create highscores table
    var create_table_query = "CREATE TABLE IF NOT EXISTS highscores (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, score INTEGER);"
    if db.query(create_table_query) != OK:
        print("Failed to create table")
        return

    # Insert example data
    var insert_data_query = "INSERT INTO highscores (name, score) VALUES ('Player1', 100), ('Player2', 200);"
    if db.query(insert_data_query) != OK:
        print("Failed to insert data")
        return

    # Fetch and print data
    var select_query = "SELECT * FROM highscores;"
    if db.query(select_query) == OK:
        while db.step() == OK:
            print("ID: ", db.get_column_int(0), " Name: ", db.get_column_text(1), " Score: ", db.get_column_int(2))
    else:
        print("Failed to fetch data")

    db.close()