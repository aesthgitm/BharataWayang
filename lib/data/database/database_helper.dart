import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'database_seeder.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bharatawayang.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Menggunakan getApplicationDocumentsDirectory agar file database disimpan di area persisten dokumen aplikasi
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }


  Future _createDB(Database db, int version) async {
    // 1. users
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        nama_lengkap TEXT,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    // 2. kartu_wayang
    await db.execute('''
      CREATE TABLE kartu_wayang (
        id INTEGER PRIMARY KEY,
        nama TEXT NOT NULL,
        afiliasi TEXT,
        deskripsi TEXT,
        kekuatan TEXT,
        pusaka TEXT,
        nilai_moral TEXT,
        image_asset TEXT,
        rarity TEXT,
        unlock_skor_min INTEGER
      )
    ''');

    // 3. user_koleksi
    await db.execute('''
      CREATE TABLE user_koleksi (
        user_id INTEGER,
        kartu_id INTEGER,
        unlocked_at TEXT,
        PRIMARY KEY (user_id, kartu_id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (kartu_id) REFERENCES kartu_wayang(id) ON DELETE CASCADE
      )
    ''');

    // 4. kumpulan_soal
    await db.execute('''
      CREATE TABLE kumpulan_soal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level INTEGER NOT NULL,
        kategori TEXT NOT NULL,
        pertanyaan TEXT NOT NULL,
        pilihan_a TEXT NOT NULL,
        pilihan_b TEXT NOT NULL,
        pilihan_c TEXT NOT NULL,
        pilihan_d TEXT NOT NULL,
        jawaban_benar TEXT NOT NULL,
        penjelasan TEXT
      )
    ''');

    // 5. progres_kuis
    await db.execute('''
      CREATE TABLE progres_kuis (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        level INTEGER,
        skor INTEGER,
        total_soal INTEGER,
        dikerjakan_pada TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    // 6. level_unlocked
    await db.execute('''
      CREATE TABLE level_unlocked (
        user_id INTEGER,
        level INTEGER,
        skor_terbaik INTEGER DEFAULT 0,
        PRIMARY KEY (user_id, level),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    // 8. serat_mahabharata
    await db.execute('''
      CREATE TABLE serat_mahabharata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_parwa TEXT NOT NULL,
        nama_babak TEXT NOT NULL,
        isi_narasi TEXT NOT NULL,
        parwa_id INTEGER,
        urutan INTEGER
      )
    ''');

    // 9. faq_mahabharata
    await db.execute('''
      CREATE TABLE faq_mahabharata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pertanyaan TEXT NOT NULL,
        jawaban TEXT NOT NULL,
        urutan INTEGER
      )
    ''');

    // 10. progres_narasi
    await db.execute('''
      CREATE TABLE progres_narasi (
        user_id INTEGER,
        babak_id INTEGER,
        sudah_dibaca INTEGER DEFAULT 0,
        PRIMARY KEY (user_id, babak_id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (babak_id) REFERENCES serat_mahabharata(id) ON DELETE CASCADE
      )
    ''');

    // 11. feedback
    await db.execute('''
      CREATE TABLE feedback (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        isi_feedback TEXT NOT NULL,
        rating INTEGER,
        dikirim_pada TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    // Seed initial data
    await DatabaseSeeder.seedDatabase(db);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Map<String, dynamic>> exportBackup(int userId) async {
    final db = await database;
    
    final collections = await db.query(
      'user_koleksi',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    
    final kuisProgress = await db.query(
      'progres_kuis',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    
    final narasiProgress = await db.query(
      'progres_narasi',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    final levelsUnlocked = await db.query(
      'level_unlocked',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'user_koleksi': collections,
      'progres_kuis': kuisProgress,
      'progres_narasi': narasiProgress,
      'level_unlocked': levelsUnlocked,
    };
  }

  Future<void> importBackup(int userId, Map<String, dynamic> backupData) async {
    final db = await database;
    
    await db.transaction((txn) async {
      // 1. Clean existing records for this user
      await txn.delete('user_koleksi', where: 'user_id = ?', whereArgs: [userId]);
      await txn.delete('progres_kuis', where: 'user_id = ?', whereArgs: [userId]);
      await txn.delete('progres_narasi', where: 'user_id = ?', whereArgs: [userId]);
      await txn.delete('level_unlocked', where: 'user_id = ?', whereArgs: [userId]);

      // 2. Restore user_koleksi
      if (backupData['user_koleksi'] != null) {
        final List<dynamic> collections = backupData['user_koleksi'];
        for (var item in collections) {
          if (item is Map<String, dynamic>) {
            await txn.insert('user_koleksi', {
              'user_id': userId,
              'kartu_id': item['kartu_id'],
              'unlocked_at': item['unlocked_at'],
            });
          }
        }
      }

      // 3. Restore progres_kuis
      if (backupData['progres_kuis'] != null) {
        final List<dynamic> kuis = backupData['progres_kuis'];
        for (var item in kuis) {
          if (item is Map<String, dynamic>) {
            await txn.insert('progres_kuis', {
              'user_id': userId,
              'level': item['level'],
              'skor': item['skor'],
              'total_soal': item['total_soal'],
              'dikerjakan_pada': item['dikerjakan_pada'],
            });
          }
        }
      }

      // 4. Restore progres_narasi
      if (backupData['progres_narasi'] != null) {
        final List<dynamic> narasi = backupData['progres_narasi'];
        for (var item in narasi) {
          if (item is Map<String, dynamic>) {
            await txn.insert('progres_narasi', {
              'user_id': userId,
              'babak_id': item['babak_id'],
              'sudah_dibaca': item['sudah_dibaca'],
            });
          }
        }
      }

      // 5. Restore level_unlocked
      if (backupData['level_unlocked'] != null) {
        final List<dynamic> levels = backupData['level_unlocked'];
        for (var item in levels) {
          if (item is Map<String, dynamic>) {
            await txn.insert('level_unlocked', {
              'user_id': userId,
              'level': item['level'],
              'skor_terbaik': item['skor_terbaik'],
            });
          }
        }
      }
    });
  }
}
