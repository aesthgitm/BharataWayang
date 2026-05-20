import '../models/user_model.dart';
import '../database/database_helper.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<User?> login(String email, String passwordHash) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, passwordHash],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> register(String email, String passwordHash, String namaLengkap) async {
    final db = await _dbHelper.database;
    
    // Check if email already exists
    final List<Map<String, dynamic>> existingEmail = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingEmail.isNotEmpty) {
      throw Exception('Email sudah digunakan');
    }

    // Derive username from email (e.g. arjuna@pandawa.id -> arjuna)
    String username = email.split('@').first;
    final List<Map<String, dynamic>> existingUser = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (existingUser.isNotEmpty) {
      username = '$username${DateTime.now().millisecondsSinceEpoch % 1000}';
    }

    final id = await db.insert('users', {
      'username': username,
      'email': email,
      'password_hash': passwordHash,
      'nama_lengkap': namaLengkap,
    });

    return User(
      id: id,
      username: username,
      email: email,
      passwordHash: passwordHash,
      namaLengkap: namaLengkap,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  Future<User?> updateProfile(int userId, String namaLengkap, String? email, String? bio, String? fotoProfil) async {
    final db = await _dbHelper.database;
    await db.update(
      'users',
      {
        'nama_lengkap': namaLengkap,
        'email': email,
        'bio': bio,
        'foto_profil': fotoProfil,
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
