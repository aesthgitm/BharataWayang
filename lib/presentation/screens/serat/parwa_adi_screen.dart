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

class ParwaAdiScreen extends StatefulWidget {
  const ParwaAdiScreen({super.key});

  @override
  State<ParwaAdiScreen> createState() => _ParwaAdiScreenState();
}

class _ParwaAdiScreenState extends State<ParwaAdiScreen> {
  static const int _parwaId = 1;
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
        nama: 'Nakula',
        rarity: 'Umum',
        imageAsset: 'assets/wayang/nakula.webp',
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
    await koleksiProvider.unlockKartu(userId, 8);

    if (mounted) {
      setState(() => _sudahSelesai = true);
      _showUnlockDialog(context, 8);
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
                'PARWA I',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ADI PARWA',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AWAL MULA',
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
                'Dikisahkan pada zaman dahulu kala, dunia masih diselimuti misteri dan keheningan. Kisah Mahabharata diawali dengan  pertemuan Raja Duswanta dengan Sakuntala. Raja Duswanta adalah seorang  raja besar dari Chandrawangsa keturunan Yayati, menikahi Sakuntala dari  pertapaan Bagawan Kanwa, kemudian menurunkan Sang Bharata. Sang Bharata menurunkan Sang Hasti, yang kemudian mendirikan sebuah  pusat pemerintahan bernama Hastinapura. Sang Hasti menurunkan Para Raja  Hastinapura. Dari keluarga tersebut, lahirlah Sang Kuru, yang menguasai  dan menyucikan sebuah daerah luas yang disebut Kurukshetra. Sang Kuru menurunkan Dinasti Kuru  atau Wangsa Kaurawa. Dalam Dinasti tersebut, lahirlah Pratipa, yang  menjadi ayah Prabu Santanu, leluhur Pandawa dan Kurawa.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Prabu Santanu seorang raja mahsyur dari garis keturunan Sang  Kuru, berasal dari Hastinapura. Ia menikah dengan Dewi Gangga yang  dikutuk agar turun ke dunia, namun Dewi Gangga meninggalkannya karena  Sang Prabu melanggar janji pernikahan. Hubungan Sang Prabu dengan Dewi  Gangga sempat membuahkan 7 anak, akan tetapi semua ditenggelamkan ke laut Gangga oleh Dewi Gangga dengan alasan semua sudah terkena kutukan. Akan tetapi kemudian anak ke 8 bisa diselamatkan oleh Prabu Santanu yang diberi nama Dewabrata. Kemudian Dewi Ganggapun pergi meninggalkan Prabu Santanu. Nama Dewabrata diganti menjadi Bisma karena ia melakukan bhishan pratigya yaitu sumpah untuk membujang selamanya dan tidak akan mewarisi tahta  ayahnya. Hal itu dikarenakan Bisma tidak ingin dia dan keturunannya  berselisih dengan keturunan Satyawati, ibu tirinya.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Setelah ditinggal Dewi Gangga, akhirnya Prabu Santanu menjadi duda.  Beberapa tahun kemudian, Prabu Santanu melanjutkan kehidupan berumah  tangga dengan menikahi Dewi Satyawati, puteri nelayan. Dari hubungannya,  Sang Prabu berputera Sang Citranggada dan Wicitrawirya.  Demi kebahagiaan adik-adiknya, Bisma pergi ke Kerajaan Kasi dan memenangkan sayembara sehingga berhasil membawa pulang tiga orang puteri bernama Amba, Ambika, dan Ambalika, untuk dinikahkan kepada adik-adiknya. Karena Citranggada wafat, maka Ambika dan Ambalika menikah dengan Wicitrawirya, sedangkan Amba mencintai Bisma namun Bisma menolak cintanya karena  terikat oleh sumpah bahwa ia tidak akan kawin seumur hidup. Demi usaha  untuk menjauhkan Amba dari dirinya, tanpa sengaja ia menembakkan panah  menembus dada Amba. Atas kematian itu, Bisma diberitahu bahwa kelak Amba  bereinkarnasi menjadi seorang pangeran yang memiliki sifat kewanitaan, yaitu putera Raja Drupada yang bernama Srikandi. (Kalau versi Jawa, Srikandi adalah seorang wanita sejati) Kelak kematiannya juga berada di tangan Srikandi yang membantu Arjuna dalam pertempuran akbar di Kurukshetra.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Citranggada  wafat di usia muda dalam suatu pertempuran, kemudian ia digantikan oleh  adiknya yaitu Wicitrawirya. Wicitrawirya juga wafat di usia muda dan  belum sempat memiliki keturunan.',
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

              // Tombol Selesai Membaca
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
