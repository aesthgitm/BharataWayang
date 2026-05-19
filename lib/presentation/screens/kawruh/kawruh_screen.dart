import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

import '../../../providers/koleksi_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/repositories/wayang_repository.dart';
import '../pengaturan/pengaturan_screen.dart';
import '../../widgets/main_shell.dart';
import 'pengertian_wayang_screen.dart';
import 'sejarah_wayang_screen.dart';
import 'jenis_wayang_screen.dart';
import 'unsur_pertunjukan_screen.dart';
import 'mengapa_mahabharata_screen.dart';

class KawruhScreen extends StatefulWidget {
  const KawruhScreen({super.key});

  @override
  State<KawruhScreen> createState() => _KawruhScreenState();
}

class _KawruhScreenState extends State<KawruhScreen> {
  bool _readApaItuWayang = false;
  bool _readSejarah = false;
  bool _readJenis = false;
  bool _readUnsur = false;
  bool _readMengapa = false;
  bool _allMateriUnlocked = false;
  bool _isUnlocking = false;

  bool get _allRead => _readApaItuWayang && _readSejarah && _readJenis && _readUnsur && _readMengapa;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _readApaItuWayang = prefs.getBool('read_materi_1_$userId') ?? false;
      _readSejarah = prefs.getBool('read_materi_2_$userId') ?? false;
      _readJenis = prefs.getBool('read_materi_3_$userId') ?? false;
      _readUnsur = prefs.getBool('read_materi_4_$userId') ?? false;
      _readMengapa = prefs.getBool('read_materi_5_$userId') ?? false;
      _allMateriUnlocked = prefs.getBool('all_materi_unlocked_$userId') ?? false;
    });
  }

  Future<void> _markRead(String baseKey) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${baseKey}_$userId', true);
    await _loadProgress();
  }

  Future<void> _unlock10Cards() async {
    setState(() => _isUnlocking = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final koleksiProvider = Provider.of<KoleksiProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;
    
    if (userId != null) {
      final repo = WayangRepository();
      final idsToUnlock = [4, 5, 9, 11, 13, 15, 16, 18, 19, 20];
      for (final id in idsToUnlock) {
        if (!koleksiProvider.isKartuUnlocked(id)) {
          await repo.unlockKartu(userId, id);
        }
      }
      await koleksiProvider.loadData(userId);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('all_materi_unlocked_$userId', true);
      
      if (mounted) {
        setState(() {
          _allMateriUnlocked = true;
          _isUnlocking = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selamat! 10 Kartu Mustika Ksatria telah terbuka di koleksimu!',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.secondary),
            ),
            backgroundColor: AppColors.accent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      if (mounted) {
        setState(() => _isUnlocking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PengaturanScreen()),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textDark, width: 1.5),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.textDark,
                  size: 20,
                ),
              ),
            ),
            Text(
              'PENGENALAN WAYANG',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0, bottom: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'KAWRUH WAYANG',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PENGENALAN WAYANG BAGI KSATRIA MUDA',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Decorative Line using custom divider
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
              ),
              const SizedBox(height: 24),
              Text(
                'Pusat pengetahuan dan pedoman\npewayangan. Eksplorasi filosofi, sejarah,\ndan tata cara seni tradisi agung Nusantara.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDark.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Menu Cards
              _buildKawruhCard(
                context: context,
                title: 'APA ITU WAYANG?',
                onTap: () {
                  _markRead('read_materi_1');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PengertianWayangScreen()));
                },
                isRead: _readApaItuWayang,
              ),
              const SizedBox(height: 16),
              _buildKawruhCard(
                context: context,
                title: 'SEJARAH WAYANG',
                onTap: () {
                  _markRead('read_materi_2');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SejarahWayangScreen()));
                },
                isRead: _readSejarah,
              ),
              const SizedBox(height: 16),
              _buildKawruhCard(
                context: context,
                title: 'JENIS-JENIS WAYANG',
                onTap: () {
                  _markRead('read_materi_3');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const JenisWayangScreen()));
                },
                isRead: _readJenis,
              ),
              const SizedBox(height: 16),
              _buildKawruhCard(
                context: context,
                title: 'UNSUR PERTUNJUKAN',
                onTap: () {
                  _markRead('read_materi_4');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UnsurPertunjukanScreen()));
                },
                isRead: _readUnsur,
              ),
              const SizedBox(height: 16),
              _buildKawruhCard(
                context: context,
                title: 'MENGAPA MAHABHARATA?',
                onTap: () {
                  _markRead('read_materi_5');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MengapaMahabharataScreen()));
                },
                isRead: _readMengapa,
              ),
              
              if (_allRead && !_allMateriUnlocked) ...[
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.accent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PENCAPAIAN DIBUKA!',
                        style: AppTypography.headingMedium.copyWith(
                          color: AppColors.accent,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Anda telah membaca seluruh materi dasar pewayangan. Terimalah 10 Mustika Ksatria sebagai bekal perjalanan Anda!',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.secondary.withValues(alpha: 0.8),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isUnlocking ? null : _unlock10Cards,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: _isUnlocking
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'TELAH BACA SEMUA MATERI',
                                  style: AppTypography.headingSmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKawruhCard({required BuildContext context, required String title, required VoidCallback onTap, bool isRead = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image Overlay
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/images/ui/digital_gunungan_nobg.png', // Fallback
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            // Gradient Overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accent, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ENSIKLOPEDIA',
                          style: AppTypography.labelText.copyWith(
                            color: AppColors.accent,
                            fontSize: 8,
                            letterSpacing: 1,
                          ),
                        ),
                        if (isRead) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.check_circle, color: AppColors.accent, size: 12),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: AppTypography.headingMedium.copyWith(
                      color: AppColors.secondary,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
