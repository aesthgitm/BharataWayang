class User {
  final int? id;
  final String username;
  final String passwordHash;
  final String? namaLengkap;
  final String? createdAt;

  User({this.id, required this.username, required this.passwordHash, this.namaLengkap, this.createdAt});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      passwordHash: map['password_hash'],
      namaLengkap: map['nama_lengkap'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password_hash': passwordHash,
      'nama_lengkap': namaLengkap,
      'created_at': createdAt,
    };
  }
}
