import 'package:sqflite/sqflite.dart';

class DatabaseSeeder {
  static Future<void> seedDatabase(Database db) async {
    await _seedKartuWayang(db);
    await _seedKumpulanSoal(db);
    await _seedSeratMahabharata(db);
  }

  static Future<void> _seedKartuWayang(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM kartu_wayang'));
    if (count == 0) {
      final List<Map<String, dynamic>> kartuList = [
        {
          'id': 1,
          'nama': 'Puntadewa (Prabu Yudistira)',
          'afiliasi': 'Pandawa',
          'deskripsi': 'Putra sulung Pandawa, titisan Batara Darma. Dalam pewayangan Jawa ia dikenal sebagai Prabu Puntadewa, raja Amarta yang adil dan jujur. Tidak pernah berdusta dan selalu mengutamakan dharma dalam setiap langkahnya.',
          'image_asset': 'assets/wayang/puntadewa.webp',
          'rarity': 'Langka',
          'kekuatan': 'Kebijaksanaan tertinggi, wahana kereta Jemparing Baruna yang tidak menyentuh tanah selama ia berlaku jujur.',
          'pusaka': 'Tombak Kaladanda (anugerah Batara Darma)',
          'nilai_moral': 'Kejujuran, Keadilan, dan Keteguhan Hati'
        },
        {
          'id': 2,
          'nama': 'Werkudara (Bratasena / Bima)',
          'afiliasi': 'Pandawa',
          'deskripsi': 'Putra kedua Pandawa, titisan Batara Bayu. Dalam pewayangan Jawa, Bima lebih sering disebut Werkudara atau Bratasena. Ia selalu berbicara lurus tanpa basa-basi bahkan kepada dewa sekalipun, lambang ksatria yang tidak mengenal kemunafikan.',
          'image_asset': 'assets/wayang/werkudara.webp',
          'rarity': 'Langka',
          'kekuatan': 'Kekuatan fisik tak tertandingi, Aji Bandung Bandawasa, dan Aji Blabak Pangantol-antol.',
          'pusaka': 'Gada Rujakpala & Kuku Pancanaka',
          'nilai_moral': 'Keberanian, Kesetiaan, dan Integritas tanpa Kompromi'
        },
        {
          'id': 3,
          'nama': 'Janaka (Permadi / Dananjaya / Arjuna)',
          'afiliasi': 'Pandawa',
          'deskripsi': 'Putra ketiga Pandawa, titisan Batara Indra. Dalam pewayangan Jawa ia memiliki banyak nama gelar: Janaka, Permadi, Dananjaya, Palguna. Ksatria paling tampan dan pemanah paling sakti di Tanah Jawa.',
          'image_asset': 'assets/wayang/janaka.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Keahlian memanah tanpa tanding, ilmu Bramastra, dan Aji Panglimunan (menghilang).',
          'pusaka': 'Panah Pasopati (anugerah Batara Guru) & Busur Gandiwa',
          'nilai_moral': 'Dedikasi, Disiplin, dan Kerendahan Hati di Hadapan Ilmu'
        },
        {
          'id': 4,
          'nama': 'Nakula',
          'afiliasi': 'Pandawa',
          'deskripsi': 'Putra keempat Pandawa, anak dari Batara Aswin (kembar dengan Sadewa). Nakula sangat tampan dan dikenal ahli dalam merawat kuda dan ilmu pengobatan. Ia adalah sosok yang setia pada keluarga.',
          'image_asset': 'assets/wayang/nakula.webp',
          'rarity': 'Umum',
          'kekuatan': 'Ahli ilmu pedang dan perawatan kuda. Memiliki pengetahuan luas tentang obat-obatan.',
          'pusaka': 'Pedang Nagasasra',
          'nilai_moral': 'Kesetiaan Keluarga dan Ketelitian'
        },
        {
          'id': 5,
          'nama': 'Sadewa',
          'afiliasi': 'Pandawa',
          'deskripsi': 'Putra kelima Pandawa, saudara kembar Nakula dari Batara Aswin. Sadewa adalah yang paling cerdas di antara Pandawa dalam hal ilmu perbintangan dan ramalan. Ia sangat patuh dan penuh hormat.',
          'image_asset': 'assets/wayang/sadewa.webp',
          'rarity': 'Umum',
          'kekuatan': 'Ilmu astrologi dan ramalan yang sangat akurat. Dapat membaca tanda-tanda alam dan nasib seseorang.',
          'pusaka': 'Keris Saraswati',
          'nilai_moral': 'Kecerdasan, Kepatuhan, dan Rasa Hormat'
        },
        {
          'id': 6,
          'nama': 'Sri Kresna (Prabu Kresna)',
          'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Raja Dwarawati, titisan Batara Wisnu. Dalam pewayangan Jawa, Kresna adalah tokoh terpenting di pihak Pandawa — penasihat, diplomat, dan penggerak strategi perang Bharatayuda. Ia juga menyampaikan Wulang (ajaran) kepada Janaka sebelum perang.',
          'image_asset': 'assets/wayang/sri_kresna.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Kecerdasan taktis, ilmu sastra jendra (ilmu kehidupan), dan wujud Wiswarupa.',
          'pusaka': 'Cakra Sudarsana & Terompet Panchajanya',
          'nilai_moral': 'Kebijaksanaan Sejati, Dharma, dan Pengabdian Tanpa Pamrih'
        },
        {
          'id': 7,
          'nama': 'Gatotkaca',
          'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putra Bima dari Dewi Arimbi, keturunan raksasa yang gagah. Gatotkaca memiliki tubuh raksasa dan bisa terbang. Ia gugur di tangan Karna menggunakan senjata Kunta, namun kematiannya menyelamatkan Arjuna.',
          'image_asset': 'assets/wayang/gatotkaca.webp',
          'rarity': 'Langka',
          'kekuatan': 'Tubuh kebal senjata, mampu terbang, dan kekuatan raksasa yang berlipat ganda di malam hari.',
          'pusaka': 'Anting-anting Keramat (Carub Niskala)',
          'nilai_moral': 'Pengorbanan Jiwa untuk Melindungi yang Dicintai'
        },
        {
          'id': 8,
          'nama': 'Abimanyu',
          'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putra Arjuna dari Subadra. Abimanyu sudah belajar ilmu perang sejak dalam kandungan. Ia gugur secara heroik dalam formasi Cakravyuha pada perang Bharatayudha, dikeroyok banyak ksatria Kurawa.',
          'image_asset': 'assets/wayang/abimanyu.webp',
          'rarity': 'Langka',
          'kekuatan': 'Kemability menembus formasi Cakravyuha yang tidak bisa dilakukan ksatria lain. Keberanian yang melampaui usianya.',
          'pusaka': 'Busur Warisan Arjuna',
          'nilai_moral': 'Kepahlawanan Sejati dan Pantang Menyerah Meski Sendirian'
        },
        {
          'id': 9,
          'nama': 'Suyudhana (Prabu Duryudana)',
          'afiliasi': 'Kurawa',
          'deskripsi': 'Putra sulung Drestarastra, Raja Ngastina yang menjadi pemimpin Kurawa. Dalam pewayangan Jawa namanya yang benar adalah Suyudhana (bukan Duryodhana). Ia menolak membagi kerajaan dengan Pandawa dan menjadi tokoh utama pemicu perang Bharatayuda.',
          'image_asset': 'assets/wayang/suyudhana.webp',
          'rarity': 'Langka',
          'kekuatan': 'Ilmu gada Kalimasada dan tubuh kebal senjata berkat pandangan Dewi Gendari, kecuali bagian paha.',
          'pusaka': 'Gada Kyai Kalimasada',
          'nilai_moral': '(Pelajaran negatif) Bahaya Iri Hati dan Kesombongan yang Menghancurkan Diri Sendiri'
        },
        {
          'id': 10,
          'nama': 'Adipati Karna',
          'afiliasi': 'Kurawa',
          'deskripsi': 'Dalam pewayangan Jawa disebut Adipati Karna atau Basukarna. Ia adalah putra pertama Dewi Kunti yang dirahasiakan. Dibesarkan oleh kusir kereta di Kerajaan Awangga. Memihak Kurawa karena kesetiaan murni pada Suyudhana yang memberinya kehormatan.',
          'image_asset': 'assets/wayang/adipati_karna.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Pemanah setara Janaka, memiliki anugerah Kavacha-Kundala (baju zirah & anting sakti) sejak lahir.',
          'pusaka': 'Panah Kunta & Kavacha-Kundala',
          'nilai_moral': 'Kesetiaan pada Sahabat dan Tragedi Takdir yang Tidak Adil'
        },
        {
          'id': 11,
          'nama': 'Sakuni',
          'afiliasi': 'Kurawa',
          'deskripsi': 'Paman Duryudhana dari kerajaan Gandhara. Sakuni adalah otak di balik berbagai tipu muslihat yang menimpa Pandawa, termasuk permainan dadu yang menyebabkan Pandawa diasingkan 12 tahun.',
          'image_asset': 'assets/wayang/sakuni.webp',
          'rarity': 'Umum',
          'kekuatan': 'Kecerdasan licik dan kemampuan memanipulasi situasi. Ahli dalam permainan dadu menggunakan dadu bertuah yang terbuat dari tulang ayahnya.',
          'pusaka': 'Dadu Tulang Keramat',
          'nilai_moral': '(Pelajaran negatif) Kecerdasan yang Dipakai untuk Kejahatan Hanya Membawa Kehancuran'
        },
        {
          'id': 12,
          'nama': 'Resi Bisma (Dewabrata)',
          'afiliasi': 'Pihak Ngastina (Netral)',
          'deskripsi': 'Putra Prabu Sentanu dan Dewi Gangga, nama aslinya Dewabrata. Dalam pewayangan Jawa, Resi Bisma adalah tokoh paling dihormati — sesepuh kerajaan Ngastina yang bersumpah tidak akan menikah. Anugerahnya: menentukan waktu kematiannya sendiri.',
          'image_asset': 'assets/wayang/resi_bisma.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Ilmu perang tertinggi, Aji Swiwikrama (membesarkan diri), anugerah Iccha Mrityu.',
          'pusaka': 'Busur Brahmanda',
          'nilai_moral': 'Pengorbanan Pribadi demi Sumpah yang Lebih Besar dari Diri Sendiri'
        },
        {
          'id': 13,
          'nama': 'Resi Drona (Sokalima)',
          'afiliasi': 'Pihak Ngastina',
          'deskripsi': 'Guru besar ilmu perang bagi semua pangeran Kuru. Dalam pewayangan Jawa, Drona tinggal di pertapaan Sokalima. Ia mengajarkan ilmu Bramastra kepada Janaka namun juga memihak Kurawa saat perang Bharatayuda.',
          'image_asset': 'assets/wayang/resi_drona.webp',
          'rarity': 'Langka',
          'kekuatan': 'Penguasaan semua ilmu senjata dan Bramastra yang mematikan.',
          'pusaka': 'Senjata Bramastra',
          'nilai_moral': 'Dedikasi pada Ilmu, namun juga Peringatan tentang Keberpihakan yang Tidak Adil'
        },
        {
          'id': 14,
          'nama': 'Dewi Wara Drupadi',
          'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putri Raja Drupada yang lahir dari api suci, menjadi istri kelima Pandawa (Dalam versi Jawa hanya istri Yudistira). Penghinaan yang diterimanya di muka umum oleh Dursasana menjadi pemicu utama perang Bharatayuda.',
          'image_asset': 'assets/wayang/dewi_drupadi.webp',
          'rarity': 'Langka',
          'kekuatan': 'Keteguhan batin dan dilindungi secara gaib oleh Sri Kresna — kain yang ditariknya tidak akan pernah habis.',
          'pusaka': 'Perlindungan Suci Sri Kresna',
          'nilai_moral': 'Martabat Diri, Keberanian Wanita, dan Keadilan yang Harus Diperjuangkan'
        },
        {
          'id': 15,
          'nama': 'Dewi Srikandi',
          'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putri Raja Drupada, saudara Dewi Drupadi. Dalam pewayangan Jawa, Srikandi adalah murid Janaka (Arjuna) dalam ilmu memanah dan kemudian menjadi istrinya. Ia menjadi kunci penghancur Resi Bisma dalam perang Bharatayuda.',
          'image_asset': 'assets/wayang/dewi_srikandi.webp',
          'rarity': 'Langka',
          'kekuatan': 'Keahlian memanah setara ksatria, murid terbaik Janaka.',
          'pusaka': 'Panah Ardhadedali',
          'nilai_moral': 'Keberanian Menembus Batas dan Tidak Menyerah pada Ketidakadilan'
        },
        {
          'id': 16,
          'nama': 'Batara Guru (Dewa Siwa)',
          'afiliasi': 'Dewa',
          'deskripsi': 'Penguasa tertinggi Kahyangan dalam kosmologi pewayangan Jawa. Batara Guru adalah wujud Siwa yang paling dihormati. Ia pemberi anugerah kepada ksatria pilihan, termasuk memberikan senjata Pasopati kepada Janaka.',
          'image_asset': 'assets/wayang/batara_guru.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Penguasaan semesta, sumber segala senjata sakti dan anugerah.',
          'pusaka': 'Trisula Suci',
          'nilai_moral': 'Kebijaksanaan Agung dan Keseimbangan Alam'
        },
        {
          'id': 17,
          'nama': 'Batara Indra',
          'afiliasi': 'Dewa',
          'deskripsi': 'Raja para dewa di Kahyangan, ayah kandung Janaka (Arjuna). Dalam pewayangan Jawa, Batara Indra sering turun membantu para ksatria pilihan dan mengajari Janaka ilmu perang di Kahyangan.',
          'image_asset': 'assets/wayang/batara_indra.webp',
          'rarity': 'Langka',
          'kekuatan': 'Penguasa petir dan hujan, memiliki pasukan Kahyangan.',
          'pusaka': 'Bajra (Senjata Halilintar)',
          'nilai_moral': 'Keberanian dan Perlindungan kepada yang Lemah'
        },
        {
          'id': 18,
          'nama': 'Semar (Batara Ismaya)',
          'afiliasi': 'Punakawan',
          'deskripsi': 'Sosok paling agung dalam pewayangan Jawa. Semar sejatinya adalah Batara Ismaya, dewa yang rela turun ke bumi menjadi abdi para ksatria Pandawa. Wujudnya jelek namun kebijaksanaannya melampaui para dewa.',
          'image_asset': 'assets/wayang/semar.webp',
          'rarity': 'Legendaris',
          'kekuatan': 'Kebijaksanaan tak terbatas, kekuatan gaib tersembunyi.',
          'pusaka': 'Kentut Semar (senjata pamungkas yang tak tertandingi)',
          'nilai_moral': 'Kerendahan Hati Sejati — yang Mulia tidak perlu terlihat mulia'
        },
        {
          'id': 19,
          'nama': 'Nala Gareng',
          'afiliasi': 'Punakawan',
          'deskripsi': 'Putra angkat pertama Semar. Gareng cacat fisik yang melambangkan manusia penuh kekurangan namun tetap bersemangat. Dalam banyak lakon ia menjadi penghibur sekaligus penyampai pesan moral.',
          'image_asset': 'assets/wayang/gareng.webp',
          'rarity': 'Umum',
          'kekuatan': 'Ketangkasan dan kecerdikan meski penuh keterbatasan fisik.',
          'pusaka': 'Cengkeraman Tangan Ciker',
          'nilai_moral': 'Jangan Merasa Rendah Diri karena Kekurangan Fisik'
        },
        {
          'id': 20,
          'nama': 'Petruk (Kanthong Bolong)',
          'afiliasi': 'Punakawan',
          'deskripsi': 'Putra angkat kedua Semar, dikenal dengan hidung panjang dan tubuh jangkung. Petruk adalah Punakawan paling humoris dan cerdas. Dalam lakon "Petruk dadi Ratu," ia bahkan berhasil merebut kerajaan sementara.',
          'image_asset': 'assets/wayang/petruk.webp',
          'rarity': 'Umum',
          'kekuatan': 'Kecerdikan, kelincahan, dan kemampuan bersilat lidah.',
          'pusaka': 'Gada Kanthong Bolong',
          'nilai_moral': 'Kecerdasan Rakyat Jelata Bisa Mengalahkan Kesombongan Bangsawan'
        }
      ];

      for (var k in kartuList) {
        await db.insert('kartu_wayang', k);
      }
    }
  }

  static Future<void> _seedKumpulanSoal(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM kumpulan_soal'));
    if (count == 0) {
      final List<Map<String, dynamic>> soalList = [
        // LEVEL 1
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang berasal dari kata "Ma Hyang" yang berarti...', 'pilihan_a': 'Bergerak mengikuti angin', 'pilihan_b': 'Menuju kepada yang Maha Tinggi (Tuhan)', 'pilihan_c': 'Bayangan manusia purba', 'pilihan_d': 'Pertunjukan raja-raja Jawa', 'jawaban_benar': 'B', 'penjelasan': 'Kata "Wayang" berasal dari bahasa Jawa Kuno "Ma Hyang" yang artinya menuju kepada roh leluhur atau yang Maha Tinggi.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang diakui sebagai Warisan Budaya Takbenda oleh UNESCO pada tahun...', 'pilihan_a': '2003', 'pilihan_b': '2001', 'pilihan_c': '1998', 'pilihan_d': '2005', 'jawaban_benar': 'A', 'penjelasan': 'UNESCO mengakui Wayang Indonesia sebagai Masterpiece of the Oral and Intangible Heritage of Humanity pada tanggal 7 November 2003.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Layar putih yang digunakan sebagai media pertunjukan wayang kulit disebut...', 'pilihan_a': 'Blencong', 'pilihan_b': 'Gedebog', 'pilihan_c': 'Gunungan', 'pilihan_d': 'Kelir', 'jawaban_benar': 'D', 'penjelasan': 'Kelir adalah layar putih yang menjadi tempat bayangan wayang diproyeksikan selama pertunjukan berlangsung.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Lampu yang digunakan untuk menerangi pertunjukan wayang kulit tradisional disebut...', 'pilihan_a': 'Blencong', 'pilihan_b': 'Senthir', 'pilihan_c': 'Kelir', 'pilihan_d': 'Debog', 'jawaban_benar': 'A', 'penjelasan': 'Blencong adalah lampu minyak tradisional yang digunakan untuk menerangi kelir dan menciptakan efek bayangan wayang.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang yang terbuat dari kulit kerbau dan dimainkan dengan bayangan adalah...', 'pilihan_a': 'Wayang Golek', 'pilihan_b': 'Wayang Kulit', 'pilihan_c': 'Wayang Orang', 'pilihan_d': 'Wayang Klitik', 'jawaban_benar': 'B', 'penjelasan': 'Wayang Kulit adalah jenis wayang yang paling terkenal, terbuat dari kulit kerbau yang dipahat halus dan dimainkan di balik layar dengan bayangan.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang yang berbentuk tiga dimensi (3D) dan terbuat dari kayu adalah...', 'pilihan_a': 'Wayang Kulit', 'pilihan_b': 'Wayang Beber', 'pilihan_c': 'Wayang Golek', 'pilihan_d': 'Wayang Klitik', 'jawaban_benar': 'C', 'penjelasan': 'Wayang Golek adalah boneka kayu tiga dimensi yang biasanya digunakan di pertunjukan Sunda (Jawa Barat), tanpa menggunakan layar bayangan.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Pemimpin pertunjukan wayang yang mengendalikan semua boneka dan bercerita disebut...', 'pilihan_a': 'Sinden', 'pilihan_b': 'Niyaga', 'pilihan_c': 'Wiraswara', 'pilihan_d': 'Dalang', 'jawaban_benar': 'D', 'penjelasan': 'Dalang adalah seniman utama pertunjukan wayang yang mengendalikan semua boneka, membacakan dialog, dan menceritakan lakon (kisah).'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Tokoh wayang yang digambarkan berbentuk gunung/kipas dan merupakan simbol keseimbangan dunia disebut...', 'pilihan_a': 'Kresna', 'pilihan_b': 'Gunungan (Kayon)', 'pilihan_c': 'Semar', 'pilihan_d': 'Togog', 'jawaban_benar': 'B', 'penjelasan': 'Gunungan atau Kayon adalah wayang berbentuk gunung yang digunakan sebagai pembuka/penutup pertunjukan dan melambangkan keseimbangan alam semesta.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Boneka wayang ditancapkan pada batang pohon pisang yang disebut...', 'pilihan_a': 'Kelir', 'pilihan_b': 'Blencong', 'pilihan_c': 'Gedebog', 'pilihan_d': 'Kothak', 'jawaban_benar': 'C', 'penjelasan': 'Gedebog adalah batang pohon pisang yang digunakan sebagai tempat menancapkan gagang wayang selama pertunjukan berlangsung.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Lakon (kisah) terbesar yang sering dimainkan dalam pertunjukan wayang adalah...', 'pilihan_a': 'Ramayana dan Mahabharata', 'pilihan_b': 'Serat Centhini dan Babad Tanah Jawi', 'pilihan_c': 'Panji dan Menak', 'pilihan_d': 'Sri dan Sadana', 'jawaban_benar': 'A', 'penjelasan': 'Ramayana dan Mahabharata adalah dua epos terbesar asal India yang paling sering diadaptasi dalam pertunjukan wayang kulit Jawa.'},

        // LEVEL 2
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Siapakah tokoh yang mendirikan kota Hastinapura sebagai pusat pemerintahan?', 'pilihan_a': 'Sang Hasti', 'pilihan_b': 'Sang Kuru', 'pilihan_c': 'Sang Bharata', 'pilihan_d': 'Pratipa', 'jawaban_benar': 'A', 'penjelasan': 'Sang Hasti adalah keturunan Sang Bharata yang mendirikan kota Hastinapura.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Dewabrata berganti nama menjadi Bisma karena melakukan sumpah yang disebut "Bhishan Pratigya." Isi sumpah tersebut adalah...', 'pilihan_a': 'Tidak akan pernah berperang melawan Pandawa', 'pilihan_b': 'Membujang selamanya dan tidak mewarisi takhta ayahnya', 'pilihan_c': 'Selalu melindungi kerajaan Hastinapura sampai mati', 'pilihan_d': 'Tidak akan pernah menyerang dari belakang', 'jawaban_benar': 'B', 'penjelasan': 'Dewabrata bersumpah membujang seumur hidup dan tidak mewarisi takhta.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Mengapa Drestarastra terlahir dalam keadaan buta?', 'pilihan_a': 'Dikutuk oleh Resi Byasa sebelum lahir', 'pilihan_b': 'Ayahnya memiliki penyakit bawaan', 'pilihan_c': 'Ibunya (Ambika) menutup mata selama upacara dengan Resi Byasa berlangsung', 'pilihan_d': 'Lahir prematur', 'jawaban_benar': 'C', 'penjelasan': 'Ambika terkejut dengan wajah sakti Resi Byasa lalu menutup mata, sehingga anaknya (Drestarastra) lahir buta.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Mengapa Pandu terlahir berwarna pucat?', 'pilihan_a': 'Lahir prematur', 'pilihan_b': 'Kutukan dewa', 'pilihan_c': 'Keturunan penyakit', 'pilihan_d': 'Ibunya (Ambalika) menjadi sangat pucat ketakutan saat melihat Resi Byasa', 'jawaban_benar': 'D', 'penjelasan': 'Ambalika membuka mata namun sangat ketakutan dan pucat, sehingga Pandu terlahir pucat.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Widura adalah putra Resi Byasa dari siapa, dan mengapa ia lahir dengan kaki pincang?', 'pilihan_a': 'Dari dayang Datri, lahir pincang karena Datri berlari keluar saat upacara', 'pilihan_b': 'Dari Ambika, kena kutukan', 'pilihan_c': 'Dari Ambalika', 'pilihan_d': 'Dari Satyawati', 'jawaban_benar': 'A', 'penjelasan': 'Datri ketakutan dan berlari keluar kamar hingga terjatuh, sehingga Widura lahir pincang.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Pandu mendapat kutukan tidak bisa punya anak karena memanah seekor kijang yang ternyata adalah...', 'pilihan_a': 'Dewa pelindung hutan', 'pilihan_b': 'Utusan Batara Guru', 'pilihan_c': 'Seorang pendeta sakti yang sedang kasmaran', 'pilihan_d': 'Raja iblis', 'jawaban_benar': 'C', 'penjelasan': 'Kijang tersebut adalah pendeta yang menjelma. Sang pendeta mengutuk Pandu sebelum mati.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Siapa yang memberikan mantra kepada Dewi Kunti agar bisa memanggil dewa?', 'pilihan_a': 'Resi Byasa', 'pilihan_b': 'Resi Druwasa', 'pilihan_c': 'Batara Guru', 'pilihan_d': 'Prabu Santanu', 'jawaban_benar': 'B', 'penjelasan': 'Resi Druwasa memberikan mantra sakti kepada Kunti karena pelayanannya yang baik.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Karna adalah anak pertama Dewi Kunti dari Batara Surya. Apa yang terjadi kepadanya?', 'pilihan_a': 'Dibesarkan Kunti diam-diam', 'pilihan_b': 'Dikirim ke pertapaan', 'pilihan_c': 'Tinggal bersama Pandawa', 'pilihan_d': 'Dilarung ke sungai dan dirawat oleh kusir di Awangga', 'jawaban_benar': 'D', 'penjelasan': 'Kunti membuang Karna ke sungai, lalu ia dirawat oleh Adirata si kusir.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Pasangan dewa mana yang membuahi Dewi Madrim sehingga lahir Nakula dan Sadewa?', 'pilihan_a': 'Batara Aswan dan Batara Aswin', 'pilihan_b': 'Bayu dan Indra', 'pilihan_c': 'Surya dan Darma', 'pilihan_d': 'Wisnu dan Siwa', 'jawaban_benar': 'A', 'penjelasan': 'Dewa kembar Aswan dan Aswin memberikan anugerah anak kembar, Nakula dan Sadewa.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Drestarastra menikah dengan Dewi Gendari dan memiliki berapa anak?', 'pilihan_a': '50 putra, 2 putri', 'pilihan_b': '100 putra, 0 putri', 'pilihan_c': '99 putra, 1 putri', 'pilihan_d': '99 putra, 2 putri', 'jawaban_benar': 'C', 'penjelasan': 'Mereka memiliki 99 orang putra dan 1 putri yang dikenal sebagai Kurawa.'},

        // LEVEL 3
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Lakon apa yang menceritakan rencana Kurawa membakar rumah Pandawa?', 'pilihan_a': 'Baratayuda', 'pilihan_b': 'Bale Sigala-gala', 'pilihan_c': 'Pandawa Seda', 'pilihan_d': 'Dewa Ruci', 'jawaban_benar': 'B', 'penjelasan': 'Peristiwa pembakaran rumah Pandawa (Bale Sigala-gala). Pandawa selamat karena bantuan Widura.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Siapa yang memberitahu Pandawa tentang rencana pembakaran tersebut?', 'pilihan_a': 'Sri Kresna', 'pilihan_b': 'Resi Bisma', 'pilihan_c': 'Widura', 'pilihan_d': 'Sengkuni', 'jawaban_benar': 'C', 'penjelasan': 'Widura yang merupakan paman Pandawa memberitahu mereka tentang rencana jahat tersebut.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Dalam pedalangan Jawa, ayah raksasa Arimba bernama...', 'pilihan_a': 'Trembaka (Arimbaka)', 'pilihan_b': 'Hidimba', 'pilihan_c': 'Pracona', 'pilihan_d': 'Yaksadewa', 'jawaban_benar': 'A', 'penjelasan': 'Dalam versi Jawa, ayahnya adalah Trembaka. Adik Arimba yaitu Arimbi kemudian menikahi Bima.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Dalam versi pedalangan Jawa, Dewi Drupadi adalah istri dari...', 'pilihan_a': 'Kelima Pandawa', 'pilihan_b': 'Janaka (Arjuna)', 'pilihan_c': 'Werkudara (Bima)', 'pilihan_d': 'Puntadewa (Yudistira) seorang', 'jawaban_benar': 'D', 'penjelasan': 'Berbeda dengan versi India di mana ia bersuami lima, dalam wayang Jawa ia hanya istri Yudistira.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Ibukota kerajaan Pandawa adalah...', 'pilihan_a': 'Indraprastha', 'pilihan_b': 'Hastinapura', 'pilihan_c': 'Pancala', 'pilihan_d': 'Dwarawati', 'jawaban_benar': 'A', 'penjelasan': 'Pandawa membangun Indraprastha di tanah Kurujanggala yang tadinya merupakan hutan gersang.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Apa yang membuat Duryudana sangat membenci Pandawa saat mengunjungi Indraprastha?', 'pilihan_a': 'Melihat kekayaan mereka', 'pilihan_b': 'Dihina Kresna', 'pilihan_c': 'Ia tercebur kolam yang dikira lantai, lalu ditertawakan Drupadi', 'pilihan_d': 'Tidak diberi jamuan', 'jawaban_benar': 'C', 'penjelasan': 'Duryudana tertipu oleh lantai kristal dan tercebur ke air, menjadi bahan ejekan.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Siapa "bandar dadu" Kurawa yang curang menjebak Pandawa?', 'pilihan_a': 'Dursasana', 'pilihan_b': 'Karna', 'pilihan_c': 'Drona', 'pilihan_d': 'Arya Sengkuni', 'jawaban_benar': 'D', 'penjelasan': 'Arya Sengkuni adalah otak kelicikan yang menggunakan dadu bertuah untuk mengalahkan Yudistira.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Mengapa Sri Kresna membantu agar kain Drupadi tidak habis saat ditarik?', 'pilihan_a': 'Kresna kakaknya', 'pilihan_b': 'Drupadi pernah membalut luka jari Kresna', 'pilihan_c': 'Anugerah dewa', 'pilihan_d': 'Sihir dari cincin', 'jawaban_benar': 'B', 'penjelasan': 'Drupadi membalut jari Kresna yang terluka saat upacara Rajasuya, dibalas dengan perlindungan kain tak terbatas.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Sumpah Drupadi setelah dipermalukan Dursasana adalah...', 'pilihan_a': 'Tidak menggelung rambut sebelum dikeramas dengan darah Dursasana', 'pilihan_b': 'Membunuh Duryudana', 'pilihan_c': 'Meninggalkan Pandawa', 'pilihan_d': 'Mengutuk Hastina', 'jawaban_benar': 'A', 'penjelasan': 'Drupadi bersumpah tidak akan merapikan rambutnya hingga dibasuh darah Dursasana.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Berapa lama total hukuman pengasingan Pandawa setelah kalah dadu?', 'pilihan_a': '10 tahun + 2 tahun menyamar', 'pilihan_b': 'Ibunya menyamar', 'pilihan_c': '12 tahun di hutan + 1 tahun menyamar', 'pilihan_d': '14 tahun penuh', 'jawaban_benar': 'C', 'penjelasan': 'Mereka dihukum buang selama 12 tahun di hutan dan 1 tahun masa penyamaran (incognito).'},

        // LEVEL 4
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Berapa hari perang Bharatayuda berlangsung?', 'pilihan_a': '10 hari', 'pilihan_b': '14 hari', 'pilihan_c': '18 hari', 'pilihan_d': '21 hari', 'jawaban_benar': 'C', 'penjelasan': 'Perang suci ini berlangsung selama 18 hari penuh di Kurusetra.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa panglima Kurawa pada hari 1-10?', 'pilihan_a': 'Resi Bisma', 'pilihan_b': 'Resi Drona', 'pilihan_c': 'Adipati Karna', 'pilihan_d': 'Salya', 'jawaban_benar': 'A', 'penjelasan': 'Resi Bisma menjadi senapati pertama dan tak terkalahkan hingga hari ke-10.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Mengapa Arjuna menggunakan Srikandi sebagai tameng melawan Bisma?', 'pilihan_a': 'Srikandi kebal senjata', 'pilihan_b': 'Bisma bersumpah tidak akan menyerang perempuan', 'pilihan_c': 'Srikandi adik Arjuna', 'pilihan_d': 'Perintah dewa', 'jawaban_benar': 'B', 'penjelasan': 'Bisma tidak menyerang Srikandi karena sumpah ksatria-nya, sehingga Arjuna bisa menyerang dari balik Srikandi.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Formasi melingkar yang menjebak Abimanyu disebut...', 'pilihan_a': 'Garuda Byuha', 'pilihan_b': 'Makara Byuha', 'pilihan_c': 'Padma', 'pilihan_d': 'Cakravyuha', 'jawaban_benar': 'D', 'penjelasan': 'Cakravyuha adalah formasi buatan Drona. Abimanyu tahu cara masuk namun tak tahu cara keluar.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Bagaimana cara Pandawa mengalahkan Resi Drona?', 'pilihan_a': 'Bramastra', 'pilihan_b': 'Bantuan Semar', 'pilihan_c': 'Dekeroyok Bima dan Arjuna', 'pilihan_d': 'Menyebarkan kabar bohong bahwa putranya (Aswatama) mati', 'jawaban_benar': 'D', 'penjelasan': 'Kabar bohong gugurnya Aswatama membuat Drona kehilangan semangat bertarung dan menundukkan senjata.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa panglima Kurawa pada hari ke-16?', 'pilihan_a': 'Aswatama', 'pilihan_b': 'Adipati Karna', 'pilihan_c': 'Sengkuni', 'pilihan_d': 'Salya', 'jawaban_benar': 'B', 'penjelasan': 'Adipati Karna menggantikan Drona sebagai panglima tertinggi.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Mengapa Karna kesulitan melawan Arjuna di akhir?', 'pilihan_a': 'Roda keretanya terperosok ke lumpur', 'pilihan_b': 'Kehabisan panah', 'pilihan_c': 'Zirahnya hilang', 'pilihan_d': 'Terkena sihir Kresna', 'jawaban_benar': 'A', 'penjelasan': 'Karena kutukan, roda kereta Karna amblas ke tanah dan ia lupa mantra senjatanya.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa yang gugur di dalam formasi Cakravyuha?', 'pilihan_a': 'Gatotkaca', 'pilihan_b': 'Irawan', 'pilihan_c': 'Abimanyu', 'pilihan_d': 'Utara', 'jawaban_benar': 'C', 'penjelasan': 'Abimanyu gugur setelah dikeroyok oleh ksatria utama Kurawa dalam Cakravyuha.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Bagaimana Bima mengalahkan Duryudana?', 'pilihan_a': 'Panah Pasopati', 'pilihan_b': 'Kuku Pancanaka', 'pilihan_c': 'Memukul pahanya dengan gada', 'pilihan_d': 'Mencekiknya', 'jawaban_benar': 'C', 'penjelasan': 'Paha Duryudana adalah satu-satunya bagian tubuhnya yang tidak kebal senjata.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Pasukan sekutu Pandawa yang gugur di awal perang adalah...', 'pilihan_a': 'Prabu Matswapati dan putra-putranya', 'pilihan_b': 'Prabu Drupada', 'pilihan_c': 'Punakawan', 'pilihan_d': 'Kresna', 'jawaban_benar': 'A', 'penjelasan': 'Raja Wirata (Matswapati) kehilangan putra-putranya seperti Utara, Seta, dan Wratsangka.'},

        // LEVEL 5
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Kisah Pandawa yang sabar menghadapi Kurawa mengajarkan bahwa...', 'pilihan_a': 'Orang lemah pasti kalah', 'pilihan_b': 'Kesabaran sejati adalah menunggu waktu yang tepat untuk menegakkan kebenaran', 'pilihan_c': 'Kekerasan adalah satu-satunya solusi', 'pilihan_d': 'Diam itu emas', 'jawaban_benar': 'B', 'penjelasan': 'Kesabaran Pandawa adalah kekuatan untuk bertahan hingga saatnya menegakkan Dharma.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Karna memihak Kurawa meski tahu Pandawa benar. Ini mengajarkan tragedi...', 'pilihan_a': 'Kesetiaan pada kawan yang salah bisa berujung pada kebinasaan mulia', 'pilihan_b': 'Kekuatan adalah segalanya', 'pilihan_c': 'Jangan percaya keluarga', 'pilihan_d': 'Orang baik selalu menang', 'jawaban_benar': 'A', 'penjelasan': 'Karna setia pada Duryudana yang menolongnya saat dibuang, meski ia tahu berada di pihak yang salah.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Kisah Sengkuni mengajarkan bahwa...', 'pilihan_a': 'Kecerdasan selalu membawa sukses', 'pilihan_b': 'Politik itu kotor', 'pilihan_c': 'Paman adalah pembimbing terbaik', 'pilihan_d': 'Kecerdasan yang digunakan untuk licik hanya membawa kehancuran', 'jawaban_benar': 'D', 'penjelasan': 'Semua kelicikan Sengkuni akhirnya menghancurkan keluarga Kurawa dan dirinya sendiri.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Pelajaran dari tokoh Semar adalah...', 'pilihan_a': 'Kekuatan fisik itu penting', 'pilihan_b': 'Pengabdian untuk raja', 'pilihan_c': 'Kerendahan hati sejati, yang mulia tidak perlu terlihat mulia', 'pilihan_d': 'Lucu itu penting', 'jawaban_benar': 'C', 'penjelasan': 'Semar adalah dewa agung namun berwujud abdi yang jelek, melambangkan kerendahan hati mutlak.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Sumpah Bisma mengajarkan...', 'pilihan_a': 'Pengorbanan pribadi demi janji yang lebih besar', 'pilihan_b': 'Jangan pernah berjanji', 'pilihan_c': 'Kesetiaan buta', 'pilihan_d': 'Kekuatan membujang', 'jawaban_benar': 'A', 'penjelasan': 'Bisma rela berkorban segalanya demi kebahagiaan ayahnya dan kesejahteraan Hastinapura.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Setelah perang, Yudistira dinobatkan menjadi raja bergelar...', 'pilihan_a': 'Prabu Dharmaputra', 'pilihan_b': 'Prabu Puntadewa Agung', 'pilihan_c': 'Prabu Bharata', 'pilihan_d': 'Prabu Kalimataya', 'jawaban_benar': 'D', 'penjelasan': 'Ia bergelar Prabu Kalimataya (atau Prabu Dharmaputra/Yudistira di Hastina).'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Lakon "Pandawa Seda" menceritakan akhir kisah Pandawa yang...', 'pilihan_a': 'Bertapa di Indraprastha', 'pilihan_b': 'Pindah ke Dwarawati', 'pilihan_c': 'Mendaki Gunung Himalaya menuju surga', 'pilihan_d': 'Mengasingkan diri', 'jawaban_benar': 'C', 'penjelasan': 'Pandawa menyerahkan takhta lalu mendaki Himalaya hingga satu per satu wafat.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Secara utuh, Bharatayuda mengajarkan bahwa...', 'pilihan_a': 'Perang menyelesaikan masalah', 'pilihan_b': 'Yang kuat selalu menang', 'pilihan_c': 'Keadilan datang sendiri', 'pilihan_d': 'Kemenangan sejati dibayar mahal dan perang selalu membawa kehancuran', 'jawaban_benar': 'D', 'penjelasan': 'Pandawa menang namun kehilangan seluruh putra dan kerabat mereka.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Pengorbanan Gatotkaca mengajarkan...', 'pilihan_a': 'Pengorbanan jiwa demi melindungi orang yang dicintai adalah kemuliaan ksatria', 'pilihan_b': 'Kepatuhan mutlak', 'pilihan_c': 'Kesaktian itu percuma', 'pilihan_d': 'Tragedi kematian', 'jawaban_benar': 'A', 'penjelasan': 'Gatotkaca mengorbankan dirinya agar Arjuna selamat dari panah Kunta milik Karna.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Siapa yang mewarisi takhta Hastinapura dari Yudistira?', 'pilihan_a': 'Abimanyu', 'pilihan_b': 'Parikesit (cucu Arjuna)', 'pilihan_c': 'Janamejaya', 'pilihan_d': 'Gatotkaca', 'jawaban_benar': 'B', 'penjelasan': 'Parikesit, cucu Arjuna dari Abimanyu, adalah satu-satunya pewaris Dinasti Kuru yang tersisa.'},
      ];

      for (var s in soalList) {
        await db.insert('kumpulan_soal', s);
      }
    }
  }

  static Future<void> _seedSeratMahabharata(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM serat_mahabharata'));
    if (count == 0) {
      final List<Map<String, dynamic>> seratList = [
        {
          'nama_parwa': 'Adiparwa',
          'nama_babak': 'Lahirnya Pandawa dan Kurawa',
          'isi_narasi': 'Dikisahkan pada zaman dahulu kala, dunia masih diselimuti misteri dan keheningan. Kisah Mahabharata diawali dengan pertemuan Raja Duswanta dengan Sakuntala. Raja Duswanta adalah seorang raja besar dari Chandrawangsa keturunan Yayati, menikahi Sakuntala dari pertapaan Bagawan Kanwa, kemudian menurunkan Sang Bharata. Sang Bharata menurunkan Sang Hasti, yang kemudian mendirikan sebuah pusat pemerintahan bernama Hastinapura. Sang Hasti menurunkan Para Raja Hastinapura. Dari keluarga tersebut, lahirlah Sang Kuru, yang menguasai dan menyucikan sebuah daerah luas yang disebut Kurukshetra. Sang Kuru menurunkan Dinasti Kuru atau Wangsa Kaurawa. Dalam Dinasti tersebut, lahirlah Pratipa, yang menjadi ayah Prabu Santanu, leluhur Pandawa dan Kurawa.\n\n'
              'Prabu Santanu seorang raja mahsyur dari garis keturunan Sang Kuru, berasal dari Hastinapura. Ia menikah dengan Dewi Gangga yang dikutuk agar turun ke dunia, namun Dewi Gangga meninggalkannya karena Sang Prabu melanggar janji pernikahan. Hubungan Sang Prabu dengan Dewi Gangga sempat membuahkan 7 anak, akan tetapi semua ditenggelamkan ke laut Gangga oleh Dewi Gangga dengan alasan semua sudah terkena kutukan. Akan tetapi kemudian anak ke 8 bisa diselamatkan oleh Prabu Santanu yang diberi nama Dewabrata. Kemudian Dewi Ganggapun pergi meninggalkan Prabu Santanu. Nama Dewabrata diganti menjadi Bisma karena ia melakukan bhishan pratigya yaitu sumpah untuk membujang selamanya dan tidak akan mewarisi tahta ayahnya. Hal itu dikarenakan Bisma tidak ingin dia dan keturunannya berselisih dengan keturunan Satyawati, ibu tirinya.\n\n'
              'Setelah ditinggal Dewi Gangga, akhirnya Prabu Santanu menjadi duda. Beberapa tahun kemudian, Prabu Santanu melanjutkan kehidupan berumah tangga dengan menikahi Dewi Satyawati, puteri nelayan. Dari hubungannya, Sang Prabu berputera Sang Citranggada dan Wicitrawirya. Demi kebahagiaan adik-adipanya, Bisma pergi ke Kerajaan Kasi dan memenangkan sayembara sehingga berhasil membawa pulang tiga orang puteri bernama Amba, Ambika, dan Ambalika, untuk dinikahkan kepada adik-adiknya. Karena Citranggada wafat, maka Ambika dan Ambalika menikah dengan Wicitrawirya, sedangkan Amba mencintai Bisma namun Bisma menolak cintanya karena terikat oleh sumpah bahwa ia tidak akan kawin seumur hidup. Demi usaha untuk menjauhkan Amba dari dirinya, tanpa sengaja ia menembakkan panah menembus dada Amba. Atas kematian itu, Bisma diberitahu bahwa kelak Amba bereinkarnasi menjadi seorang pangeran yang memiliki sifat kewanitaan, yaitu putera Raja Drupada yang bernama Srikandi. (Kalau versi Jawa, Srikandi adalah seorang wanita sejati) Kelak kematiannya juga berada di tangan Srikandi yang membantu Arjuna dalam pertempuran akbar di Kurukshetra.\n\n'
              'Citranggada wafat di usia muda dalam suatu pertempuran, kemudian ia digantikan oleh adiknya yaitu Wicitrawirya. Wicitrawirya juga wafat di usia muda dan belum sempat memiliki keturunan.',
          'parwa_id': 1,
          'urutan': 1
        },
        {
          'nama_parwa': 'Sabhaparwa',
          'nama_babak': 'Permainan Dadu',
          'isi_narasi': 'Satyawati mengirim kedua istri Wicitrawirya, yaitu Ambika dan Ambalika untuk menemui Resi Byasa, sebab Sang Resi dipanggil untuk mengadakan suatu upacara bagi mereka agar memperoleh keturunan.\n\n'
              'Satyawati menyuruh Ambika agar menemui Resi Byasa di ruang upacara. Setelah Ambika memasuki ruangan upacara, ia melihat wajah Sang Resi sangat dahsyat dengan mata yang menyala-nyala. Hal itu membuatnya menutup mata. Karena Ambika menutup mata selama upacara berlangsung, maka anaknya terlahir buta. Anak tersebut adalah Drestarastra. Kemudian Ambalika disuruh oleh Satyawati untuk mengunjungi Byasa ke dalam sebuah kamar sendirian, dan di sana ia akan diberi anugerah. Ia juga disuruh agar terus membuka matanya supaya jangan melahirkan putra yang buta Drestarastra seperti yang telah dilakukan Ambika Maka dari itu, Ambalika terus membuka matanya namun ia menjadi pucat setelah melihat rupa Sang Bagawan Byasa yang luar biasa. Maka dari itu, Pandu (putranya), ayah para Pandawa, terlahir pucat. Drestarastra dan Pandu mempunyai saudara tiri yang bernama Widura. Widura merupakan anak dari Resi Byasa dengan seorang dayang Satyawati yang bernama Datri. Pada saat upacara dilangsungkan dia lari keluar kamar dan akhirnya terjatuh sehingga Widura pun lahir dengan kondisi pincang kakinya.\n\n'
              'Dikarenakan Drestarastra terlahir buta mata maka tahta Hastinapura diberikan kepada Pandu. Pandu menikahi Dewi Kunti,kemudian Pandu menikah untuk yang kedua kalinya dengan Dewi Madrim, namun akibat kesalahan Pandu pada saat memanah seekor kijang yang sedang kasmaran, maka kijang tersebut mengeluarkan kutukan bahwa Pandu tidak akan merasakan lagi hubungan suami istri, dan bila dilakukannya, maka Pandu akan mengalami ajal. Kijang tersebut kemudian mati dengan berubah menjadi wujud aslinya yaitu seorang pendeta. Kemudian karena mengalami kejadian buruk seperti itu, Pandu lalu mengajak kedua istrinya untuk bermohon kepada Hyang Maha Kuasa agar dapat diberikan anak.\n\n'
              'Atas bantuan mantra yang pernah diberikan oleh Resi Druwasa maka Dewi Kunti bisa memanggil para dewa untuk kemudian mendapatkan putra. Pertama kali mencoba mantra tersebut datanglah Batara Surya, tak lama kemudian Kunti mengandung dan melahirkan seorang anak yang kemudian diberi nama Karna. Tetapi Karna kemudian dilarung kelaut dan dirawat oleh Kurawa, sehingga nanti pada saat perang Bharatayuda, Karna memihak kepada Kurawa.\n\n'
              'Kemudian atas permintaan Pandu, Kunti mencoba mantra itu lagi, Batara Guru mengirimkan Batara Dharma untuk membuahi Dewi Kunti sehingga lahir anak yang pertama yaitu Yudistira, setahun kemudian Batara Bayu dikirim juga untuk membuahi Dewi Kunti sehingga lahirlah Bima, Batara Guru juga mengutus Batara Indra untuk membuahi Dewi Kunti sehingga lahirlah Arjuna dan yang terakhir Batara Aswan dan Aswin dikirimkan untuk membuahi Dewi Madrim, dan lahirlah Nakula dan Sadewa. Kelima putera Pandu tersebut dikenal sebagai Pandawa. Dretarastra yang buta menikahi Dewi Gendari, dan memiliki sembilan puluh sembilan orang putera dan seorang puteri yang dikenal dengan istilah Kurawa.\n\n'
              'Pandawa dan Kurawa merupakan dua kelompok dengan sifat yang berbeda namun berasal dari leluhur yang sama, yakni Kuru dan Bharata. Kurawa (khususnya Duryudana) bersifat licik dan selalu iri hati dengan kelebihan Pandawa, sedangkan Pandawa bersifat tenang dan selalu bersabar ketika ditindas oleh sepupu mereka. Ayah para Kurawa, yaitu Drestarastra, sangat menyayangi putera-puteranya. Hal itu membuat ia sering dihasut oleh iparnya yaitu Sengkuni, beserta putera kesayangannya yaitu Duryudana, agar mau mengizinkannya melakukan rencana jahat menyingkirkan para Pandawa.',
          'parwa_id': 2,
          'urutan': 2
        },
        {
          'nama_parwa': 'Wanaparwa',
          'nama_babak': 'Masa Pengasingan',
          'isi_narasi': 'Pada suatu ketika, Duryudana mengundang Kunti dan para Pandawa untuk liburan. Di sana mereka menginap di sebuah rumah yang sudah disediakan oleh Duryudana. Pada malam hari, rumah itu dibakar. Namun para Pandawa bisa diselamatkan oleh Bima yang telah diberitahu oleh Widura akan kelicikan Kurawa sehingga mereka tidak terbakar hidup-hidup dalam rumah tersebut. Usai menyelamatkan diri, Pandawa dan Kunti masuk hutan. (diceritakan dalam lakon Bale Sigala-gala).\n\n'
              'Di hutan tersebut Bima bertemu dengan raksasa bernama Arimba yang ingin membalas dendam kematian Ayahnya yaitu Arimbaka (dalam pedalangan Jawa disebut Trembaka), Bima unggul dan membunuhnya, lalu menikahi adiknya, yaitu raseksi Hidimbi atau Arimbi yang jatuh hati pada Bima. Dari pernikahan tersebut, lahirlah Gatotkaca.\n\n'
              'Setelah melewati hutan rimba, Pandawa melewati Kerajaan Pancala. Di sana tersiar kabar bahwa Raja Drupada menyelenggarakan sayembara memperebutkan Dewi Drupadi. Adipati Karna mengikuti sayembara tersebut, tetapi ditolak oleh Drupadi. Pandawa pun turut serta menghadiri sayembara itu, namun mereka berpakaian seperti kaum brahmana.\n\n'
              'Pandawa ikut sayembara untuk memenangkan lima macam sayembara, Yudistira untuk memenangkan sayembara filsafat dan tatanegara, Arjuna memenangkan sayembara senjata Panah, Bima memenangkan sayembara Gada dan Nakula Sadewa memenangkan sayembara senjata Pedang. Pandawa berhasil melakukannya dengan baik untuk memenangkan sayembara.\n\n'
              'Drupadi harus menerima Pandawa sebagai suami-suaminya karena sesuai janjinya siapa yang dapat memenangkan sayembara yang dibuatnya itu akan jadi suaminya walau menyimpang dari keinginannya yaitu sebenarnya yang diinginkan hanya seorang Satriya.\n\n'
              'Setelah itu perkelahian terjadi karena para hadirin menggerutu sebab kaum brahmana tidak selayaknya mengikuti sayembara. Pandawa berkelahi kemudian meloloskan diri. sesampainya di rumah, mereka berkata kepada ibunya bahwa mereka datang membawa hasil meminta-minta. Ibu mereka pun menyuruh agar hasil tersebut dibagi rata untuk seluruh saudaranya. Namun, betapa terkejutnya ia saat melihat bahwa anak-anaknya tidak hanya membawa hasil meminta-minta, namun juga seorang wanita. (Dalam Pedalangan Jawa Drupadi hanya menjadi istri Yudistira / Puntadewa seorang).\n\n'
              'Agar tidak terjadi pertempuran sengit, Kerajaan Kuru dibagi dua untuk dibagi kepada Pandawa dan Kurawa. Kurawa memerintah Kerajaan Kuru induk (pusat) dengan ibukota Hastinapura, sementara Pandawa memerintah Kerajaan Kurujanggala dengan ibukota Indraprastha. Baik Hastinapura maupun Indraprastha memiliki istana megah, dan di sanalah Duryudana tercebur ke dalam kolam yang ia kira sebagai lantai, sehingga dirinya menjadi bahan ejekan bagi Drupadi. Hal tersebut membuatnya bertambah marah kepada para Pandawa.',
          'parwa_id': 3,
          'urutan': 3
        },
        {
          'nama_parwa': 'Wirataparwa',
          'nama_babak': 'Penyamaran di Wirata',
          'isi_narasi': 'Untuk merebut kekayaan dan kerajaan Yudistira, Duryudana mengundang Yudistira untuk bermain permainan dadu, ini atas ide dari Arya Sengkuni. Pada saat permainan dadu, Duryudana diwakili oleh Sengkuni sebagai bandar dadu yang memiliki kesaktian untuk berbuat curang. Permulaan permainan taruhan senjata perang, taruhan pemainan terus meningkat menjadi taruhan harta kerajaan, selanjutnya prajurit dipertaruhkan, dan sampai pada puncak permainan Kerajaan menjadi taruhan, Pandawa kalah habislah semua harta dan kerajaan Pandawa termasuk saudara juga dipertaruhkan dan yang terakhir istrinya Drupadi dijadikan taruhan. Akhirnya Yudistira kalah dan Drupadi diminta untuk hadir di arena judi karena sudah menjadi milik Duryudana.\n\n'
              'Duryudana mengutus para pengawalnya untuk menjemput Drupadi, namun Drupadi menolak. Setelah gagal, Duryudana menyuruh Dursasana adiknya, untuk menjemput Drupadi. Drupadi yang menolak untuk datang, diseret oleh Dursasana yang tidak memiliki rasa kemanusiaan. Rambutnya ditarik sampai ke arena judi, tempat suami dan para iparnya berkumpul. Karena sudah kalah, Yudistira dan seluruh adiknya diminta untuk menanggalkan bajunya, namun Drupadi menolak. Dursasana yang berwatak kasar, menarik kain yang dipakai Drupadi, namun kain tersebut terulur-ulur terus dan tak habis-habis karena mendapat kekuatan gaib dari Sri Kresna yang melihat Dropadi dalam bahaya. Pertolongan Sri Kresna disebabkan karena perbuatan Dropadi yang membalut luka Sri Kresna pada saat upacara Rajasuya di Indraprastha.\n\n'
              'Drupadi yang merasa malu dan tersinggung oleh sikap Dursasana bersumpah tidak akan menggelung rambutnya sebelum dikramasi dengan darah Dursasana. Bima pun bersumpah akan membunuh Dursasana dan meminum darahnya kelak. Setelah mengucapkan sumpah tersebut, Drestarastra merasa bahwa malapetaka akan menimpa keturunannya, maka ia mengembalikan segala harta Yudistira yang dijadikan taruhan.\n\n'
              'Duryudana yang merasa kecewa karena Drestarastra telah mengembalikan semua harta yang sebenarnya akan menjadi miliknya, menyelenggarakan permainan dadu untuk yang kedua kalinya. Kali ini, siapa yang kalah harus mengasingkan diri ke hutan selama 12 tahun, setelah itu hidup dalam masa penyamaran selama setahun, dan setelah itu berhak kembali lagi ke kerajaannya. Untuk yang kedua kalinya, Yudistira mengikuti permainan tersebut dan sekali lagi ia kalah. Karena kekalahan tersebut, Pandawa terpaksa meninggalkan kerajaan mereka selama 12 tahun dan hidup dalam masa penyamaran selama setahun.\n\n'
              'Setelah masa pengasingan habis dan sesuai dengan perjanjian yang sah, Pandawa berhak untuk mengambil alih kembali kerajaan yang dipimpin Duryudana. Namun Duryudana bersifat jahat. Ia tidak mau menyerahkan kerajaan kepada Pandawa, walau seluas ujung jarum pun. Hal itu membuat kesabaran Pandawa habis. Misi damai dilakukan oleh Sri Kresna, namun berkali-kali gagal. Akhirnya, pertempuran tidak dapat dielakkan lagi.',
          'parwa_id': 4,
          'urutan': 4
        },
        {
          'nama_parwa': 'Bharatayuda',
          'nama_babak': 'Perang Bharatayuda',
          'isi_narasi': 'Pandawa berusaha mencari sekutu dan ia mendapat bantuan pasukan dari Kerajaan Kerajaan Kekaya, Kerajaan Matsya, Kerajaan Pandya, Kerajaan Chola, Kerajaan Kerala, Kerajaan Magadha, Wangsa Yadawa, Kerajaan Dwaraka, dan masih banyak lagi. Selain itu para ksatria besar di Bharatawarsha seperti misalnya Drupada, Setyaki, Drestadjumna, Srikandi, dan lain-lain ikut memihak Pandawa. Sementara itu Duryudana meminta Bisma untuk memimpin pasukan Kurawa sekaligus mengangkatnya sebagai panglima tertinggi pasukan Kurawa. Kurawa dibantu oleh Resi Dorna dan putranya Aswatama, kakak ipar para Kurawa yaitu Jayadrata, serta guru Krepa, Kertawarma, Salya, Sudaksina, Burisrawa, Bahlika, Sengkuni, Karna, dan masih banyak lagi.\n\n'
              'Pertempuran berlangsung selama 18 hari penuh. Dalam pertempuran itu, banyak ksatria yang gugur, seperti misalnya Abimanyu, Durna, Karna, Bisma, Gatotkaca, Irawan, Prabu Matswapati dan puteranya (Raden Seta, Raden Utara, Raden Wratsangka), Bhogadatta, Sengkuni, dan masih banyak lagi.\n\n'
              'Hari 1–10: Kepemimpinan Bisma Perang dimulai di medan Kurukshetra dengan Bisma sebagai panglima Kurawa. Ia sangat kuat dan hampir tak terkalahkan karena tidak ingin membunuh Pandawa sepenuh hati. Banyak pasukan Pandawa gugur di fase ini. Akhirnya, atas saran Kresna, Arjuna menggunakan Srikandi (reinkarnasi Amba yang dibenci Bisma) sebagai tameng. Bisma tidak mau melawan Srikandi, sehingga Arjuna berhasil menjatuhkannya dengan banyak panah hingga ia roboh di atas “ranjang panah”.\n\n'
              'Hari 11–15: Kepemimpinan Drona Setelah Bisma jatuh, Drona menjadi panglima. Ia menggunakan strategi licik seperti formasi Cakravyuha. Dalam formasi ini, Abimanyu (putra Arjuna) masuk dan bertarung dengan gagah berani, tetapi akhirnya gugur karena dikeroyok secara tidak adil. Kematian Abimanyu membuat Pandawa sangat marah. Untuk mengalahkan Drona, digunakan tipu muslihat: dikabarkan bahwa Aswatama (anak Drona) telah mati. Mendengar itu, Drona kehilangan semangat dan akhirnya terbunuh.\n\n'
              'Hari 16–17: Kepemimpinan Karna\nKarna kemudian menjadi panglima. Ia adalah petarung hebat dan rival utama Arjuna. Pertempuran antara Karna dan Arjuna menjadi salah satu momen paling penting. Saat bertarung, roda kereta Karna terjebak di tanah, dan ia tidak bisa melawan dengan maksimal. Dalam kondisi itu, Arjuna atas perintah Kresna tetap menyerang, dan akhirnya Karna gugur.\n\n'
              'Hari 18: Akhir Perang dan Jatuhnya Kurawa. Hari terakhir menjadi penentu. Hampir seluruh pasukan Kurawa telah hancur. Pertempuran terakhir terjadi antara Bima dan Duryudana. Bima melanggar aturan dengan memukul paha Duryudana (bagian yang seharusnya tidak boleh diserang), hingga Duryudana kalah dan sekarat. Dengan jatuhnya Duryudana, perang pun berakhir dan kemenangan berada di pihak Pandawa.\n\n'
              'Dampak Setelah Bharatayuda Perang ini menewaskan hampir seluruh ksatria besar dari kedua pihak, menyisakan hanya sedikit yang hidup. Kemenangan Pandawa dibayar dengan kehilangan besar, termasuk keluarga dan sekutu mereka. Setelah itu, Yudistira menjadi raja, namun hidupnya dipenuhi rasa sedih dan penyesalan. Bharatayuda menunjukkan bahwa meskipun menang, perang tetap membawa kehancuran dan penderitaan bagi semua pihak.\n\n'
              'Setelah perang berakhir, Yudistira dinobatkan sebagai Raja Hastinapura bergelar Prabu Kalimataya Setelah memerintah selama beberapa lama, ia menyerahkan tahta kepada cucu Arjuna, yaitu Parikesit. Kemudian, Yudistira bersama Pandawa dan Drupadi mendaki gunung Himalaya sebagai tujuan akhir perjalanan mereka. Di sana mereka meninggal dan mencapai surga. (Diceritakan dalam kisah Pandawa Seda).\n\n'
              'Parikesit memimpin Kerajaan Kuru dengan adil dan bijaksana. Ia menikahi Madrawati dan memiliki putera bernama Janamejaya. Janamejaya menikahi Wapushtama (Bhamustiman) dan memiliki putera bernama Satanika. Satanika berputera Aswamedhadatta. Aswamedhadatta dan keturunannya kemudian memimpin Kerajaan Wangsa Kuru di Hastinapura.',
          'parwa_id': 5,
          'urutan': 5
        }
      ];

      for (var s in seratList) {
        await db.insert('serat_mahabharata', s);
      }
    }
  }
}
