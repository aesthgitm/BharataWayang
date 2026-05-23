import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/koleksi_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/models/kartu_wayang_model.dart';
import '../../widgets/main_shell.dart';
import '../../widgets/profile_image.dart';
import 'profil_ksatria_screen.dart';

class MustikaScreen extends StatefulWidget {
  const MustikaScreen({super.key});

  @override
  State<MustikaScreen> createState() => _MustikaScreenState();
}

class _MustikaScreenState extends State<MustikaScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer2<KoleksiProvider, AuthProvider>(
      builder: (context, koleksiProvider, authProvider, child) {
        final allKartu = koleksiProvider.semuaKartu;
        final isLoading = koleksiProvider.isLoading;

        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    final mainShell = context.findAncestorStateOfType<MainShellState>();
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
                        fotoProfil: authProvider.currentUser?.fotoProfil,
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
                  'MUSTIKA KSATRIA',
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Column(
                    children: [
                      Text(
                        'MUSTIKA KSATRIA',
                        style: AppTypography.headingLarge.copyWith(
                          color: AppColors.textDark,
                          letterSpacing: 2,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'KOLEKSI BERBAGAI KARTU TOKOH WAYANG',
                        style: AppTypography.labelText.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 1,
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
                      const SizedBox(height: 12),
                      // Koleksi counter
                      if (!isLoading && allKartu.isNotEmpty)
                        Text(
                          'Koleksi: ${koleksiProvider.koleksiUser.length} / ${allKartu.length} Kartu Terbuka',
                          style: AppTypography.bodySmall.copyWith(
                            fontFamily: 'Cinzel',
                            color: AppColors.textDark.withValues(alpha: 0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),

                isLoading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: AppColors.accent),
                        ),
                      )
                    : allKartu.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'Koleksi kartu belum tersedia.\nCoba jalankan ulang aplikasi.',
                                textAlign: TextAlign.center,
                                style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
                              ),
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: allKartu.length,
                              itemBuilder: (context, index) {
                                final kartu = allKartu[index];
                                final isUnlocked = koleksiProvider.isKartuUnlocked(kartu.id);
                                return _buildKartuCard(context, kartu, isUnlocked)
                                    .animate()
                                    .fade(delay: (index * 80).ms, duration: 400.ms)
                                    .slideY(begin: 0.15, end: 0.0, curve: Curves.easeOutBack);
                              },
                            ),
                          ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildKartuCard(BuildContext context, KartuWayang kartu, bool isUnlocked) {
    return GestureDetector(
      onTap: () {
        if (isUnlocked) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProfilKsatriaScreen(kartu: kartu),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kartu ${kartu.nama} belum terbuka. Raih skor ${kartu.unlockSkorMin ?? 70}+ di kuis untuk membukanya!'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      child: Hero(
        tag: 'hero_mustika_${kartu.id}',
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isUnlocked ? AppColors.accent : AppColors.primary.withValues(alpha: 0.5),
                width: isUnlocked ? 2 : 1,
              ),
              boxShadow: isUnlocked
                  ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))]
                  : null,
            ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              ColorFiltered(
                colorFilter: isUnlocked
                    ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                    : const ColorFilter.matrix([
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0,      0,      0,      1, 0,
                      ]),
                child: Opacity(
                  opacity: isUnlocked ? 0.9 : 0.05,
                  child: Image.asset(
                    kartu.imageAsset ?? 'assets/images/ui/digital_gunungan_nobg.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/ui/digital_gunungan_nobg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Lock icon if locked
              if (!isUnlocked)
                Center(
                  child: Image.asset(
                    'assets/icons/icon_padlock_serat.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),

              // Name & title at bottom
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? AppColors.dark.withValues(alpha: 0.9)
                        : AppColors.primary.withValues(alpha: 0.9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isUnlocked)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.accent, width: 0.5),
                          ),
                          child: Text(
                            (kartu.rarity ?? 'COMMON').toUpperCase(),
                            style: AppTypography.labelText.copyWith(
                              color: AppColors.accent,
                              fontSize: 8,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      Text(
                        isUnlocked ? kartu.nama.toUpperCase() : '???',
                        style: AppTypography.headingSmall.copyWith(
                          color: isUnlocked ? AppColors.secondary : AppColors.secondary.withValues(alpha: 0.5),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isUnlocked ? (kartu.afiliasi ?? '') : 'Terkunci',
                        style: AppTypography.bodySmall.copyWith(
                          color: isUnlocked ? AppColors.accent : AppColors.accent.withValues(alpha: 0.5),
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }
}
