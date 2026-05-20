import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/narasi_provider.dart';
import '../../widgets/main_shell.dart';
import '../../widgets/profile_image.dart';
import 'parwa_adi_screen.dart';
import 'parwa_sabha_screen.dart';
import 'parwa_wana_screen.dart';
import 'parwa_wirata_screen.dart';
import 'parwa_bharatayuda_screen.dart';
import 'faq_mahabharata_screen.dart';

class SeratScreen extends StatefulWidget {
  const SeratScreen({super.key});

  @override
  State<SeratScreen> createState() => _SeratScreenState();
}

class _SeratScreenState extends State<SeratScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        Provider.of<NarasiProvider>(context, listen: false).loadProgres(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        automaticallyImplyLeading: false, // Custom AppBar layout
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                final mainShell = context
                    .findAncestorStateOfType<MainShellState>();
                if (mainShell != null) {
                  mainShell.setTab(4); // index 4 is PROFIL
                }
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textDark, width: 1.5),
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
              'SERAT MAHABHARATA',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                fontSize: 14,
              ),
            ),
          ],
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
        child: Consumer<NarasiProvider>(
          builder: (context, narasiProvider, child) {
            // Logic status unlock parwa
            final isParwa1Unlocked = true;
            final isParwa2Unlocked = narasiProvider.isBabakSelesai(1);
            final isParwa3Unlocked = narasiProvider.isBabakSelesai(2);
            final isParwa4Unlocked = narasiProvider.isBabakSelesai(3);
            final isParwa5Unlocked = narasiProvider.isBabakSelesai(4);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SERAT\nMAHABHARATA',
                    textAlign: TextAlign.center,
                    style: AppTypography.headingLarge.copyWith(
                      color: AppColors.textDark,
                      letterSpacing: 2,
                      fontSize: 32,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'KISAH MAHABHARATA',
                    style: AppTypography.labelText.copyWith(
                      color: AppColors.accent,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Decorative Line using SVG divider
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
                  const SizedBox(height: 24),

                  Text(
                    'Jelajahi kisah epik pertempuran besar antara Pandawa dan Kurawa melalui lima babak utama pewayangan Nusantara.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textDark.withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Parwa Rows with Indicators
                  _buildParwaRow(
                    context,
                    title: 'PARWA I',
                    subtitle: 'ADI PARWA',
                    description:
                        'Awal mula garis keturunan Bharata, kelahiran Pandawa dan Kurawa, serta masa muda mereka yang penuh intrik di istana Hastinapura.',
                    isUnlocked: isParwa1Unlocked,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ParwaAdiScreen()),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildParwaRow(
                    context,
                    title: 'PARWA II',
                    subtitle: 'SABHA PARWA',
                    description:
                        'Kisah pertemuan di balairung Hastinapura, permainan dadu yang curang oleh Kurawa, dan penghinaan terhadap Dropadi yang memicu sumpah perang.',
                    isUnlocked: isParwa2Unlocked,
                    lockMessage:
                        'SELESAIKAN BABAK 1 TERLEBIH DAHULU\nUNTUK MEMBUKA KISAH BABAK 2',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ParwaSabhaScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildParwaRow(
                    context,
                    title: 'PARWA III',
                    subtitle: 'WANA PARWA',
                    description:
                        'Perjalanan pengasingan Pandawa di hutan Kamyaka dan Dwaitawana selama dua belas tahun, penuh ujian spiritual dan perolehan senjata sakti.',
                    isUnlocked: isParwa3Unlocked,
                    lockMessage:
                        'SELESAIKAN BABAK 2 TERLEBIH DAHULU\nUNTUK MEMBUKA KISAH BABAK 3',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ParwaWanaScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildParwaRow(
                    context,
                    title: 'PARWA IV',
                    subtitle: 'WIRATA PARWA',
                    description:
                        'Penyamaran Pandawa di Kerajaan Wirata pada tahun ketiga belas, menghadapi ancaman pembongkaran identitas sebelum masa pengasingan berakhir.',
                    isUnlocked: isParwa4Unlocked,
                    lockMessage:
                        'SELESAIKAN BABAK 3 TERLEBIH DAHULU\nUNTUK MEMBUKA KISAH BABAK 4',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ParwaWirataScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildParwaRow(
                    context,
                    title: 'PARWA V',
                    subtitle: 'BHARATAYUDA',
                    description:
                        'Puncak konflik pertempuran dahsyat 18 hari di Kurusetra antara Pandawa dan Kurawa demi menegakkan darma di bumi.',
                    isUnlocked: isParwa5Unlocked,
                    lockMessage:
                        'SELESAIKAN BABAK 4 TERLEBIH DAHULU\nUNTUK MEMBUKA KISAH BABAK 5',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ParwaBharatayudaScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // FAQ Row
                  _buildFaqRow(context),

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
                  const SizedBox(
                    height: 100,
                  ), // Padding bottom for floating navigation
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildParwaRow(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required bool isUnlocked,
    String? lockMessage,
    required VoidCallback onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left timeline dot indicator
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isUnlocked
                ? AppColors.accent
                : AppColors.accent.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        // Card content
        Expanded(
          child: GestureDetector(
            onTap: isUnlocked
                ? onTap
                : () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          lockMessage ?? 'Parwa ini masih terkunci!',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
            child: Container(
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.white : AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent,
                  width: 1.5,
                ), // Gold border for BOTH locked and unlocked cards
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: isUnlocked
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.labelText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textDark.withValues(alpha: 0.8),
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/icon_padlock_serat.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          lockMessage ?? '',
                          textAlign: TextAlign.center,
                          style: AppTypography.labelText.copyWith(
                            fontFamily: 'Cinzel',
                            color: AppColors.secondary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // FAQ indicator dot
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        // FAQ Card
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FaqMahabharataScreen()),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PERTANYAAN SEPUTAR\nMAHABHARATA',
                    style: AppTypography.headingMedium.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
