import '../models/serat_model.dart';
import '../models/progres_narasi_model.dart';
import '../database/database_helper.dart';

class SeratRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Ambil semua babak cerita dari suatu parwa
  Future<List<SeratMahabharata>> getParwa(String parwaName) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'serat_mahabharata',
      where: 'nama_parwa = ?',
      whereArgs: [parwaName],
      orderBy: 'urutan ASC',
    );

    return List.generate(maps.length, (i) {
      return SeratMahabharata.fromMap(maps[i]);
    });
  }

  /// Ambil seluruh progres membaca user
  Future<List<ProgresNarasi>> getProgresMembaca(int userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'progres_narasi',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return ProgresNarasi.fromMap(maps[i]);
    });
  }

  /// Tandai sebuah babak selesai dibaca
  Future<void> markBabakSelesai(int userId, int babakId) async {
    final db = await _dbHelper.database;
    
    // Cek apakah sudah pernah ditandai selesai
    final existing = await db.query(
      'progres_narasi',
      where: 'user_id = ? AND babak_id = ?',
      whereArgs: [userId, babakId],
    );

    if (existing.isEmpty) {
      await db.insert('progres_narasi', {
        'user_id': userId,
        'babak_id': babakId,
        'sudah_dibaca': 1,
      });
    }
  }
}
