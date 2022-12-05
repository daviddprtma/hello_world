import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "cart.db";
  static const _databaseVersion = 1;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // functions here

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE cart	 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      movie_id INTEGER NOT NULL,
      title TEXT NOT NULL,
      jumlah TEXT NOT NULL
     )
     ''');
  }

  Future<int?> addCart(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert('cart', row);
  }

  Future<List<Map<String, dynamic>>?> viewCart() async {
    Database? db = await instance.database;
    return await db?.query('cart');
  }

  Future tambahJumlah(movie_id) async {
    Database? db = await instance.database;
    await db?.execute('''
     UPDATE cart SET jumlah=jumlah+1
     WHERE movie_id=${movie_id}
     ''');
  }

  Future kurangJumlah(movie_id) async {
    Database? db = await instance.database;
    await db?.execute('''
     UPDATE cart SET jumlah=jumlah-1
     WHERE movie_id=${movie_id}
     ''');
  }
}
