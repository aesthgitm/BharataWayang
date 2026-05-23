import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/koleksi_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/models/kartu_wayang_model.dart';
import '../../widgets/main_shell.dart';
import 'kuis_game_screen.dart';

class KuisHasilScreen extends StatelessWidget {
  final int score;
  final int level;

  const KuisHasilScreen({super.key, required this.score, this.level = 1});

  int _getCardIdForLevel(int lvl) {
    switch (lvl) {
      case 1: return 3; // Janaka
      case 2: return 10; // Adipati Karna
      case 3: return 17; // Batara Indra
      case 4: return 12; // Resi Bisma
      case 5: return 6; // Sri Kresna
      default: return 3;
    }
  }

  String _getLevelName(int lvl) {
    switch (lvl) {
      case 1: return 'DALANG PEMULA';
      case 2: return 'DALANG DASAR';
      case 3: return 'DALANG HANDAL';
      case 4: return 'DALANG MAHIR';
      case 5: return 'DALANG MAESTRO';
      default: return 'DALANG PEMULA';
    }
  }

  // Tentukan pesan motivasi berdasarkan skor
  String _getPesan() {
    if (score >= 90) return 'Luar biasa! Pengetahuan Anda tentang pewayangan sangatlah dalam. Anda layak menyandang gelar Dalang Maestro!';
    if (score >= 70) return 'Bagus! Anda telah membuka kartu Mustika baru. Terus pelajari kisah-kisah wayang untuk menjadi Dalang Maestro!';
    if (score >= 50) return 'Cukup baik. Masih ada ruang untuk berkembang. Pelajari lagi materi Kawruh dan coba ulangi kuis ini!';
    return 'Jangan menyerah, Ksatria! Pelajari Ensiklopedia Kawruh terlebih dahulu lalu coba lagi. Setiap usaha adalah bagian dari perjalanan!';
  }

  bool get _mendapatKartu => score >= 70;

  @override
  Widget build(BuildContext context) {
    final koleksiProvider = Provider.of<KoleksiProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;

    final targetCardId = _getCardIdForLevel(level);
    
    // Cari kartu spesifik dari provider sesuai level
    final targetCard = koleksiProvider.semuaKartu.firstWhere(
      (k) => k.id == targetCardId,
      orElse: () => KartuWayang(
        id: targetCardId,
        nama: 'Janaka',
        afiliasi: 'Pandawa',
        deskripsi: 'Janaka adalah ksatria pewayangan.',
        imageAsset: 'assets/images/ui/digital_gunungan_nobg.png',
        rarity: 'Legendaris',
      ),
    );

    Widget cardRevealWidget = TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: math.pi, end: 0.0),
      duration: const Duration(milliseconds: 5000),
      curve: Curves.easeOutBack,
      builder: (context, yRotation, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002) // Perspective
            ..rotateY(yRotation),
          child: child,
        );
      },
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: _mendapatKartu ? Colors.white.withValues(alpha: 0.9) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _mendapatKartu ? AppColors.accent : AppColors.textDark.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _mendapatKartu
              ? Image.asset(
                  targetCard.imageAsset ?? 'assets/images/ui/digital_gunungan_nobg.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/ui/digital_gunungan_nobg.png',
                    fit: BoxFit.contain,
                  ),
                )
              : const Icon(Icons.lock_outline, color: AppColors.accent, size: 40),
        ),
      ),
    );

    if (_mendapatKartu) {
      cardRevealWidget = cardRevealWidget
          .animate()
          .boxShadow(
            begin: const BoxShadow(color: Colors.transparent, blurRadius: 0, spreadRadius: 0),
            end: BoxShadow(color: Colors.amber.withValues(alpha: 0.4), blurRadius: 15, spreadRadius: 3),
            duration: 1.seconds,
            curve: Curves.easeOutCubic,
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: false))
          .shimmer(delay: 2.seconds, duration: 1.8.seconds, color: Colors.amber.shade200);
    }


    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainShell()),
            (route) => false,
          ),
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
          child: Container(
            color: AppColors.accent.withValues(alpha: 0.3),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Score Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: score >= 70 ? AppColors.accent : AppColors.textDark.withValues(alpha: 0.3),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$score',
                        style: AppTypography.headingLarge.copyWith(
                          color: score >= 70 ? AppColors.accent : AppColors.textDark,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 60,
                        color: AppColors.accent.withValues(alpha: 0.6),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      Text(
                        '/ 100',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textDark.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1.0, 1.0),
                  duration: 850.ms,
                  curve: Curves.elasticOut,
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'HASIL KUIS INTERAKTIF',
                  style: AppTypography.headingLarge.copyWith(
                    color: AppColors.textDark,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accent,
                    ),
                  ),
                  child: Text(
                    _getLevelName(level),
                    style: AppTypography.labelText.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.3))),
                    const SizedBox(width: 16),
                    const Icon(Icons.diamond_outlined, color: AppColors.accent, size: 16),
                    const SizedBox(width: 16),
                    Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.3))),
                  ],
                ),
                const SizedBox(height: 32),

                // Hadiah / Motivasi Card
                Container(
                  decoration: BoxDecoration(
                    color: _mendapatKartu ? AppColors.primary : AppColors.secondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _mendapatKartu ? AppColors.accent : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: _mendapatKartu
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: _mendapatKartu ? 260 : 220,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Kartu atau ikon (With 3D Flip Reveal & Gold Glow Shimmer)
                              cardRevealWidget,
                              const SizedBox(height: 16),
                              Text(
                                _mendapatKartu ? 'SELAMAT! ANDA MENDAPATKAN KARTU:' : 'TERUS BERJUANG!',
                                style: AppTypography.headingMedium.copyWith(
                                  color: _mendapatKartu ? AppColors.accent : AppColors.textDark,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_mendapatKartu) ...[
                                const SizedBox(height: 4),
                                Text(
                                  targetCard.nama.toUpperCase(),
                                  style: AppTypography.headingMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.accent, width: 1),
                                  ),
                                  child: Text(
                                    (targetCard.rarity ?? 'Umum').toUpperCase(),
                                    style: AppTypography.labelText.copyWith(
                                      color: AppColors.accent,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 12),
                              Text(
                                _getPesan(),
                                style: AppTypography.bodySmall.copyWith(
                                  color: _mendapatKartu ? Colors.white.withValues(alpha: 0.8) : AppColors.textDark.withValues(alpha: 0.8),
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol Kembali ke Sasana Utama
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Reload koleksi sebelum kembali ke home
                      if (userId != null) {
                        Provider.of<KoleksiProvider>(context, listen: false).loadData(userId);
                      }
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainShell()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home, size: 18),
                    label: Text(
                      'KEMBALI KE SASANA UTAMA',
                      style: AppTypography.buttonText.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol Ulangi (dengan level yang sama)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => KuisGameScreen(level: level),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(
                      'ULANGI KUIS LEVEL $level',
                      style: AppTypography.buttonText.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.accent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
                child: ConfettiWidget(active: _mendapatKartu),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Confetti / Particle Animation System (Self-Contained Helper) ---

class ConfettiParticle {
  final Color color;
  double x, y;
  double vx, vy;
  final double size;
  double rotation;
  final double rotationSpeed;
  double opacity = 1.0;
  final double decayRate;

  ConfettiParticle({
    required this.color,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.decayRate,
  });

  void update(double dt) {
    x += vx * dt;
    y += vy * dt;
    vy += 150.0 * dt; // Gravity vertical pull
    vx *= 0.98;       // Air resistance friction
    rotation += rotationSpeed * dt;
    opacity = (opacity - decayRate * dt).clamp(0.0, 1.0);
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      if (p.opacity <= 0) continue;
      paint.color = p.color.withValues(alpha: p.opacity);
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ConfettiWidget extends StatefulWidget {
  final bool active;
  const ConfettiWidget({super.key, required this.active});

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (widget.active) {
      _generateParticles();
      _controller.repeat();
    }
  }

  void _generateParticles() {
    final colors = [
      Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.pink, Colors.orange, Colors.purple, Colors.cyan, Colors.amber
    ];
    final random = math.Random();
    
    // Generate particles on left and right borders shooting upwards and inwards
    for (int i = 0; i < 35; i++) {
      // Left side launcher
      _particles.add(
        ConfettiParticle(
          color: colors[random.nextInt(colors.length)],
          x: -10,
          y: 450,
          vx: random.nextDouble() * 320 + 120,    // Moves rightwards
          vy: -random.nextDouble() * 450 - 250,   // Shoots upwards
          size: random.nextDouble() * 8 + 6,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 6 - 3.0,
          decayRate: random.nextDouble() * 0.15 + 0.15, // decay rate between 0.15 and 0.30
        ),
      );
      // Right side launcher
      _particles.add(
        ConfettiParticle(
          color: colors[random.nextInt(colors.length)],
          x: 450, // Updated dynamically in LayoutBuilder
          y: 450,
          vx: -random.nextDouble() * 320 - 120,   // Moves leftwards
          vy: -random.nextDouble() * 450 - 250,   // Shoots upwards
          size: random.nextDouble() * 8 + 6,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 6 - 3.0,
          decayRate: random.nextDouble() * 0.15 + 0.15, // decay rate between 0.15 and 0.30
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust right side X positions dynamically based on screen width
        if (_particles.isNotEmpty && _particles[0].x == -10 && _particles[1].x == 450) {
          for (int i = 0; i < _particles.length; i++) {
            if (i % 2 == 1) { // Right side launcher particles
              _particles[i].x = constraints.maxWidth + 10;
            }
          }
        }
        
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            const double dt = 0.016; // Approx. frame duration
            bool anyVisible = false;
            for (final p in _particles) {
              p.update(dt);
              if (p.opacity > 0 && p.y < constraints.maxHeight) {
                anyVisible = true;
              }
            }
            
            // Stop the ticker once all particles are fully faded out/off-screen to conserve battery/CPU
            if (!anyVisible && _controller.isAnimating) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && _controller.isAnimating) {
                  _controller.stop();
                }
              });
            }

            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ConfettiPainter(_particles),
            );
          },
        );
      },
    );
  }
}
