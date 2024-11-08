import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'personel.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Personel(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ad TEXT NOT NULL,
        soyad TEXT NOT NULL,
        departman TEXT NOT NULL,
        maas INTEGER NOT NULL
      )
    ''');
  }

  // Veri Ekleme
  Future<int> insertPersonel(Map<String, dynamic> personel) async {
    final db = await database;
    return await db.insert('Personel', personel);
  }

  // Veri Güncelleme
  Future<int> updatePersonel(int id, Map<String, dynamic> personel) async {
    final db = await database;
    return await db.update('Personel', personel, where: 'id = ?', whereArgs: [id]);
  }

  // Veri Silme
  Future<int> deletePersonel(int id) async {
    final db = await database;
    return await db.delete('Personel', where: 'id = ?', whereArgs: [id]);
  }

  // Verileri Listeleme
  Future<List<Map<String, dynamic>>> getPersonelList() async {
    final db = await database;
    return await db.query('Personel');
  }

  // Departmana Göre Ortalama Maaş Gruplama
  Future<List<Map<String, dynamic>>> getAverageSalaryByDepartment() async {
    final db = await database;
    return await db.rawQuery('SELECT departman, AVG(maas) AS avg_maas FROM Personel GROUP BY departman');
  }
}
