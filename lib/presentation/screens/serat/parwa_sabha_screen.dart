import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/narasi_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/koleksi_provider.dart';
import '../../../data/models/kartu_wayang_model.dart';

class ParwaSabhaScreen extends StatefulWidget {
  const ParwaSabhaScreen({super.key});

  @override
  State<ParwaSabhaScreen> createState() => _ParwaSabhaScreenState();
}

class _ParwaSabhaScreenState extends State<ParwaSabhaScreen> {
  static const int _parwaId = 2;
  bool _sudahSelesai = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final narasiProvider = Provider.of<NarasiProvider>(
        context,
        listen: false,
      );
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final koleksiProvider = Provider.of<KoleksiProvider>(
        context,
        listen: false,
      );
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        narasiProvider.loadProgres(userId);
        if (koleksiProvider.semuaKartu.isEmpty) {
          koleksiProvider.loadData(userId);
        }
        setState(() {
          _sudahSelesai = narasiProvider.isBabakSelesai(_parwaId);
        });
      }
    });
  }

  void _showUnlockDialog(BuildContext context, int kartuId) {
    final koleksiProvider = Provider.of<KoleksiProvider>(
      context,
      listen: false,
    );
    final kartu = koleksiProvider.semuaKartu.firstWhere(
      (k) => k.id == kartuId,
      orElse: () => KartuWayang(
        id: kartuId,
        nama: 'Sadewa',
        rarity: 'Umum',
        imageAsset: 'assets/wayang/sadewa.webp',
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.secondary,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.diamond_outlined,
                  color: AppColors.accent,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'MUSTIKA TERBUKA!',
                  style: AppTypography.headingLarge.copyWith(
                    color: AppColors.textDark,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Selamat! Kamu telah berhasil membuka kartu tokoh wayang baru karena telah menyelesaikan babak ini.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textDark.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 24),
                // Card Display
                Container(
                  width: 140,
                  height: 190,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            kartu.imageAsset ??
                                'assets/images/ui/digital_gunungan_nobg.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  'assets/images/ui/digital_gunungan_nobg.png',
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                kartu.nama.toUpperCase(),
                                style: AppTypography.headingSmall.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                kartu.rarity ?? 'Umum',
                                style: AppTypography.labelText.copyWith(
                                  color: AppColors.accent,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'TERIMA KASIH',
                      style: AppTypography.buttonText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _tandaiSelesai() async {
    final narasiProvider = Provider.of<NarasiProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final koleksiProvider = Provider.of<KoleksiProvider>(
      context,
      listen: false,
    );
    final userId = authProvider.currentUser?.id;
    if (userId == null) return;

    await narasiProvider.tandaiSelesai(userId, _parwaId);
    await koleksiProvider.unlockKartu(userId, 14);

    if (mounted) {
      setState(() => _sudahSelesai = true);
      _showUnlockDialog(context, 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    final narasiProvider = Provider.of<NarasiProvider>(context);
    final sudahSelesai =
        _sudahSelesai || narasiProvider.isBabakSelesai(_parwaId);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'SERAT MAHABHARATA',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            fontSize: 14,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.accent.withValues(alpha: 0.3),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // White Box with Gunungan Image (Placeholder)
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/ui/digital_gunungan_nobg.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'PARWA II',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'SABHA PARWA',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PERGOLAKAN KONFLIK',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 16),
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppColors.accent,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 32),

              // Content Paragraphs
              _buildStoryParagraph(
                'Satyawati mengirim kedua istri Wicitrawirya, yaitu Ambika dan Ambalika untuk menemui Resi Byasa, sebab Sang Resi dipanggil untuk mengadakan suatu upacara bagi mereka agar memperoleh keturunan.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Satyawati menyuruh Ambika agar menemui Resi Byasa di ruang upacara. Setelah Ambika memasuki ruangan upacara, ia melihat  wajah Sang Resi sangat dahsyat dengan mata yang menyala-nyala. Hal itu  membuatnya menutup mata. Karena Ambika menutup mata selama upacara  berlangsung, maka anaknya terlahir buta. Anak tersebut adalah  Drestarastra. Kemudian Ambalika disuruh oleh Satyawati untuk mengunjungi Byasa ke dalam sebuah kamar sendirian, dan di sana ia  akan diberi anugerah. Ia juga disuruh agar terus membuka matanya supaya  jangan melahirkan putra yang buta Drestarastra seperti yang telah dilakukan Ambika Maka dari itu, Ambalika terus membuka matanya namun ia menjadi pucat setelah melihat rupa Sang Bagawan Byasa yang luar biasa. Maka dari itu, Pandu (putranya), ayah para Pandawa, terlahir pucat. Drestarastra dan Pandu mempunyai saudara tiri yang bernama Widura. Widura merupakan anak dari Resi Byasa dengan seorang dayang Satyawati yang bernama Datri. Pada saat upacara dilangsungkan dia lari keluar kamar dan akhirnya terjatuh sehingga Widura pun lahir dengan kondisi pincang kakinya.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Dikarenakan Drestarastra terlahir buta mata maka tahta Hastinapura diberikan kepada Pandu. Pandu menikahi Dewi Kunti,kemudian Pandu menikah untuk yang kedua kalinya dengan Dewi Madrim,  namun akibat kesalahan Pandu pada saat memanah seekor kijang yang  sedang kasmaran, maka kijang tersebut mengeluarkan kutukan  bahwa Pandu tidak akan merasakan lagi hubungan suami istri, dan bila  dilakukannya, maka Pandu akan mengalami ajal. Kijang tersebut kemudian  mati dengan berubah menjadi wujud aslinya yaitu seorang pendeta. Kemudian karena mengalami kejadian buruk seperti itu, Pandu lalu  mengajak kedua istrinya untuk bermohon kepada Hyang Maha Kuasa agar  dapat diberikan anak.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Atas bantuan mantra yang pernah diberikan oleh Resi Druwasa maka Dewi Kunti bisa memanggil para dewa untuk kemudian mendapatkan putra. Pertama kali mencoba mantra tersebut datanglah Batara Surya, tak lama kemudian Kunti mengandung dan melahirkan seorang anak yang kemudian diberi nama Karna. Tetapi Karna kemudian dilarung kelaut dan dirawat oleh Kurawa, sehingga nanti pada saat perang Bharatayudha, Karna memihak kepada Kurawa.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Kemudian atas permintaan Pandu, Kunti mencoba mantra itu lagi, Batara Guru mengirimkan Batara Dharma untuk  membuahi Dewi Kunti sehingga lahir anak yang pertama yaitu Yudistira, setahun kemudian Batara Bayu dikirim juga untuk membuahi  Dewi Kunti sehingga lahirlah Bima, Batara Guru juga mengutus Batara Indra untuk membuahi Dewi Kunti  sehingga lahirlah Arjuna dan yang terakhir Batara Aswan dan Aswin  dikirimkan untuk membuahi Dewi Madrim, dan lahirlah Nakula dan Sadewa. Kelima putera Pandu tersebut dikenal sebagai Pandawa. Dretarastra yang buta menikahi Dewi Gendari, dan memiliki sembilan puluh sembilan orang putera dan seorang puteri yang dikenal dengan istilah Kurawa.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Pandawa dan Kurawa merupakan dua kelompok dengan sifat yang berbeda namun berasal dari leluhur yang sama, yakni Kuru dan Bharata. Kurawa (khususnya Duryudana)  bersifat licik dan selalu iri hati dengan kelebihan Pandawa, sedangkan  Pandawa bersifat tenang dan selalu bersabar ketika ditindas oleh sepupu  mereka. Ayah para Kurawa, yaitu Drestarastra, sangat menyayangi putera-puteranya. Hal itu membuat ia sering dihasut oleh iparnya yaitu Sengkuni, beserta putera kesayangannya yaitu Duryudana, agar mau mengizinkannya melakukan rencana jahat menyingkirkan para Pandawa.',
              ),

              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppColors.accent,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: sudahSelesai ? null : _tandaiSelesai,
                  icon: Icon(
                    sudahSelesai ? Icons.check_circle : Icons.book_outlined,
                    size: 18,
                  ),
                  label: Text(
                    sudahSelesai ? 'SUDAH DIBACA ✓' : 'SELESAI MEMBACA',
                    style: AppTypography.buttonText.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sudahSelesai
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : AppColors.accent,
                    foregroundColor: sudahSelesai
                        ? AppColors.accent
                        : AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: AppTypography.bodyLarge.copyWith(
        color: AppColors.textDark.withValues(alpha: 0.8),
        height: 1.6,
      ),
    );
  }
}
