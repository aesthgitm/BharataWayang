import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/kuis_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/koleksi_provider.dart';
import '../../widgets/main_shell.dart';
import 'kuis_hasil_screen.dart';

class KuisGameScreen extends StatefulWidget {
  final int level;
  const KuisGameScreen({super.key, this.level = 1});

  @override
  State<KuisGameScreen> createState() => _KuisGameScreenState();
}

class _KuisGameScreenState extends State<KuisGameScreen> {
  int _selectedOptionIndex = -1;
  bool _isAnswered = false; // untuk feedback warna setelah jawab
  bool _lastAnswerCorrect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KuisProvider>(context, listen: false).mulaiKuis(widget.level);
    });
  }

  void _jawabSoal(int indexPilihan, String jawabanUser, String jawabanBenar) {
    if (_isAnswered) return; // Prevent double answer
    
    setState(() {
      _selectedOptionIndex = indexPilihan;
      _isAnswered = true;
      _lastAnswerCorrect = jawabanUser == jawabanBenar;
    });

    // Delay lalu ke soal berikutnya
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      final kuisProvider = Provider.of<KuisProvider>(context, listen: false);
      kuisProvider.jawabSoal(jawabanUser);

      if (kuisProvider.isSelesai) {
        _selesaiKuis(kuisProvider);
      } else {
        setState(() {
          _selectedOptionIndex = -1;
          _isAnswered = false;
        });
      }
    });
  }

  void _selesaiKuis(KuisProvider kuisProvider) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;
    // Simpan referensi navigator sebelum async call
    final navigator = Navigator.of(context);

    if (userId != null) {
      // Simpan skor ke DB
      await kuisProvider.simpanSkorAkhir(userId, widget.level);

      // Unlock kartu jika skor cukup (≥70) berdasarkan level
      if (kuisProvider.skor >= 70 && mounted) {
        final koleksiProvider = Provider.of<KoleksiProvider>(context, listen: false);
        int kartuIdToUnlock = 0;
        switch (widget.level) {
          case 1: kartuIdToUnlock = 3; break; // Janaka
          case 2: kartuIdToUnlock = 10; break; // Adipati Karna
          case 3: kartuIdToUnlock = 17; break; // Batara Indra 
          case 4: kartuIdToUnlock = 12; break; // Resi Bisma 
          case 5: kartuIdToUnlock = 6; break; // Sri Kresna 
        }
        
        if (kuisProvider.skor >= 70 && kartuIdToUnlock != 0 && !koleksiProvider.isKartuUnlocked(kartuIdToUnlock)) {
          await koleksiProvider.unlockKartu(userId, kartuIdToUnlock);
        }
      }
    }

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => KuisHasilScreen(score: kuisProvider.skor, level: widget.level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KuisProvider>(
      builder: (context, kuisProvider, child) {
        if (kuisProvider.isLoading) {
          return const Scaffold(
            backgroundColor: AppColors.secondary,
            body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
          );
        }

        if (kuisProvider.soalAktif.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.secondary,
            appBar: AppBar(backgroundColor: AppColors.secondary, elevation: 0),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.accent, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Soal untuk Level ${widget.level} belum tersedia di database.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge.copyWith(color: AppColors.textDark),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                      child: Text('KEMBALI', style: AppTypography.buttonText.copyWith(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final totalSoal = kuisProvider.soalAktif.length;
        final currentIndex = kuisProvider.currentIndex;
        final safeIndex = currentIndex >= totalSoal ? totalSoal - 1 : currentIndex;
        final currentSoal = kuisProvider.soalAktif[safeIndex];

        // Opsi jawaban: A, B, C, D
        final opsi = [
          currentSoal.pilihanA,
          currentSoal.pilihanB,
          currentSoal.pilihanC,
          currentSoal.pilihanD,
        ];
        final jawabanBenar = currentSoal.jawabanBenar; // "A", "B", "C", or "D"

        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'BHARATAWAYANG',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 14,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: AppColors.accent.withValues(alpha: 0.3), height: 1.0),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'KUIS INTERAKTIF',
                    style: AppTypography.headingLarge.copyWith(
                      color: AppColors.textDark,
                      letterSpacing: 2,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 40, color: AppColors.accent.withValues(alpha: 0.5)),
                      const SizedBox(width: 16),
                      const Icon(Icons.diamond_outlined, color: AppColors.accent, size: 16),
                      const SizedBox(width: 16),
                      Container(height: 1, width: 40, color: AppColors.accent.withValues(alpha: 0.5)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (currentIndex > totalSoal ? totalSoal : currentIndex) / totalSoal,
                      backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Skor sementara: ${kuisProvider.skor}',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textDark.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(height: 24),

                   // Kartu Soal (With AnimatedSwitcher for question transitions)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 550),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final inAnimation = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation);
                      final outAnimation = Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation);

                      return ClipRect(
                        child: SlideTransition(
                          position: child.key == ValueKey<int>(currentIndex) ? inAnimation : outAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey<int>(currentIndex),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                        // Nomor soal pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            'PERTANYAAN ${currentIndex + 1}/$totalSoal',
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.textDark,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),



                        // Teks soal
                        Text(
                          currentSoal.pertanyaan,
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textDark,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Opsi jawaban (A, B, C, D)
                        ...opsi.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final label = ['A', 'B', 'C', 'D'][idx];
                          final teks = entry.value;
                          final isSelected = _selectedOptionIndex == idx;

                          
                          // Warna feedback
                          Color borderColor = AppColors.accent.withValues(alpha: 0.3);
                          Color bgColor = AppColors.secondary.withValues(alpha: 0.3);
                          Color labelBgColor = isSelected ? AppColors.accent : AppColors.accent.withValues(alpha: 0.15);
                          Color labelTextColor = isSelected ? AppColors.primary : AppColors.accent;
                          
                          Widget? feedbackIcon;

                          if (_isAnswered) {
                            if (isSelected) {
                              if (_lastAnswerCorrect) {
                                borderColor = Colors.green.shade700;
                                bgColor = Colors.green.shade100.withValues(alpha: 0.5);
                                labelBgColor = Colors.green.shade700;
                                labelTextColor = Colors.white;
                                feedbackIcon = Icon(Icons.check_circle, color: Colors.green.shade700, size: 20);
                              } else {
                                borderColor = Colors.red.shade700;
                                bgColor = Colors.red.shade100.withValues(alpha: 0.5);
                                labelBgColor = Colors.red.shade700;
                                labelTextColor = Colors.white;
                                feedbackIcon = Icon(Icons.cancel, color: Colors.red.shade700, size: 20);
                              }
                            }
                          } else if (isSelected) {
                            borderColor = AppColors.accent;
                            bgColor = AppColors.secondary;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: GestureDetector(
                              onTap: () => _jawabSoal(idx, label, jawabanBenar),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: borderColor,
                                    width: isSelected ? 2.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: labelBgColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          label,
                                          style: AppTypography.labelText.copyWith(
                                            color: labelTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        teks,
                                        style: AppTypography.bodyMedium.copyWith(
                                          color: AppColors.textDark,
                                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (feedbackIcon != null) ...[
                                      const SizedBox(width: 8),
                                      feedbackIcon,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        if (_isAnswered) ...[
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: _lastAnswerCorrect ? Colors.green.shade50 : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _lastAnswerCorrect ? Colors.green.shade300 : Colors.red.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _lastAnswerCorrect ? Icons.check_circle : Icons.cancel,
                                  color: _lastAnswerCorrect ? Colors.green.shade700 : Colors.red.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _lastAnswerCorrect
                                      ? 'JAWABAN BENAR!'
                                      : 'JAWABAN SALAH!',
                                  style: TextStyle(
                                    color: _lastAnswerCorrect ? Colors.green.shade800 : Colors.red.shade800,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ),

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const MainShell()),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.exit_to_app, size: 18),
                      label: Text(
                        'KEMBALI KE SASANA UTAMA',
                        style: AppTypography.buttonText.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.textDark),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
