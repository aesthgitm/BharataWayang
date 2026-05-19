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

class ParwaWanaScreen extends StatefulWidget {
  const ParwaWanaScreen({super.key});

  @override
  State<ParwaWanaScreen> createState() => _ParwaWanaScreenState();
}

class _ParwaWanaScreenState extends State<ParwaWanaScreen> {
  static const int _parwaId = 3;
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
        nama: 'Werkudara',
        rarity: 'Langka',
        imageAsset: 'assets/wayang/werkudara.webp',
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
    await koleksiProvider.unlockKartu(userId, 2);

    if (mounted) {
      setState(() => _sudahSelesai = true);
      _showUnlockDialog(context, 2);
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
                'PARWA III',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'WANA PARWA',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'MEMUNCAKNYA DENDAM PANDAWA',
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
                'Pada suatu ketika, Duryudana mengundang Kunti dan para Pandawa   untuk liburan. Di sana mereka menginap di sebuah rumah yang sudah  disediakan oleh Duryudana. Pada malam hari, rumah itu dibakar. Namun  para Pandawa bisa diselamatkan oleh  Bima yang telah diberitahu oleh Widura akan kelicikan Kurawa sehingga mereka tidak terbakar hidup-hidup dalam rumah tersebut. Usai  menyelamatkan diri, Pandawa dan Kunti masuk hutan. (diceritakan dalam lakon Bale Sigala-gala).',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Di hutan tersebut  Bima bertemu dengan raksasa bernama Arimba yang ingin membalas dendam kematian Ayahnya yaitu Arimbaka (dalam pedalangan Jawa disebut Trembaka), Bima unggul dan membunuhnya, lalu menikahi adiknya, yaitu raseksi Hidimbi atau Arimbi yang jatuh hati pada Bima. Dari pernikahan tersebut, lahirlah Gatotkaca.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Setelah melewati hutan rimba, Pandawa melewati Kerajaan Pancala. Di sana tersiar kabar bahwa Raja Drupada menyelenggarakan sayembara memperebutkan Dewi Drupadi. Adipati Karna mengikuti sayembara tersebut, tetapi ditolak oleh Drupadi. Pandawa pun  turut serta menghadiri sayembara itu, namun mereka berpakaian seperti  kaum brahmana.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Pandawa ikut sayembara untuk memenangkan lima macam sayembara, Yudistira untuk memenangkan sayembara filsafat dan tatanegara, Arjuna memenangkan sayembara senjata Panah, Bima memenangkan sayembara Gada dan Nakula Sadewa memenangkan sayembara senjata Pedang. Pandawa berhasil melakukannya dengan baik untuk memenangkan sayembara.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Drupadi harus menerima Pandawa sebagai suami-suaminya karena sesuai  janjinya siapa yang dapat memenangkan sayembara yang dibuatnya itu akan  jadi suaminya walau menyimpang dari keinginannya yaitu sebenarnya yang  diinginkan hanya seorang Satriya.',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Setelah itu perkelahian terjadi karena para hadirin menggerutu sebab  kaum brahmana tidak selayaknya mengikuti sayembara. Pandawa berkelahi  kemudian meloloskan diri. sesampainya di rumah, mereka berkata kepada  ibunya bahwa mereka datang membawa hasil meminta-minta. Ibu mereka pun  menyuruh agar hasil tersebut dibagi rata untuk seluruh saudaranya.  Namun, betapa terkejutnya ia saat melihat bahwa anak-anaknya tidak hanya  membawa hasil meminta-minta, namun juga seorang wanita. (Dalam Pedalangan Jawa Drupadi hanya menjadi istri Yudistira / Puntadewa seorang).',
              ),
              const SizedBox(height: 16),
              _buildStoryParagraph(
                'Agar tidak terjadi pertempuran sengit, Kerajaan Kuru dibagi dua untuk dibagi kepada Pandawa dan Kurawa. Kurawa memerintah Kerajaan Kuru induk (pusat) dengan ibukota Hastinapura, sementara Pandawa memerintah Kerajaan Kurujanggala dengan ibukota Indraprastha. Baik Hastinapura maupun Indraprastha memiliki istana megah, dan di sanalah Duryudana tercebur ke dalam kolam yang ia kira sebagai lantai, sehingga dirinya menjadi bahan ejekan bagi Drupadi. Hal tersebut membuatnya bertambah marah kepada para Pandawa.',
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
