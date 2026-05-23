import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/kartu_wayang_model.dart';
import '../../widgets/main_shell.dart';

class DalangMainScreen extends StatefulWidget {
  final List<KartuWayang> selectedWayang;
  final MainShellState? mainShellState;

  const DalangMainScreen({
    super.key,
    required this.selectedWayang,
    this.mainShellState,
  });

  @override
  State<DalangMainScreen> createState() => _DalangMainScreenState();
}

class WayangPuppetState {
  final KartuWayang wayang;
  Offset position;
  double scale;
  double rotation;
  bool isFlipped;

  WayangPuppetState({
    required this.wayang,
    required this.position,
    this.scale = 0.5,
    this.rotation = 0.0,
    this.isFlipped = false,
  });
}

class _DalangMainScreenState extends State<DalangMainScreen> with TickerProviderStateMixin {
  late AnimationController _blencongController;
  final List<WayangPuppetState> _puppets = [];
  int _selectedPuppetIndex = 0;
  final TextEditingController _narasiController = TextEditingController(text: "Suro Diro Joyo Ningrat, Lebur Dening Pangastuti...");

  @override
  void initState() {
    super.initState();
    _blencongController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..addListener(() {
        setState(() {});
      })..repeat(reverse: true);

    // Force horizontal/landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Initialize puppets position across the stage for landscape mode
    final double spacing = 450.0 / (widget.selectedWayang.length + 1);

    for (int i = 0; i < widget.selectedWayang.length; i++) {
      _puppets.add(
        WayangPuppetState(
          wayang: widget.selectedWayang[i],
          position: Offset(80.0 + (i * spacing), 60.0),
          scale: 0.5,
          isFlipped: i >= widget.selectedWayang.length / 2, // Flip half of them to face the other side
        ),
      );
    }
  }

  @override
  void dispose() {
    _blencongController.dispose();
    _narasiController.dispose();
    // Restore orientation back to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _resetStage() {
    setState(() {
      final double spacing = 450.0 / (widget.selectedWayang.length + 1);
      for (int i = 0; i < _puppets.length; i++) {
        _puppets[i].position = Offset(80.0 + (i * spacing), 60.0);
        _puppets[i].scale = 0.5;
        _puppets[i].rotation = 0.0;
        _puppets[i].isFlipped = i >= _puppets.length / 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background pinggir layar (menutupi seluruh layar secara penuh tanpa terpotong)
          Image.asset(
            'assets/images/backgrounds/bg_simulasidalang.png',
            fit: BoxFit.fill,
          ),
          
          // Overlay redup
          Container(color: Colors.black.withValues(alpha: 0.4)),

          // Area Konten Utama dibatasi SafeArea agar aman dari notch/status bar
          SafeArea(
            child: Column(
              children: [
                // Kelir Panggung Utama (Center Stage) yang menyesuaikan sisa ruang vertikal
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(60, 16, 60, 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accent, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 1. Background Cream Radial Kelir (With Animated Blencong Light Flicker)
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: const Alignment(0.0, -0.4),
                                radius: 1.15 + (_blencongController.value * 0.12),
                                colors: [
                                  Color.lerp(
                                    const Color(0xFFFFF2D0), // Golden blencong glow
                                    const Color(0xFFFFEFA8),
                                    _blencongController.value,
                                  )!,
                                  const Color(0xFFE5C88F), // Parchment warm tone
                                  const Color(0xFF4A341A), // Wooden dark border glow
                                  Colors.black,      // Deep shadows
                                ],
                                stops: const [0.0, 0.4, 0.8, 1.0],
                              ),
                            ),
                          ),

                          // 2. Puppets layer
                          _puppets.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Tidak ada wayang terpilih.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Stack(
                                  children: List.generate(_puppets.length, (index) {
                                    final puppet = _puppets[index];
                                    final isSelected = index == _selectedPuppetIndex;

                                    return Positioned(
                                      left: puppet.position.dx,
                                      top: puppet.position.dy,
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(begin: 1.0, end: 0.0),
                                        duration: Duration(milliseconds: 600 + index * 150),
                                        curve: Curves.easeOutBack,
                                        builder: (context, slideProgress, child) {
                                          return Transform.translate(
                                            offset: Offset(0, slideProgress * 200),
                                            child: child,
                                          );
                                        },
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _selectedPuppetIndex = index;
                                            });
                                          },
                                          onDoubleTap: () {
                                            setState(() {
                                              puppet.isFlipped = !puppet.isFlipped;
                                            });
                                          },
                                          onScaleStart: (details) {
                                            setState(() {
                                              _selectedPuppetIndex = index;
                                            });
                                          },
                                          onScaleUpdate: (details) {
                                            setState(() {
                                              puppet.position += details.focalPointDelta;
                                              if (details.scale != 1.0) {
                                                puppet.scale = (puppet.scale * details.scale).clamp(0.2, 2.0);
                                              }
                                              if (details.rotation != 0.0) {
                                                puppet.rotation += details.rotation;
                                              }
                                            });
                                          },
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween<double>(begin: 0.0, end: puppet.isFlipped ? 3.14159265 : 0.0),
                                            duration: const Duration(milliseconds: 400),
                                            curve: Curves.easeInOutSine,
                                            builder: (context, yRotation, child) {
                                              return Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..setEntry(3, 2, 0.0015) // 3D perspective
                                                  ..rotateY(yRotation)
                                                  ..multiply(Matrix4.diagonal3Values(puppet.scale, puppet.scale, 1.0))
                                                  ..rotateZ(puppet.rotation),
                                                child: child,
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isSelected ? AppColors.accent : Colors.transparent,
                                                  width: 1.5,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    puppet.wayang.imageAsset ?? 'assets/images/ui/digital_gunungan_nobg.png',
                                                    width: 120,
                                                    height: 180,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                                      'assets/images/ui/digital_gunungan_nobg.png',
                                                      width: 120,
                                                      height: 180,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Container(
                                                    width: 3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      gradient: const LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [
                                                          Color(0xFF4A341A),
                                                          Colors.black,
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.circular(1.5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),

                          // 3. Sabda Dalang (Narration Box) inside the Kelir Stage
                          Positioned(
                            top: 8,
                            left: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.accent, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.menu_book, color: AppColors.accent, size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        'SABDA DALANG',
                                        style: AppTypography.labelText.copyWith(
                                          color: AppColors.accent,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: _narasiController,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.secondary,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
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

                // Area Navigasi dan Petunjuk Kontrol di bagian bawah (sejajar)
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 4, 60, 12),
                  child: Row(
                    children: [
                      // Sisi Kiri: Tombol Navigasi (Back, Home, Restart)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: AppColors.secondary, size: 20),
                            onPressed: () => Navigator.of(context).pop(),
                            tooltip: 'Kembali ke Pemilihan',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withValues(alpha: 0.6),
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(36, 36),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.home_outlined, color: AppColors.secondary, size: 20),
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => route.settings.name == '/main_shell' || route.isFirst);
                              widget.mainShellState?.setTab(0);
                            },
                            tooltip: 'Beranda',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withValues(alpha: 0.6),
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(36, 36),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.refresh, color: AppColors.accent, size: 20),
                            onPressed: _resetStage,
                            tooltip: 'Ulang/Restart',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withValues(alpha: 0.6),
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(36, 36),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Sisi Kanan: Teks Petunjuk Interaksi
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                          ),
                          child: Center(
                            child: Text(
                              '* Geser untuk Pindah  •  Cubit untuk Skala  •  Putar untuk Rotasi  •  Ketuk 2x untuk Membalik',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.secondary.withValues(alpha: 0.9),
                                fontSize: 8.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
