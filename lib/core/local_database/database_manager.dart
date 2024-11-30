import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static const String _dbName = 'currency_converter.db';
  static const int _dbVersion = 1;

  Database? _database;

  static final DatabaseManager _instance = DatabaseManager._internal();

  DatabaseManager._internal();

  factory DatabaseManager() => _instance;

  Future<void> initDatabase() async {
    if (_database != null) return;

    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _dbName);
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE currencies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT NOT NULL,
            rate REAL NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      await initDatabase();
    }
    return _database!;
  }
}
