import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/koleksi_provider.dart';
import '../../../../data/models/kartu_wayang_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../dalang/dalang_pilih_screen.dart';
import '../kuis/kuis_home_screen.dart';
import '../mustika/profil_ksatria_screen.dart';
import '../pengaturan/pengaturan_screen.dart';
import '../../widgets/main_shell.dart';
import '../../widgets/profile_image.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        Provider.of<KoleksiProvider>(context, listen: false).loadData(userId);
      }
    });
  }

  int _getRarityPriority(String? rarity) {
    switch (rarity?.toLowerCase()) {
      case 'legendaris':
        return 1;
      case 'langka':
        return 2;
      case 'umum':
        return 3;
      default:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final userName = user?.namaLengkap ?? user?.username ?? "BIMA";

    final koleksiProvider = context.watch<KoleksiProvider>();
    final allKartu = koleksiProvider.semuaKartu;

    // Filter kartu yang sudah di-unlock oleh user
    final unlockedKartu = allKartu
        .where((k) => koleksiProvider.isKartuUnlocked(k.id))
        .toList();

    // Urutkan kartu berdasarkan rarity (Legendaris -> Langka -> Umum)
    unlockedKartu.sort(
      (a, b) =>
          _getRarityPriority(a.rarity).compareTo(_getRarityPriority(b.rarity)),
    );

    // Ambil maksimal 5 kartu teratas
    final displayKartu = unlockedKartu.take(5).toList();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16.0,
            bottom: 100.0,
          ), // Padding bottom for bottom nav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header/AppBar Area
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      final mainShell = context
                          .findAncestorStateOfType<MainShellState>();
                      if (mainShell != null) {
                        mainShell.setTab(4); // index 4 is PROFIL
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PengaturanScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.textDark,
                          width: 1.5,
                        ),
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: ProfileImage(
                          fotoProfil: user?.fotoProfil,
                          size: 32,
                          fit: BoxFit.cover,
                          placeholder: const Icon(
                            Icons.person_outline,
                            color: AppColors.textDark,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'BHARATAWAYANG',
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Divider tipis di bawah header
              Container(
                height: 1,
                color: AppColors.accent.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 24),

              // Welcome Text
              Text(
                'SUGENG RAWUH,',
                style: AppTypography.headingMedium.copyWith(
                  color: AppColors.textDark,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                userName.toUpperCase(),
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.accent,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sasana Utama • Jelajahi Wayang dan Kisah Epik',
                style: AppTypography.bodyMedium.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textDark.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 32),

              // Simulasi Dalang Digital Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/ui/wayang_simulasi.jpg',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FITUR UTAMA',
                      style: AppTypography.labelText.copyWith(
                        color: AppColors.accent,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'SIMULASI DALANG\nDIGITAL.',
                      style: AppTypography.headingMedium.copyWith(
                        color: AppColors.secondary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Mainkan lakon wayang\npilihanmu dalam ruang\npertunjukan virtual yang\nsakral.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.secondary.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        final mainShell = context.findAncestorStateOfType<MainShellState>();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DalangPilihScreen(mainShellState: mainShell),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Mulai Simulasi',
                            style: AppTypography.buttonText.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.play_arrow, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Mustika Wayang Section
              _buildSectionTitle('MUSTIKA WAYANG'),
              const SizedBox(height: 16),
              koleksiProvider.isLoading
                  ? const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                        ),
                      ),
                    )
                  : displayKartu.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            color: AppColors.accent,
                            size: 36,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada Mustika Wayang terbuka',
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mainkan kuis dengan skor ≥ 70 untuk membuka karakter wayang pertamamu!',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: displayKartu.length,
                        itemBuilder: (context, index) {
                          return _buildMustikaCard(
                            displayKartu[index],
                            context,
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 40),

              // Kuis Interaktif Section
              _buildSectionTitle('KUIS INTERAKTIF'),
              const SizedBox(height: 16),

              // Kuis Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/icon_kuis.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'KUIS INTERAKTIF',
                      style: AppTypography.headingSmall.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Uji sejauh mana pengetahuanmu tentang Wayang dan Lakon Mahabharata?',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textDark.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const KuisHomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'MULAI KUIS',
                        style: AppTypography.buttonText.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Pustaka Ulasan Card
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Left brown badge
                      Container(
                        width: 50,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF9E7E47,
                          ), // Goldish brown badge color
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/icon_pustaka_ulasan.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Center text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pustaka Ulasan',
                              style: AppTypography.headingSmall.copyWith(
                                color: AppColors.textDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Bagikan pengalamanmu untuk membantu kami melestarikan budaya adiluhung.',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textDark.withValues(
                                  alpha: 0.7,
                                ),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Right circular chevron button
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.3),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
              // Bottom decorative heart/ornament
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/ui/divider.svg',
                    width: 300,
                    height: 12,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textDark,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildMustikaCard(KartuWayang kartu, BuildContext context) {
    // Tentukan nama singkat, julukan, dan deskripsi singkat berdasarkan id kartu
    String shortName = kartu.nama;
    if (kartu.id == 3) shortName = "ARJUNA";
    if (kartu.id == 2) shortName = "BIMA";
    if (kartu.id == 1) shortName = "YUDISTIRA";
    if (kartu.id == 6) shortName = "KRESNA";
    if (shortName.contains('(')) {
      final parts = shortName.split('(');
      shortName = parts.last.replaceAll(')', '').trim();
    }

    String julukan = kartu.afiliasi ?? '';
    if (kartu.id == 3) julukan = "Pandawa Penengah";
    if (kartu.id == 2) julukan = "Kekuatan Dahsyat";
    if (kartu.id == 1) julukan = "Raja Kebenaran";
    if (kartu.id == 6) julukan = "Titisan Wisnu";

    String shortDesc = kartu.deskripsi ?? '';
    if (shortDesc.length > 50) {
      shortDesc = '${shortDesc.substring(0, 47)}...';
    }
    if (kartu.id == 3) shortDesc = "Sang pemanah unggul Pandawa";
    if (kartu.id == 2) shortDesc = "Ksatria perkasa pelindung dharma";

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProfilKsatriaScreen(kartu: kartu)),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top dark part
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: kartu.imageAsset != null
                      ? DecorationImage(
                          image: AssetImage(kartu.imageAsset!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.4),
                            BlendMode.darken,
                          ),
                        )
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shortName.toUpperCase(),
                      style: AppTypography.headingSmall.copyWith(
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      julukan,
                      style: AppTypography.labelText.copyWith(
                        color: AppColors.accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom light part
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF6F0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        shortDesc,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDark.withValues(alpha: 0.8),
                          fontSize: 10,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 12,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
