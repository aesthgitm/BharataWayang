import '../models/kuis_model.dart';
import '../models/progres_kuis_model.dart';
import '../database/database_helper.dart';

class KuisRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Ambil 10 soal acak berdasarkan level
  Future<List<SoalKuis>> getSoalByLevel(int level) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'kumpulan_soal',
      where: 'level = ?',
      whereArgs: [level],
      orderBy: 'RANDOM()',
      limit: 10,
    );

    return List.generate(maps.length, (i) {
      return SoalKuis.fromMap(maps[i]);
    });
  }

  /// Ambil skor kuis tertinggi user untuk level tertentu
  Future<int> getSkorTertinggi(int userId, int level) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'progres_kuis',
      where: 'user_id = ? AND level = ?',
      whereArgs: [userId, level],
      orderBy: 'skor DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return maps.first['skor'] as int;
    }
    return 0; // Belum pernah main / skor 0
  }

  /// Ambil semua riwayat progres kuis user
  Future<List<ProgresKuis>> getRiwayatKuisUser(int userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'progres_kuis',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'level ASC',
    );

    return List.generate(maps.length, (i) {
      return ProgresKuis.fromMap(maps[i]);
    });
  }

  /// Simpan skor kuis baru
  Future<void> saveSkorKuis(int userId, int level, int skor, int totalSoal) async {
    final db = await _dbHelper.database;
    
    // Kita insert sebagai log history (bisa banyak percobaan)
    // Jika butuh "overwrite" best score, maka logic update bisa dipakai.
    // Tapi karena tabelnya mencatat histori, kita insert row baru.
    await db.insert('progres_kuis', {
      'user_id': userId,
      'level': level,
      'skor': skor,
      'total_soal': totalSoal,
      'dikerjakan_pada': DateTime.now().toIso8601String(),
    });
  }
}
