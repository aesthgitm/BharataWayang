class SeratMahabharata {
  final int? id;
  final String namaParwa;
  final String namaBabak;
  final String isiNarasi;
  final int? parwaId;
  final int? urutan;

  SeratMahabharata({
    this.id,
    required this.namaParwa,
    required this.namaBabak,
    required this.isiNarasi,
    this.parwaId,
    this.urutan,
  });

  factory SeratMahabharata.fromMap(Map<String, dynamic> map) {
    return SeratMahabharata(
      id: map['id'],
      namaParwa: map['nama_parwa'],
      namaBabak: map['nama_babak'],
      isiNarasi: map['isi_narasi'],
      parwaId: map['parwa_id'],
      urutan: map['urutan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_parwa': namaParwa,
      'nama_babak': namaBabak,
      'isi_narasi': isiNarasi,
      'parwa_id': parwaId,
      'urutan': urutan,
    };
  }
}
