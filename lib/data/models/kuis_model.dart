class SoalKuis {
  final int? id;
  final int level;
  final String kategori;
  final String pertanyaan;
  final String pilihanA;
  final String pilihanB;
  final String pilihanC;
  final String pilihanD;
  final String jawabanBenar;
  final String? penjelasan;

  SoalKuis({
    this.id,
    required this.level,
    required this.kategori,
    required this.pertanyaan,
    required this.pilihanA,
    required this.pilihanB,
    required this.pilihanC,
    required this.pilihanD,
    required this.jawabanBenar,
    this.penjelasan,
  });

  factory SoalKuis.fromMap(Map<String, dynamic> map) {
    return SoalKuis(
      id: map['id'],
      level: map['level'],
      kategori: map['kategori'],
      pertanyaan: map['pertanyaan'],
      pilihanA: map['pilihan_a'],
      pilihanB: map['pilihan_b'],
      pilihanC: map['pilihan_c'],
      pilihanD: map['pilihan_d'],
      jawabanBenar: map['jawaban_benar'],
      penjelasan: map['penjelasan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'kategori': kategori,
      'pertanyaan': pertanyaan,
      'pilihan_a': pilihanA,
      'pilihan_b': pilihanB,
      'pilihan_c': pilihanC,
      'pilihan_d': pilihanD,
      'jawaban_benar': jawabanBenar,
      'penjelasan': penjelasan,
    };
  }
}
