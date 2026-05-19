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

class ParwaWirataScreen extends StatefulWidget {
  const ParwaWirataScreen({super.key});

  @override
  State<ParwaWirataScreen> createState() => _ParwaWirataScreenState();
}

class _ParwaWirataScreenState extends State<ParwaWirataScreen> {
  static const int _parwaId = 4;
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
        nama: 'Gatotkaca',
        rarity: 'Langka',
        imageAsset: 'assets/wayang/gatotkaca.webp',
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
                                kartu.rarity ?? 'Langka',
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
    await koleksiProvider.unlockKartu(userId, 7);

    if (mounted) {
      setState(() => _sudahSelesai = true);
      _showUnlockDialog(context, 7);
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
                'PARWA IV',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'WIRATA PARWA',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PELECEHAN YANG MEMULAI PERANG',
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
                'Untuk merebut kekayaan dan kerajaan Yudistira, Duryudana mengundang Yudistira untuk bermain permainan dadu, ini atas ide dari Arya Sengkuni. Pada saat permainan dadu, Duryudana diwakili oleh Sengkuni sebagai bandar dadu yang memiliki kesaktian untuk berbuat curang.  Permulaan permainan taruhan senjata perang, taruhan pemainan terus  meningkat menjadi taruhan harta kerajaan, selanjutnya prajurit  dipertaruhkan, dan sampai pada puncak permainan Kerajaan menjadi  taruhan, Pandawa kalah habislah semua harta dan kerajaan Pandawa  termasuk saudara juga dipertaruhkan dan yang terakhir istrinya Drupadi  dijadikan taruhan. Akhirnya Yudistira kalah dan Drupadi diminta untuk hadir di arena judi  karena sudah menjadi milik Duryudana.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Duryudana mengutus para  pengawalnya untuk menjemput Drupadi, namun Drupadi menolak. Setelah  gagal, Duryudana menyuruh Dursasana adiknya, untuk menjemput Drupadi. Drupadi yang menolak untuk datang,  diseret oleh Dursasana yang tidak memiliki rasa kemanusiaan. Rambutnya  ditarik sampai ke arena judi, tempat suami dan para iparnya berkumpul.  Karena sudah kalah, Yudistira dan seluruh adiknya diminta untuk  menanggalkan bajunya, namun Drupadi menolak. Dursasana yang berwatak  kasar, menarik kain yang dipakai Drupadi, namun kain tersebut  terulur-ulur terus dan tak habis-habis karena mendapat kekuatan gaib  dari Sri Kresna yang melihat Dropadi dalam bahaya. Pertolongan Sri Kresna disebabkan  karena perbuatan Dropadi yang membalut luka Sri Kresna pada saat upacara  Rajasuya di Indraprastha.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Drupadi yang merasa malu dan tersinggung oleh sikap Dursasana bersumpah tidak akan menggelung rambutnya sebelum dikramasi dengan darah Dursasana. Bima pun bersumpah akan membunuh Dursasana dan meminum darahnya kelak. Setelah mengucapkan sumpah tersebut, Drestarastra merasa bahwa malapetaka akan menimpa keturunannya, maka ia mengembalikan segala harta Yudistira yang dijadikan taruhan.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Duryudana yang merasa kecewa karena Drestarastra telah mengembalikan semua harta yang sebenarnya akan menjadi miliknya,  menyelenggarakan permainan dadu untuk yang kedua kalinya. Kali ini,  siapa yang kalah harus mengasingkan diri ke hutan selama 12 tahun,  setelah itu hidup dalam masa penyamaran selama setahun, dan setelah itu  berhak kembali lagi ke kerajaannya. Untuk yang kedua kalinya, Yudistira mengikuti permainan tersebut dan sekali lagi ia kalah. Karena kekalahan tersebut, Pandawa terpaksa meninggalkan kerajaan mereka selama 12 tahun dan hidup dalam masa penyamaran selama setahun.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Setelah masa pengasingan habis dan sesuai dengan perjanjian yang sah, Pandawa berhak untuk mengambil alih kembali kerajaan yang dipimpin Duryudana. Namun Duryudana bersifat jahat. Ia tidak mau menyerahkan kerajaan kepada Pandawa, walau seluas ujung jarum pun. Hal itu membuat kesabaran Pandawa habis. Misi damai dilakukan oleh Sri Kresna, namun berkali-kali gagal. Akhirnya, pertempuran tidak dapat dielakkan lagi.',
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
