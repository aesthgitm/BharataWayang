import '../models/user_model.dart';
import '../database/database_helper.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<User?> login(String username, String passwordHash) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password_hash = ?',
      whereArgs: [username, passwordHash],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> register(String username, String passwordHash, String namaLengkap) async {
    final db = await _dbHelper.database;
    
    // Check if username exists
    final List<Map<String, dynamic>> existing = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (existing.isNotEmpty) {
      throw Exception('Username sudah digunakan');
    }

    final id = await db.insert('users', {
      'username': username,
      'password_hash': passwordHash,
      'nama_lengkap': namaLengkap,
    });

    return User(
      id: id,
      username: username,
      passwordHash: passwordHash,
      namaLengkap: namaLengkap,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  Future<User?> updateProfile(int userId, String namaLengkap) async {
    final db = await _dbHelper.database;
    await db.update(
      'users',
      {
        'nama_lengkap': namaLengkap,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
