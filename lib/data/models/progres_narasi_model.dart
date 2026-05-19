class ProgresNarasi {
  final int userId;
  final int babakId;
  final int sudahDibaca;

  ProgresNarasi({
    required this.userId,
    required this.babakId,
    required this.sudahDibaca,
  });

  factory ProgresNarasi.fromMap(Map<String, dynamic> map) {
    return ProgresNarasi(
      userId: map['user_id'],
      babakId: map['babak_id'],
      sudahDibaca: map['sudah_dibaca'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'babak_id': babakId,
      'sudah_dibaca': sudahDibaca,
    };
  }
}
