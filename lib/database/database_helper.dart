import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('apotek.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // add avatarUrl column to user table
      try {
        await db.execute("ALTER TABLE user ADD COLUMN avatarUrl TEXT;");
      } catch (e) {
        // ignore if column exists or other errors
      }
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT NOT NULL,
      username TEXT NOT NULL UNIQUE,
      telepon TEXT,
      alamat TEXT,
      password TEXT NOT NULL,
      avatarUrl TEXT
    );
    ''');

    await db.execute('''
    CREATE TABLE transaksi (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      obatId TEXT,
      obatNama TEXT,
      hargaSatuan INTEGER,
      jumlah INTEGER,
      total INTEGER,
      namaPembeli TEXT,
      metode TEXT,
      nomorResep TEXT,
      catatan TEXT,
      tanggal TEXT
    );
    ''');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
