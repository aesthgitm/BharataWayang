import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/koleksi_provider.dart';
import '../../../data/models/kartu_wayang_model.dart';
import 'dalang_main_screen.dart';
import '../../widgets/main_shell.dart';

class DalangPilihScreen extends StatefulWidget {
  final MainShellState? mainShellState;
  const DalangPilihScreen({super.key, this.mainShellState});

  @override
  State<DalangPilihScreen> createState() => _DalangPilihScreenState();
}

class _DalangPilihScreenState extends State<DalangPilihScreen> {
  final List<KartuWayang> _selectedWayang = [];

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

  void _toggleSelection(KartuWayang kartu) {
    setState(() {
      if (_selectedWayang.any((w) => w.id == kartu.id)) {
        _selectedWayang.removeWhere((w) => w.id == kartu.id);
      } else {
        _selectedWayang.add(kartu);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final koleksiProvider = Provider.of<KoleksiProvider>(context);
    final semuaKartu = koleksiProvider.semuaKartu;

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
          'PANGGUNG DALANG',
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
        child: Column(
          children: [
            // Deskripsi Singkat
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'PILIH KARAKTER DALANG',
                    style: AppTypography.headingLarge.copyWith(
                      color: AppColors.textDark,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih tokoh wayang yang sudah kamu buka (unlocked) untuk dimainkan bersama di panggung kelir pertunjukan digital.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textDark.withValues(alpha: 0.7),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Grid Pilihan
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: semuaKartu.length,
                itemBuilder: (context, index) {
                  final kartu = semuaKartu[index];
                  final isUnlocked = koleksiProvider.isKartuUnlocked(kartu.id);
                  final isSelected = _selectedWayang.any((w) => w.id == kartu.id);

                  return GestureDetector(
                    onTap: () {
                      if (isUnlocked) {
                        _toggleSelection(kartu);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${kartu.nama} masih terkunci! Selesaikan kuis atau baca parwa untuk membukanya.'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      }
                    },
                    child: AnimatedScale(
                      scale: isSelected ? 1.03 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutBack,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accent
                                : isUnlocked
                                    ? AppColors.accent.withValues(alpha: 0.3)
                                    : AppColors.primary.withValues(alpha: 0.5),
                            width: isSelected ? 3.0 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.accent.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Grayscale representation for locked cards
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
                                  opacity: isUnlocked ? (isSelected ? 0.6 : 0.4) : 0.15,
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

                              // Lock icon for locked cards
                              if (!isUnlocked)
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.lock, color: AppColors.accent, size: 24),
                                  ),
                                ),

                              // Selection Checkmark
                              if (isSelected)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.accent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.check, color: AppColors.primary, size: 16),
                                  ),
                                ),

                              // Rarity badge if unlocked
                              if (isUnlocked)
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppColors.accent, width: 0.5),
                                    ),
                                    child: Text(
                                      kartu.rarity ?? 'Umum',
                                      style: AppTypography.labelText.copyWith(
                                        color: AppColors.accent,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                              // Nama & Title at bottom
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        AppColors.primary.withValues(alpha: 0.8),
                                        AppColors.primary,
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        kartu.nama.toUpperCase(),
                                        style: AppTypography.headingSmall.copyWith(
                                          color: isUnlocked ? AppColors.secondary : AppColors.secondary.withValues(alpha: 0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        kartu.afiliasi ?? '',
                                        style: AppTypography.labelText.copyWith(
                                          color: AppColors.accent.withValues(alpha: 0.7),
                                          fontSize: 8,
                                        ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedWayang.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DalangMainScreen(
                      selectedWayang: _selectedWayang,
                      mainShellState: widget.mainShellState,
                    ),
                  ),
                );
              },
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.primary,
              icon: const Icon(Icons.theater_comedy),
              label: Text(
                'MULAI PERTUNJUKAN (${_selectedWayang.length})',
                style: AppTypography.buttonText.copyWith(fontWeight: FontWeight.w700),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
