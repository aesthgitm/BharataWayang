class FaqMahabharata {
  final int? id;
  final String pertanyaan;
  final String jawaban;
  final int? urutan;

  FaqMahabharata({
    this.id,
    required this.pertanyaan,
    required this.jawaban,
    this.urutan,
  });

  factory FaqMahabharata.fromMap(Map<String, dynamic> map) {
    return FaqMahabharata(
      id: map['id'],
      pertanyaan: map['pertanyaan'],
      jawaban: map['jawaban'],
      urutan: map['urutan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pertanyaan': pertanyaan,
      'jawaban': jawaban,
      'urutan': urutan,
    };
  }
}
