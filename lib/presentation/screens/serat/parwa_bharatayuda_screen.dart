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

class ParwaBharatayudaScreen extends StatefulWidget {
  const ParwaBharatayudaScreen({super.key});

  @override
  State<ParwaBharatayudaScreen> createState() => _ParwaBharatayudaScreenState();
}

class _ParwaBharatayudaScreenState extends State<ParwaBharatayudaScreen> {
  static const int _parwaId = 5;
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
        nama: 'Sri Kresna',
        rarity: 'Legendaris',
        imageAsset: 'assets/wayang/sri_kresna.webp',
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
                                kartu.rarity ?? 'Legendaris',
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
    await koleksiProvider.unlockKartu(userId, 1);

    if (mounted) {
      setState(() => _sudahSelesai = true);
      _showUnlockDialog(context, 1);
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
                'PARWA V',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'BHARATAYUDA',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PUNCAK MAHABHARATA',
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
                'Pandawa berusaha mencari sekutu dan ia mendapat bantuan pasukan dari Kerajaan Kerajaan Kekaya, Kerajaan Matsya, Kerajaan Pandya, Kerajaan Chola, Kerajaan Kerala, Kerajaan Magadha, Wangsa Yadawa, Kerajaan Dwaraka, dan masih banyak lagi. Selain itu para ksatria besar di Bharatawarsha seperti misalnya Drupada, Setyaki, Drestadjumna, Srikandi, dan lain-lain ikut memihak Pandawa.  Sementara itu Duryudana meminta Bisma untuk memimpin pasukan Kurawa sekaligus mengangkatnya sebagai panglima tertinggi pasukan Kurawa. Kurawa dibantu oleh Resi Dorna dan putranya Aswatama, kakak ipar para Kurawa yaitu Jayadrata, serta guru Krepa, Kertawarma, Salya, Sudaksina, Burisrawa, Bahlika, Sengkuni, Karna, dan masih banyak lagi.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Pertempuran berlangsung selama 18 hari penuh. Dalam pertempuran itu, banyak ksatria yang gugur, seperti misalnya Abimanyu, Durna, Karna, Bisma, Gatotkaca, Irawan, Prabu Matswapati dan puteranya  (Raden Seta, Raden Utara, Raden Wratsangka),  Bhogadatta, Sengkuni,  dan masih banyak lagi.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Hari 1–10: Kepemimpinan Bisma Perang dimulai di medan Kurukshetra dengan Bisma sebagai panglima Kurawa. Ia sangat kuat dan hampir tak terkalahkan karena tidak ingin membunuh Pandawa sepenuh hati. Banyak pasukan Pandawa gugur di fase ini. Akhirnya, atas saran Kresna, Arjuna menggunakan Srikandi (reinkarnasi Amba yang dibenci Bisma) sebagai tameng. Bisma tidak mau melawan Srikandi, sehingga Arjuna berhasil menjatuhkannya dengan banyak panah hingga ia roboh di atas “ranjang panah”.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Hari 11–15: Kepemimpinan Drona Setelah Bisma jatuh, Drona menjadi panglima. Ia menggunakan strategi licik seperti formasi Cakravyuha. Dalam formasi ini, Abimanyu (putra Arjuna) masuk dan bertarung dengan gagah berani, tetapi akhirnya gugur karena dikeroyok secara tidak adil. Kematian Abimanyu membuat Pandawa sangat marah. Untuk mengalahkan Drona, digunakan tipu muslihat: dikabarkan bahwa Aswatama (anak Drona) telah mati. Mendengar itu, Drona kehilangan semangat dan akhirnya terbunuh.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Hari 16–17: Kepemimpinan Karna Karna kemudian menjadi panglima. Ia adalah petarung hebat dan rival utama Arjuna. Pertempuran antara Karna dan Arjuna menjadi salah satu momen paling penting. Saat bertarung, roda kereta Karna terjebak di tanah, dan ia tidak bisa melawan dengan maksimal. Dalam kondisi itu, Arjuna atas perintah Kresna tetap menyerang, dan akhirnya Karna gugur.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Hari 18: Akhir Perang dan Jatuhnya Kurawa. Hari terakhir menjadi penentu. Hampir seluruh pasukan Kurawa telah hancur. Pertempuran terakhir terjadi antara Bima dan Duryudana. Bima melanggar aturan dengan memukul paha Duryudana (bagian yang seharusnya tidak boleh diserang), hingga Duryudana kalah dan sekarat. Dengan jatuhnya Duryudana, perang pun berakhir dan kemenangan berada di pihak Pandawa.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Dampak Setelah Bharatayuda  Perang ini menewaskan hampir seluruh ksatria besar dari kedua pihak, menyisakan hanya sedikit yang hidup. Kemenangan Pandawa dibayar dengan kehilangan besar, termasuk keluarga dan sekutu mereka. Setelah itu, Yudistira menjadi raja, namun hidupnya dipenuhi rasa sedih dan penyesalan. Bharatayuda menunjukkan bahwa meskipun menang, perang tetap membawa kehancuran dan penderitaan bagi semua pihak.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Setelah perang berakhir, Yudistira dinobatkan sebagai Raja Hastinapura bergelar Prabu Kalimataya Setelah memerintah selama beberapa lama, ia menyerahkan tahta kepada cucu Arjuna, yaitu Parikesit. Kemudian, Yudistira bersama Pandawa dan Drupadi  mendaki gunung Himalaya sebagai tujuan akhir perjalanan mereka. Di sana mereka meninggal dan mencapai surga. (Diceritakan dalam kisah Pandawa Seda).',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Parikesit memerintah Kerajaan Kuru dengan adil dan bijaksana. Ia menikahi Madrawati dan memiliki putera bernama Janamejaya. Janamejaya menikahi Wapushtama (Bhamustiman) dan memiliki putera  bernama Satanika. Satanika berputera Aswamedhadatta. Aswamedhadatta dan  keturunannya kemudian memimpin Kerajaan Wangsa Kuru di Hastinapura.',
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
