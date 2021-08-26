# sqflite_example_ui

This is a boilerplate project for implementing SQFLite into Simple Mobile UI based on Flutter cookbooks. In Flutter cookbooks, it only implements some SQLite functions into main function but in this project, I try to read other peoples' source codes and implement database (backend) and UI (frontend).

- Dog model combines with DoggieDatabaseService to implement CRUD functions
- Creating database only requires Singleton design patterns.

## Getting Started

Four files: 
- main.dart and show_all.dart show UI 
- dog.dart shows Dog model.
- database.dart implements CRUD methods for Dog model.