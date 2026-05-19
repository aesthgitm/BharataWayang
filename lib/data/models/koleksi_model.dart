class UserKoleksi {
  final int userId;
  final int kartuId;
  final String? unlockedAt;

  UserKoleksi({
    required this.userId,
    required this.kartuId,
    this.unlockedAt,
  });

  factory UserKoleksi.fromMap(Map<String, dynamic> map) {
    return UserKoleksi(
      userId: map['user_id'],
      kartuId: map['kartu_id'],
      unlockedAt: map['unlocked_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'kartu_id': kartuId,
      'unlocked_at': unlockedAt,
    };
  }
}
