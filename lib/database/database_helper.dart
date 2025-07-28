import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food.dart';

class FoodDatabase {
  static final FoodDatabase instance = FoodDatabase._init();
  static Database? _database;

  FoodDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('foods.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE foods (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      desc TEXT,
      imgUrl TEXT,
      waitTime TEXT,
      score REAL,
      cal TEXT,
      price REAL NOT NULL,
      quantity INTEGER NOT NULL,
      about TEXT,
      isFavorite INTEGER NOT NULL,
      hightLight INTEGER NOT NULL,
      ingredients TEXT
    )
  ''');
}


  Future<int> createFood(Food food) async {
    final db = await instance.database;
    return await db.insert('foods', food.toMap());
  }

  Future<List<Food>> readAllFoods() async {
    final db = await instance.database;
    final result = await db.query('foods');

    return result.map((json) => Food.fromMap(json)).toList();
  }

  Future<int> updateFood(Food food) async {
    final db = await instance.database;
    return db.update(
      'foods',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  Future<int> deleteFood(int id) async {
    final db = await instance.database;
    return await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}



 