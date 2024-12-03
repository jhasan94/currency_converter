import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static const String _dbName = 'currency_converter.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'currencies';

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
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            currencyId TEXT,
            currencyName TEXT,
            currencySymbol TEXT,
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
