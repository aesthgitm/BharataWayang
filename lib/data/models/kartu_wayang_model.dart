class KartuWayang {
  final int id;
  final String nama;
  final String? afiliasi;
  final String? deskripsi;
  final String? kekuatan;
  final String? pusaka;
  final String? nilaiMoral;
  final String? imageAsset;
  final String? rarity;
  final int? unlockSkorMin;

  KartuWayang({
    required this.id,
    required this.nama,
    this.afiliasi,
    this.deskripsi,
    this.kekuatan,
    this.pusaka,
    this.nilaiMoral,
    this.imageAsset,
    this.rarity,
    this.unlockSkorMin,
  });

  factory KartuWayang.fromMap(Map<String, dynamic> map) {
    return KartuWayang(
      id: map['id'],
      nama: map['nama'],
      afiliasi: map['afiliasi'],
      deskripsi: map['deskripsi'],
      kekuatan: map['kekuatan'],
      pusaka: map['pusaka'],
      nilaiMoral: map['nilai_moral'],
      imageAsset: map['image_asset'],
      rarity: map['rarity'],
      unlockSkorMin: map['unlock_skor_min'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'afiliasi': afiliasi,
      'deskripsi': deskripsi,
      'kekuatan': kekuatan,
      'pusaka': pusaka,
      'nilai_moral': nilaiMoral,
      'image_asset': imageAsset,
      'rarity': rarity,
      'unlock_skor_min': unlockSkorMin,
    };
  }
}
