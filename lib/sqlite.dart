import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDb {
  static const String _databaseName = "CarParts.db";
  static const int _databaseVersion = 1;

  static final SqliteDb instance = SqliteDb.internal();

  static Database _database;

  factory SqliteDb() => instance;

  SqliteDb.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();

    return _database;
  }

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items (
        id TEXT PRIMARY KEY,
        product_name TEXT,
        product_id TEXT,
        product_image TEXT,
        quantity INTEGER,
        price INTEGER
      )
    ''');
  }
}
