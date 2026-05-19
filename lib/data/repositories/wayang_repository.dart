import '../models/kartu_wayang_model.dart';
import '../models/koleksi_model.dart';
import '../database/database_helper.dart';

class WayangRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Fetch all Wayang cards
  Future<List<KartuWayang>> getAllKartuWayang() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('kartu_wayang');

    return List.generate(maps.length, (i) {
      return KartuWayang.fromMap(maps[i]);
    });
  }

  /// Get the list of unlocked cards for a specific user
  Future<List<UserKoleksi>> getKoleksiUser(int userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_koleksi',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return UserKoleksi.fromMap(maps[i]);
    });
  }

  /// Unlock a new card for a user
  Future<void> unlockKartu(int userId, int kartuId) async {
    final db = await _dbHelper.database;
    
    // Check if it's already unlocked to prevent duplicate inserts
    final existing = await db.query(
      'user_koleksi',
      where: 'user_id = ? AND kartu_id = ?',
      whereArgs: [userId, kartuId],
    );

    if (existing.isEmpty) {
      await db.insert('user_koleksi', {
        'user_id': userId,
        'kartu_id': kartuId,
        'unlocked_at': DateTime.now().toIso8601String(),
      });
    }
  }
}
