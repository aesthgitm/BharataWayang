class ProgresKuis {
  final int? id;
  final int userId;
  final int level;
  final int skor;
  final int totalSoal;
  final String? dikerjakanPada;

  ProgresKuis({
    this.id,
    required this.userId,
    required this.level,
    required this.skor,
    required this.totalSoal,
    this.dikerjakanPada,
  });

  factory ProgresKuis.fromMap(Map<String, dynamic> map) {
    return ProgresKuis(
      id: map['id'],
      userId: map['user_id'],
      level: map['level'],
      skor: map['skor'],
      totalSoal: map['total_soal'],
      dikerjakanPada: map['dikerjakan_pada'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'level': level,
      'skor': skor,
      'total_soal': totalSoal,
      'dikerjakan_pada': dikerjakanPada,
    };
  }
}
