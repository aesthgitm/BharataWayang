import 'package:sqflite/sqflite.dart';

class DatabaseSeeder {
  static Future<void> seedDatabase(Database db) async {
    await _seedKartuWayang(db);
    await _seedKumpulanSoal(db);
    await _seedSeratMahabharata(db);
    await _seedFaq(db);
  }

  static Future<void> _seedKartuWayang(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM kartu_wayang'));
    if (count == 0) {
      final List<Map<String, dynamic>> kartuList = [
        {
          'id': 1, 'nama': 'Puntadewa (Prabu Yudistira)', 'afiliasi': 'Pandawa',
          'deskripsi': 'Putra sulung Pandawa, titisan Batara Darma. Dalam pewayangan Jawa ia dikenal sebagai Prabu Puntadewa, raja Amarta yang adil dan jujur. Tidak pernah berdusta dan selalu mengutamakan dharma dalam setiap langkahnya.',
          'image_asset': 'assets/wayang/puntadewa.webp', 'rarity': 'Langka'
        },
        {
          'id': 2, 'nama': 'Werkudara (Bratasena / Bima)', 'afiliasi': 'Pandawa',
          'deskripsi': 'Putra kedua Pandawa, titisan Batara Bayu. Dalam pewayangan Jawa, Bima lebih sering disebut Werkudara atau Bratasena. Ia selalu berbicara lurus tanpa basa-basi bahkan kepada dewa sekalipun, lambang ksatria yang tidak mengenal kemunafikan.',
          'image_asset': 'assets/wayang/werkudara.webp', 'rarity': 'Langka'
        },
        {
          'id': 3, 'nama': 'Janaka (Permadi / Dananjaya / Arjuna)', 'afiliasi': 'Pandawa',
          'deskripsi': 'Putra ketiga Pandawa, titisan Batara Indra. Dalam pewayangan Jawa ia memiliki banyak nama gelar: Janaka, Permadi, Dananjaya, Palguna. Ksatria paling tampan dan pemanah paling sakti di Tanah Jawa.',
          'image_asset': 'assets/wayang/janaka.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 4, 'nama': 'Nakula', 'afiliasi': 'Pandawa',
          'deskripsi': 'Putra keempat Pandawa, anak dari Batara Aswin (kembar dengan Sadewa). Nakula sangat tampan dan dikenal ahli dalam merawat kuda dan ilmu pengobatan. Ia adalah sosok yang setia pada keluarga.',
          'image_asset': 'assets/wayang/nakula.webp', 'rarity': 'Umum'
        },
        {
          'id': 5, 'nama': 'Sadewa', 'afiliasi': 'Pandawa',
          'deskripsi': 'Putra kelima Pandawa, saudara kembar Nakula dari Batara Aswin. Sadewa adalah yang paling cerdas di antara Pandawa dalam hal ilmu perbintangan dan ramalan. Ia sangat patuh dan penuh hormat.',
          'image_asset': 'assets/wayang/sadewa.webp', 'rarity': 'Umum'
        },
        {
          'id': 6, 'nama': 'Sri Kresna (Prabu Kresna)', 'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Raja Dwarawati, titisan Batara Wisnu. Dalam pewayangan Jawa, Kresna adalah tokoh terpenting di pihak Pandawa — penasihat, diplomat, dan penggerak strategi perang Bharatayuda. Ia juga menyampaikan Wulang (ajaran) kepada Janaka sebelum perang.',
          'image_asset': 'assets/wayang/sri_kresna.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 7, 'nama': 'Gatotkaca', 'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putra Bima dari Dewi Arimbi, keturunan raksasa yang gagah. Gatotkaca memiliki tubuh raksasa dan bisa terbang. Ia gugur di tangan Karna menggunakan senjata Kunta, namun kematiannya menyelamatkan Arjuna.',
          'image_asset': 'assets/wayang/gatotkaca.webp', 'rarity': 'Langka'
        },
        {
          'id': 8, 'nama': 'Abimanyu', 'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putra Arjuna dari Subadra. Abimanyu sudah belajar ilmu perang sejak dalam kandungan. Ia gugur secara heroik dalam formasi Cakravyuha pada perang Bharatayudha, dikeroyok banyak ksatria Kurawa.',
          'image_asset': 'assets/wayang/abimanyu.webp', 'rarity': 'Langka'
        },
        {
          'id': 9, 'nama': 'Suyudhana (Prabu Duryudana)', 'afiliasi': 'Kurawa',
          'deskripsi': 'Putra sulung Drestarastra, Raja Ngastina yang menjadi pemimpin Kurawa. Dalam pewayangan Jawa namanya yang benar adalah Suyudhana (bukan Duryodhana). Ia menolak membagi kerajaan dengan Pandawa dan menjadi tokoh utama pemicu perang Bharatayuda.',
          'image_asset': 'assets/wayang/suyudhana.webp', 'rarity': 'Langka'
        },
        {
          'id': 10, 'nama': 'Adipati Karna (Basukarna)', 'afiliasi': 'Kurawa',
          'deskripsi': 'Dalam pewayangan Jawa disebut Adipati Karna atau Basukarna. Ia adalah putra pertama Dewi Kunti yang dirahasiakan. Dibesarkan oleh kusir kereta di Kerajaan Awangga. Memihak Kurawa karena kesetiaan murni pada Suyudhana yang memberinya kehormatan.',
          'image_asset': 'assets/wayang/adipati_karna.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 11, 'nama': 'Sakuni', 'afiliasi': 'Kurawa',
          'deskripsi': 'Paman Duryudhana dari kerajaan Gandhara. Sakuni adalah otak di balik berbagai tipu muslihat yang menimpa Pandawa, termasuk permainan dadu yang menyebabkan Pandawa diasingkan 12 tahun.',
          'image_asset': 'assets/wayang/sakuni.webp', 'rarity': 'Umum'
        },
        {
          'id': 12, 'nama': 'Resi Bisma (Dewabrata)', 'afiliasi': 'Pihak Ngastina (Netral)',
          'deskripsi': 'Putra Prabu Sentanu dan Dewi Gangga, nama aslinya Dewabrata. Dalam pewayangan Jawa, Resi Bisma adalah tokoh paling dihormati — sesepuh kerajaan Ngastina yang bersumpah tidak akan menikah. Anugerahnya: menentukan waktu kematiannya sendiri.',
          'image_asset': 'assets/wayang/resi_bisma.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 13, 'nama': 'Resi Drona (Sokalima)', 'afiliasi': 'Pihak Ngastina',
          'deskripsi': 'Guru besar ilmu perang bagi semua pangeran Kuru. Dalam pewayangan Jawa, Drona tinggal di pertapaan Sokalima. Ia mengajarkan ilmu Bramastra kepada Janaka namun juga memihak Kurawa saat perang Bharatayuda.',
          'image_asset': 'assets/wayang/resi_drona.webp', 'rarity': 'Langka'
        },
        {
          'id': 14, 'nama': 'Dewi Wara Drupadi', 'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putri Raja Drupada yang lahir dari api suci, menjadi istri kelima Pandawa (Dalam versi Jawa hanya istri Yudistira). Penghinaan yang diterimanya di muka umum oleh Dursasana menjadi pemicu utama perang Bharatayuda.',
          'image_asset': 'assets/wayang/dewi_drupadi.webp', 'rarity': 'Langka'
        },
        {
          'id': 15, 'nama': 'Dewi Srikandi', 'afiliasi': 'Sekutu Pandawa',
          'deskripsi': 'Putri Raja Drupada, saudara Dewi Drupadi. Dalam pewayangan Jawa, Srikandi adalah murid Janaka (Arjuna) dalam ilmu memanah dan kemudian menjadi istrinya. Ia menjadi kunci penghancur Resi Bisma dalam perang Bharatayuda.',
          'image_asset': 'assets/wayang/dewi_srikandi.webp', 'rarity': 'Langka'
        },
        {
          'id': 16, 'nama': 'Batara Guru (Dewa Siwa)', 'afiliasi': 'Dewa',
          'deskripsi': 'Penguasa tertinggi Kahyangan dalam kosmologi pewayangan Jawa. Batara Guru adalah wujud Siwa yang paling dihormati. Ia pemberi anugerah kepada ksatria pilihan, termasuk memberikan senjata Pasopati kepada Janaka.',
          'image_asset': 'assets/wayang/batara_guru.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 17, 'nama': 'Batara Indra', 'afiliasi': 'Dewa',
          'deskripsi': 'Raja para dewa di Kahyangan, ayah kandung Janaka (Arjuna). Dalam pewayangan Jawa, Batara Indra sering turun membantu para ksatria pilihan dan mengajari Janaka ilmu perang di Kahyangan.',
          'image_asset': 'assets/wayang/batara_indra.webp', 'rarity': 'Langka'
        },
        {
          'id': 18, 'nama': 'Semar (Batara Ismaya)', 'afiliasi': 'Punakawan',
          'deskripsi': 'Sosok paling agung dalam pewayangan Jawa. Semar sejatinya adalah Batara Ismaya, dewa yang rela turun ke bumi menjadi abdi para ksatria Pandawa. Wujudnya jelek namun kebijaksanaannya melampaui para dewa.',
          'image_asset': 'assets/wayang/semar.webp', 'rarity': 'Legendaris'
        },
        {
          'id': 19, 'nama': 'Nala Gareng', 'afiliasi': 'Punakawan',
          'deskripsi': 'Putra angkat pertama Semar. Gareng cacat fisik yang melambangkan manusia penuh kekurangan namun tetap bersemangat. Dalam banyak lakon ia menjadi penghibur sekaligus penyampai pesan moral.',
          'image_asset': 'assets/wayang/gareng.webp', 'rarity': 'Umum'
        },
        {
          'id': 20, 'nama': 'Petruk (Kanthong Bolong)', 'afiliasi': 'Punakawan',
          'deskripsi': 'Putra angkat kedua Semar, dikenal dengan hidung panjang dan tubuh jangkung. Petruk adalah Punakawan paling humoris dan cerdas. Dalam lakon "Petruk dadi Ratu," ia bahkan berhasil merebut kerajaan sementara.',
          'image_asset': 'assets/wayang/petruk.webp', 'rarity': 'Umum'
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
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang diakui sebagai Warisan Budaya Takbenda oleh UNESCO pada tahun...', 'pilihan_a': '1998', 'pilihan_b': '2001', 'pilihan_c': '2003', 'pilihan_d': '2005', 'jawaban_benar': 'C', 'penjelasan': 'UNESCO mengakui Wayang Indonesia sebagai Masterpiece of the Oral and Intangible Heritage of Humanity pada tanggal 7 November 2003.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Layar putih yang digunakan sebagai media pertunjukan wayang kulit disebut...', 'pilihan_a': 'Blencong', 'pilihan_b': 'Gedebog', 'pilihan_c': 'Kelir', 'pilihan_d': 'Gunungan', 'jawaban_benar': 'C', 'penjelasan': 'Kelir adalah layar putih yang menjadi tempat bayangan wayang diproyeksikan selama pertunjukan berlangsung.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Lampu yang digunakan untuk menerangi pertunjukan wayang kulit tradisional disebut...', 'pilihan_a': 'Blencong', 'pilihan_b': 'Senthir', 'pilihan_c': 'Kelir', 'pilihan_d': 'Debog', 'jawaban_benar': 'A', 'penjelasan': 'Blencong adalah lampu minyak tradisional yang digunakan untuk menerangi kelir dan menciptakan efek bayangan wayang.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang yang terbuat dari kulit kerbau dan dimainkan dengan bayangan adalah...', 'pilihan_a': 'Wayang Golek', 'pilihan_b': 'Wayang Orang', 'pilihan_c': 'Wayang Kulit', 'pilihan_d': 'Wayang Klitik', 'jawaban_benar': 'C', 'penjelasan': 'Wayang Kulit adalah jenis wayang yang paling terkenal, terbuat dari kulit kerbau yang dipahat halus dan dimainkan di balik layar dengan bayangan.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Wayang yang berbentuk tiga dimensi (3D) dan terbuat dari kayu adalah...', 'pilihan_a': 'Wayang Kulit', 'pilihan_b': 'Wayang Golek', 'pilihan_c': 'Wayang Beber', 'pilihan_d': 'Wayang Klitik', 'jawaban_benar': 'B', 'penjelasan': 'Wayang Golek adalah boneka kayu tiga dimensi yang biasanya digunakan di pertunjukan Sunda (Jawa Barat), tanpa menggunakan layar bayangan.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Pemimpin pertunjukan wayang yang mengendalikan semua boneka dan bercerita disebut...', 'pilihan_a': 'Sinden', 'pilihan_b': 'Niyaga', 'pilihan_c': 'Dalang', 'pilihan_d': 'Wiraswara', 'jawaban_benar': 'C', 'penjelasan': 'Dalang adalah seniman utama pertunjukan wayang yang mengendalikan semua boneka, membacakan dialog, dan menceritakan lakon (kisah).'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Tokoh wayang yang digambarkan berbentuk gunung/kipas dan merupakan simbol keseimbangan dunia disebut...', 'pilihan_a': 'Kresna', 'pilihan_b': 'Semar', 'pilihan_c': 'Gunungan (Kayon)', 'pilihan_d': 'Togog', 'jawaban_benar': 'C', 'penjelasan': 'Gunungan atau Kayon adalah wayang berbentuk gunung yang digunakan sebagai pembuka/penutup pertunjukan dan melambangkan keseimbangan alam semesta.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Boneka wayang ditancapkan pada batang pohon pisang yang disebut...', 'pilihan_a': 'Kelir', 'pilihan_b': 'Gedebog', 'pilihan_c': 'Blencong', 'pilihan_d': 'Kothak', 'jawaban_benar': 'B', 'penjelasan': 'Gedebog adalah batang pohon pisang yang digunakan sebagai tempat menancapkan gagang wayang selama pertunjukan berlangsung.'},
        {'level': 1, 'kategori': 'Pengenalan Wayang', 'pertanyaan': 'Lakon (kisah) terbesar yang sering dimainkan dalam pertunjukan wayang adalah...', 'pilihan_a': 'Ramayana dan Mahabharata', 'pilihan_b': 'Serat Centhini dan Babad Tanah Jawi', 'pilihan_c': 'Panji dan Menak', 'pilihan_d': 'Sri dan Sadana', 'jawaban_benar': 'A', 'penjelasan': 'Ramayana dan Mahabharata adalah dua epos terbesar asal India yang paling sering diadaptasi dalam pertunjukan wayang kulit Jawa.'},

        // LEVEL 2
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Siapakah tokoh yang mendirikan kota Hastinapura sebagai pusat pemerintahan?', 'pilihan_a': 'Sang Kuru', 'pilihan_b': 'Sang Hasti', 'pilihan_c': 'Sang Bharata', 'pilihan_d': 'Pratipa', 'jawaban_benar': 'B', 'penjelasan': 'Sang Hasti adalah keturunan Sang Bharata yang mendirikan kota Hastinapura.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Dewabrata berganti nama menjadi Bisma karena melakukan sumpah yang disebut "Bhishan Pratigya." Isi sumpah tersebut adalah...', 'pilihan_a': 'Tidak akan pernah berperang melawan Pandawa', 'pilihan_b': 'Membujang selamanya dan tidak mewarisi takhta ayahnya', 'pilihan_c': 'Selalu melindungi kerajaan Hastinapura sampai mati', 'pilihan_d': 'Tidak akan pernah menyerang dari belakang', 'jawaban_benar': 'B', 'penjelasan': 'Dewabrata bersumpah membujang seumur hidup dan tidak mewarisi takhta.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Mengapa Drestarastra terlahir dalam keadaan buta?', 'pilihan_a': 'Dikutuk oleh Resi Byasa sebelum lahir', 'pilihan_b': 'Ibunya (Ambika) menutup mata selama upacara dengan Resi Byasa berlangsung', 'pilihan_c': 'Ayahnya memiliki penyakit bawaan', 'pilihan_d': 'Lahir prematur', 'jawaban_benar': 'B', 'penjelasan': 'Ambika terkejut dengan wajah sakti Resi Byasa lalu menutup mata, sehingga anaknya (Drestarastra) lahir buta.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Mengapa Pandu terlahir berwarna pucat?', 'pilihan_a': 'Lahir prematur', 'pilihan_b': 'Ibunya (Ambalika) menjadi sangat pucat ketakutan saat melihat Resi Byasa', 'pilihan_c': 'Kutukan dewa', 'pilihan_d': 'Keturunan penyakit', 'jawaban_benar': 'B', 'penjelasan': 'Ambalika membuka mata namun sangat ketakutan dan pucat, sehingga Pandu terlahir pucat.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Widura adalah putra Resi Byasa dari siapa, and mengapa ia lahir dengan kaki pincang?', 'pilihan_a': 'Dari Ambika, kena kutukan', 'pilihan_b': 'Dari dayang Datri; lahir pincang karena Datri berlari keluar saat upacara', 'pilihan_c': 'Dari Ambalika', 'pilihan_d': 'Dari Satyawati', 'jawaban_benar': 'B', 'penjelasan': 'Datri ketakutan dan berlari keluar kamar hingga terjatuh, sehingga Widura lahir pincang.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Pandu mendapat kutukan tidak bisa punya anak karena memanah seekor kijang yang ternyata adalah...', 'pilihan_a': 'Dewa pelindung hutan', 'pilihan_b': 'Seorang pendeta sakti yang sedang kasmaran', 'pilihan_c': 'Utusan Batara Guru', 'pilihan_d': 'Raja iblis', 'jawaban_benar': 'B', 'penjelasan': 'Kijang tersebut adalah pendeta yang menjelma. Sang pendeta mengutuk Pandu sebelum mati.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Siapa yang memberikan mantra kepada Dewi Kunti agar bisa memanggil dewa?', 'pilihan_a': 'Resi Byasa', 'pilihan_b': 'Resi Druwasa', 'pilihan_c': 'Batara Guru', 'pilihan_d': 'Prabu Santanu', 'jawaban_benar': 'B', 'penjelasan': 'Resi Druwasa memberikan mantra sakti kepada Kunti karena pelayanannya yang baik.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Karna adalah anak pertama Dewi Kunti dari Batara Surya. Apa yang terjadi kepadanya?', 'pilihan_a': 'Dibesarkan Kunti diam-diam', 'pilihan_b': 'Dilarung ke sungai dan dirawat oleh kusir di Awangga', 'pilihan_c': 'Dikirim ke pertapaan', 'pilihan_d': 'Tinggal bersama Pandawa', 'jawaban_benar': 'B', 'penjelasan': 'Kunti membuang Karna ke sungai, lalu ia dirawat oleh Adirata si kusir.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Pasangan dewa mana yang membuahi Dewi Madrim sehingga lahir Nakula dan Sadewa?', 'pilihan_a': 'Bayu dan Indra', 'pilihan_b': 'Batara Aswan dan Batara Aswin', 'pilihan_c': 'Surya dan Darma', 'pilihan_d': 'Wisnu dan Siwa', 'jawaban_benar': 'B', 'penjelasan': 'Dewa kembar Aswan dan Aswin memberikan anugerah anak kembar, Nakula dan Sadewa.'},
        {'level': 2, 'kategori': 'Silsilah Pandawa & Kurawa', 'pertanyaan': 'Drestarastra menikah dengan Dewi Gendari dan memiliki berapa anak?', 'pilihan_a': '50 putra, 2 putri', 'pilihan_b': '99 putra, 1 putri', 'pilihan_c': '100 putra, 0 putri', 'pilihan_d': '99 putra, 2 putri', 'jawaban_benar': 'B', 'penjelasan': 'Mereka memiliki 99 orang putra dan 1 putri yang dikenal sebagai Kurawa.'},

        // LEVEL 3
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Lakon apa yang menceritakan rencana Kurawa membakar rumah Pandawa?', 'pilihan_a': 'Baratayuda', 'pilihan_b': 'Bale Sigala-gala', 'pilihan_c': 'Pandawa Seda', 'pilihan_d': 'Dewa Ruci', 'jawaban_benar': 'B', 'penjelasan': 'Peristiwa pembakaran rumah Pandawa (Bale Sigala-gala). Pandawa selamat karena bantuan Widura.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Siapa yang memberitahu Pandawa tentang rencana pembakaran tersebut?', 'pilihan_a': 'Sri Kresna', 'pilihan_b': 'Resi Bisma', 'pilihan_c': 'Widura', 'pilihan_d': 'Sengkuni', 'jawaban_benar': 'C', 'penjelasan': 'Widura yang merupakan paman Pandawa memberitahu mereka tentang rencana jahat tersebut.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Dalam pedalangan Jawa, ayah raksasa Arimba bernama...', 'pilihan_a': 'Hidimba', 'pilihan_b': 'Trembaka (Arimbaka)', 'pilihan_c': 'Pracona', 'pilihan_d': 'Yaksadewa', 'jawaban_benar': 'B', 'penjelasan': 'Dalam versi Jawa, ayahnya adalah Trembaka. Adik Arimba yaitu Arimbi kemudian menikahi Bima.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Dalam versi pedalangan Jawa, Dewi Drupadi adalah istri dari...', 'pilihan_a': 'Kelima Pandawa', 'pilihan_b': 'Puntadewa (Yudistira) seorang', 'pilihan_c': 'Janaka (Arjuna)', 'pilihan_d': 'Werkudara (Bima)', 'jawaban_benar': 'B', 'penjelasan': 'Berbeda dengan versi India di mana ia bersuami lima, dalam wayang Jawa ia hanya istri Yudistira.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Ibukota kerajaan Pandawa adalah...', 'pilihan_a': 'Hastinapura', 'pilihan_b': 'Indraprastha', 'pilihan_c': 'Pancala', 'pilihan_d': 'Dwarawati', 'jawaban_benar': 'B', 'penjelasan': 'Pandawa membangun Indraprastha di tanah Kurujanggala yang tadinya merupakan hutan gersang.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Apa yang membuat Duryudana sangat membenci Pandawa saat mengunjungi Indraprastha?', 'pilihan_a': 'Melihat kekayaan mereka', 'pilihan_b': 'Ia tercebur kolam yang dikira lantai, lalu ditertawakan Drupadi', 'pilihan_c': 'Dihina Kresna', 'pilihan_d': 'Tidak diberi jamuan', 'jawaban_benar': 'B', 'penjelasan': 'Duryudana tertipu oleh lantai kristal dan tercebur ke air, menjadi bahan ejekan.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Siapa "bandar dadu" Kurawa yang curang menjebak Pandawa?', 'pilihan_a': 'Dursasana', 'pilihan_b': 'Arya Sengkuni', 'pilihan_c': 'Karna', 'pilihan_d': 'Drona', 'jawaban_benar': 'B', 'penjelasan': 'Arya Sengkuni adalah otak kelicikan yang menggunakan dadu bertuah untuk mengalahkan Yudistira.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Mengapa Sri Kresna membantu agar kain Drupadi tidak habis saat ditarik?', 'pilihan_a': 'Kresna kakaknya', 'pilihan_b': 'Drupadi pernah membalut luka jari Kresna', 'pilihan_c': 'Anugerah dewa', 'pilihan_d': 'Sihir dari cincin', 'jawaban_benar': 'B', 'penjelasan': 'Drupadi membalut jari Kresna yang terluka saat upacara Rajasuya, dibalas dengan perlindungan kain tak terbatas.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Sumpah Drupadi setelah dipermalukan Dursasana adalah...', 'pilihan_a': 'Membunuh Duryudana', 'pilihan_b': 'Tidak menggelung rambut sebelum dikeramas dengan darah Dursasana', 'pilihan_c': 'Meninggalkan Pandawa', 'pilihan_d': 'Mengutuk Hastina', 'jawaban_benar': 'B', 'penjelasan': 'Drupadi bersumpah tidak akan merapikan rambutnya hingga dibasuh darah Dursasana.'},
        {'level': 3, 'kategori': 'Konflik & Pengasingan', 'pertanyaan': 'Berapa lama total hukuman pengasingan Pandawa setelah kalah dadu?', 'pilihan_a': '10 tahun + 2 tahun menyamar', 'pilihan_b': '12 tahun di hutan + 1 tahun menyamar', 'pilihan_c': '13 tahun tanpa menyamar', 'pilihan_d': '14 tahun penuh', 'jawaban_benar': 'B', 'penjelasan': 'Mereka dihukum buang selama 12 tahun di hutan dan 1 tahun masa penyamaran (incognito).'},

        // LEVEL 4
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Berapa hari perang Bharatayuda berlangsung?', 'pilihan_a': '10 hari', 'pilihan_b': '14 hari', 'pilihan_c': '18 hari', 'pilihan_d': '21 hari', 'jawaban_benar': 'C', 'penjelasan': 'Perang suci ini berlangsung selama 18 hari penuh di Kurusetra.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa panglima Kurawa pada hari 1-10?', 'pilihan_a': 'Resi Drona', 'pilihan_b': 'Adipati Karna', 'pilihan_c': 'Resi Bisma', 'pilihan_d': 'Salya', 'jawaban_benar': 'C', 'penjelasan': 'Resi Bisma menjadi senapati pertama dan tak terkalahkan hingga hari ke-10.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Mengapa Arjuna menggunakan Srikandi sebagai tameng melawan Bisma?', 'pilihan_a': 'Srikandi kebal senjata', 'pilihan_b': 'Bisma bersumpah tidak akan menyerang perempuan', 'pilihan_c': 'Srikandi adik Arjuna', 'pilihan_d': 'Perintah dewa', 'jawaban_benar': 'B', 'penjelasan': 'Bisma tidak menyerang Srikandi karena sumpah ksatria-nya, sehingga Arjuna bisa menyerang dari balik Srikandi.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Formasi melingkar yang menjebak Abimanyu disebut...', 'pilihan_a': 'Garuda Byuha', 'pilihan_b': 'Makara Byuha', 'pilihan_c': 'Cakravyuha', 'pilihan_d': 'Padma', 'jawaban_benar': 'C', 'penjelasan': 'Cakravyuha adalah formasi buatan Drona. Abimanyu tahu cara masuk namun tak tahu cara keluar.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Bagaimana cara Pandawa mengalahkan Resi Drona?', 'pilihan_a': 'Bramastra', 'pilihan_b': 'Menyebarkan kabar bohong bahwa putranya (Aswatama) mati', 'pilihan_c': 'Bantuan Semar', 'pilihan_d': 'Dikeroyok Bima dan Arjuna', 'jawaban_benar': 'B', 'penjelasan': 'Kabar bohong gugurnya Aswatama membuat Drona kehilangan semangat bertarung dan menundukkan senjata.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa panglima Kurawa pada hari ke-16?', 'pilihan_a': 'Aswatama', 'pilihan_b': 'Adipati Karna', 'pilihan_c': 'Sengkuni', 'pilihan_d': 'Salya', 'jawaban_benar': 'B', 'penjelasan': 'Adipati Karna menggantikan Drona sebagai panglima tertinggi.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Mengapa Karna kesulitan melawan Arjuna di akhir?', 'pilihan_a': 'Kehabisan panah', 'pilihan_b': 'Roda keretanya terperosok ke lumpur', 'pilihan_c': 'Zirahnya hilang', 'pilihan_d': 'Terkena sihir Kresna', 'jawaban_benar': 'B', 'penjelasan': 'Karena kutukan, roda kereta Karna amblas ke tanah dan ia lupa mantra senjatanya.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Siapa yang gugur di dalam formasi Cakravyuha?', 'pilihan_a': 'Gatotkaca', 'pilihan_b': 'Irawan', 'pilihan_c': 'Abimanyu', 'pilihan_d': 'Utara', 'jawaban_benar': 'C', 'penjelasan': 'Abimanyu gugur setelah dikeroyok oleh ksatria utama Kurawa dalam Cakravyuha.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Bagaimana Bima mengalahkan Duryudana?', 'pilihan_a': 'Panah Pasopati', 'pilihan_b': 'Memukul pahanya dengan gada', 'pilihan_c': 'Kuku Pancanaka', 'pilihan_d': 'Mencekiknya', 'jawaban_benar': 'B', 'penjelasan': 'Paha Duryudana adalah satu-satunya bagian tubuhnya yang tidak kebal senjata.'},
        {'level': 4, 'kategori': 'Perang Bharatayuda', 'pertanyaan': 'Pasukan sekutu Pandawa yang gugur di awal perang adalah...', 'pilihan_a': 'Prabu Matswapati dan putra-putranya', 'pilihan_b': 'Prabu Drupada', 'pilihan_c': 'Punakawan', 'pilihan_d': 'Kresna', 'jawaban_benar': 'A', 'penjelasan': 'Raja Wirata (Matswapati) kehilangan putra-putranya seperti Utara, Seta, dan Wratsangka.'},

        // LEVEL 5
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Kisah Pandawa yang sabar menghadapi Kurawa mengajarkan bahwa...', 'pilihan_a': 'Orang lemah pasti kalah', 'pilihan_b': 'Kesabaran sejati adalah menunggu waktu yang tepat untuk menegakkan kebenaran', 'pilihan_c': 'Kekerasan adalah satu-satunya solusi', 'pilihan_d': 'Diam itu emas', 'jawaban_benar': 'B', 'penjelasan': 'Kesabaran Pandawa adalah kekuatan untuk bertahan hingga saatnya menegakkan Dharma.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Karna memihak Kurawa meski tahu Pandawa benar. Ini mengajarkan tragedi...', 'pilihan_a': 'Kesetiaan pada kawan yang salah bisa berujung pada kebinasaan mulia', 'pilihan_b': 'Kekuatan adalah segalanya', 'pilihan_c': 'Jangan percaya keluarga', 'pilihan_d': 'Orang baik selalu menang', 'jawaban_benar': 'A', 'penjelasan': 'Karna setia pada Duryudana yang menolongnya saat dibuang, meski ia tahu berada di pihak yang salah.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Kisah Sengkuni mengajarkan bahwa...', 'pilihan_a': 'Kecerdasan selalu membawa sukses', 'pilihan_b': 'Kecerdasan yang digunakan untuk licik hanya membawa kehancuran', 'pilihan_c': 'Politik itu kotor', 'pilihan_d': 'Paman adalah pembimbing terbaik', 'jawaban_benar': 'B', 'penjelasan': 'Semua kelicikan Sengkuni akhirnya menghancurkan keluarga Kurawa dan dirinya sendiri.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Pelajaran dari tokoh Semar adalah...', 'pilihan_a': 'Kekuatan fisik itu penting', 'pilihan_b': 'Kerendahan hati sejati — yang mulia tidak perlu terlihat mulia', 'pilihan_c': 'Pengabdian untuk raja', 'pilihan_d': 'Lucu itu penting', 'jawaban_benar': 'B', 'penjelasan': 'Semar adalah dewa agung namun berwujud abdi yang jelek, melambangkan kerendahan hati mutlak.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Sumpah Bisma mengajarkan...', 'pilihan_a': 'Pengorbanan pribadi demi janji yang lebih besar', 'pilihan_b': 'Jangan pernah berjanji', 'pilihan_c': 'Kesetiaan buta', 'pilihan_d': 'Kekuatan membujang', 'jawaban_benar': 'A', 'penjelasan': 'Bisma rela berkorban segalanya demi kebahagiaan ayahnya dan kesejahteraan Hastinapura.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Setelah perang, Yudistira dinobatkan menjadi raja bergelar...', 'pilihan_a': 'Prabu Dharmaputra', 'pilihan_b': 'Prabu Kalimataya', 'pilihan_c': 'Prabu Puntadewa Agung', 'pilihan_d': 'Prabu Bharata', 'jawaban_benar': 'B', 'penjelasan': 'Ia bergelar Prabu Kalimataya (atau Prabu Dharmaputra/Yudistira di Hastina).'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Lakon "Pandawa Seda" menceritakan akhir kisah Pandawa yang...', 'pilihan_a': 'Bertapa di Indraprastha', 'pilihan_b': 'Mendaki Gunung Himalaya menuju surga', 'pilihan_c': 'Pindah ke Dwarawati', 'pilihan_d': 'Mengasingkan diri', 'jawaban_benar': 'B', 'penjelasan': 'Pandawa menyerahkan takhta lalu mendaki Himalaya hingga satu per satu wafat.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Secara utuh, Bharatayuda mengajarkan bahwa...', 'pilihan_a': 'Perang menyelesaikan masalah', 'pilihan_b': 'Kemenangan sejati dibayar mahal dan perang selalu membawa kehancuran', 'pilihan_c': 'Yang kuat selalu menang', 'pilihan_d': 'Keadilan datang sendiri', 'jawaban_benar': 'B', 'penjelasan': 'Pandawa menang namun kehilangan seluruh putra dan kerabat mereka.'},
        {'level': 5, 'kategori': 'Filosofi & Nilai Moral', 'pertanyaan': 'Pengorbanan Gatotkaca mengajarkan...', 'pilihan_a': 'Kepatuhan mutlak', 'pilihan_b': 'Pengorbanan jiwa demi melindungi orang yang dicintai adalah kemuliaan ksatria', 'pilihan_c': 'Kesaktian itu percuma', 'pilihan_d': 'Tragedi kematian', 'jawaban_benar': 'B', 'penjelasan': 'Gatotkaca mengorbankan dirinya agar Arjuna selamat dari panah Kunta milik Karna.'},
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
        {'nama_parwa': 'Adiparwa', 'nama_babak': 'Lahirnya Pandawa dan Kurawa', 'isi_narasi': 'Lahirnya 5 Pandawa dan 99 Kurawa beserta 1 putri. Persaingan benih dendam dimulai sejak usia muda mereka di keraton Hastinapura.', 'parwa_id': 1, 'urutan': 1},
        {'nama_parwa': 'Sabhaparwa', 'nama_babak': 'Permainan Dadu', 'isi_narasi': 'Duryudana mengundang Yudistira untuk bermain dadu. Lewat kelicikan Sengkuni, Yudistira kehilangan segalanya termasuk kerajaannya dan Drupadi dipermalukan oleh Dursasana.', 'parwa_id': 2, 'urutan': 2},
        {'nama_parwa': 'Wanaparwa & Wirataparwa', 'nama_babak': 'Masa Pengasingan', 'isi_narasi': 'Pandawa menjalani hukuman buang 12 tahun di hutan dan 1 tahun masa penyamaran di Kerajaan Wirata. Di sini mereka mengasah kesabaran dan memperkuat sekutu.', 'parwa_id': 3, 'urutan': 3},
        {'nama_parwa': 'Bhismaparwa - Salyaparwa', 'nama_babak': 'Perang Bharatayuda', 'isi_narasi': 'Pertempuran puncak 18 hari di Kurusetra. Semua tokoh besar seperti Bisma, Drona, Karna, Gatotkaca, dan Abimanyu gugur satu per satu demi membela dharma dan sumpah.', 'parwa_id': 4, 'urutan': 4},
        {'nama_parwa': 'Swargarohanaparwa', 'nama_babak': 'Pandawa Seda', 'isi_narasi': 'Setelah bertahta selama puluhan tahun, Pandawa mewariskan tahta ke Parikesit. Mereka mendaki Himalaya menuju surga sebagai akhir dari siklus kehidupan fana mereka.', 'parwa_id': 5, 'urutan': 5},
      ];
      for (var s in seratList) {
        await db.insert('serat_mahabharata', s);
      }
    }
  }

  static Future<void> _seedFaq(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM faq_mahabharata'));
    if (count == 0) {
      final List<Map<String, dynamic>> faqList = [
        {'pertanyaan': 'Apakah Mahabharata itu sebenarnya?', 'jawaban': 'Mahabharata adalah epik besar dari India tentang perang saudara keluarga Kuru yang diadaptasi menjadi lakon pewayangan Jawa', 'urutan': 1},
        {'pertanyaan': 'Siapa tokoh utama dalam kisah ini?', 'jawaban': 'Pandawa (5 bersaudara) dan Kurawa (99 bersaudara) adalah dua kubu utama dalam kisah ini', 'urutan': 2},
        {'pertanyaan': 'Mengapa Pandawa dan Kurawa berperang?', 'jawaban': 'Kurawa tidak mau membagi kerajaan dengan Pandawa, meskipun secara hukum Pandawa berhak atas setengah kerajaan', 'urutan': 3},
        {'pertanyaan': 'Siapa Kresna dan mengapa perannya penting?', 'jawaban': 'Kresna (titisan Batara Wisnu) adalah penasihat utama Pandawa dan penyampai ajaran dharma kepada Janaka', 'urutan': 4},
        {'pertanyaan': 'Berapa lama perang Bharatayuda berlangsung?', 'jawaban': 'Perang berlangsung selama 18 hari penuh di medan Kurusetra', 'urutan': 5},
        {'pertanyaan': 'Bagaimana akhir dari kisah Mahabharata?', 'jawaban': 'Pandawa menang namun kehilangan banyak sekutu. Yudistira menjadi raja, lalu Pandawa mendaki Himalaya (Pandawa Seda)', 'urutan': 6},
        {'pertanyaan': 'Apa bedanya versi Wayang Jawa dengan Mahabharata India?', 'jawaban': 'Di versi Jawa ada Punakawan (Semar, Gareng, Petruk) dan Drupadi hanya istri Puntadewa seorang', 'urutan': 7},
        {'pertanyaan': 'Siapa Semar dan mengapa ia begitu penting?', 'jawaban': 'Semar adalah Batara Ismaya (dewa) yang turun ke bumi menjadi abdi Pandawa — tokoh paling sakti namun paling rendah hati', 'urutan': 8},
        {'pertanyaan': 'Apa itu lakon dalam pewayangan?', 'jawaban': 'Lakon adalah nama untuk setiap cerita/episode yang dimainkan oleh dalang dalam satu malam pertunjukan', 'urutan': 9},
        {'pertanyaan': 'Apakah kisah Mahabharata masih relevan hari ini?', 'jawaban': 'Ya — nilai-nilai Dharma, Karma, dan pengorbanan dalam Mahabharata sangat relevan untuk kehidupan sehari-hari', 'urutan': 10},
      ];
      for (var f in faqList) {
        await db.insert('faq_mahabharata', f);
      }
    }
  }
}
