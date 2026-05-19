class MateriKawruh {
  final int? id;
  final String judul;
  final String konten;
  final String? kategori;
  final int? urutan;

  MateriKawruh({
    this.id,
    required this.judul,
    required this.konten,
    this.kategori,
    this.urutan,
  });

  factory MateriKawruh.fromMap(Map<String, dynamic> map) {
    return MateriKawruh(
      id: map['id'],
      judul: map['judul'],
      konten: map['konten'],
      kategori: map['kategori'],
      urutan: map['urutan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'konten': konten,
      'kategori': kategori,
      'urutan': urutan,
    };
  }
}
