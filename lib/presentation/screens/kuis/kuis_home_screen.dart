import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'kuis_game_screen.dart';

class KuisHomeScreen extends StatelessWidget {
  const KuisHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                'KUIS INTERAKTIF',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PILIH TINGKAT KESULITAN KUIS',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Pembatas Berlian
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.5))),
                  const SizedBox(width: 16),
                  const Icon(Icons.diamond_outlined, color: AppColors.accent, size: 16),
                  const SizedBox(width: 16),
                  Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.5))),
                ],
              ),
              const SizedBox(height: 32),

              // Level 1: Dalang Pemula
              _buildLevelCard(
                context,
                level: 1,
                title: 'DALANG PEMULA',
                subtitle: 'Pengenalan dasar pewayangan',
                isCompleted: false,
                icon: Icons.sports_martial_arts,
              ),
              const SizedBox(height: 16),

              // Level 2: Dalang Dasar
              _buildLevelCard(
                context,
                level: 2,
                title: 'DALANG DASAR',
                subtitle: 'Silsilah Pandawa & Kurawa',
                isCompleted: false,
                icon: Icons.shield_outlined,
              ),
              const SizedBox(height: 16),

              // Level 3: Dalang Handal
              _buildLevelCard(
                context,
                level: 3,
                title: 'DALANG HANDAL',
                subtitle: 'Konflik & Pengasingan',
                isCompleted: false,
                icon: Icons.shield_outlined,
              ),
              const SizedBox(height: 16),

              // Level 4: Dalang Mahir
              _buildLevelCard(
                context,
                level: 4,
                title: 'DALANG MAHIR',
                subtitle: 'Perang Bharatayuda',
                isCompleted: false,
                icon: Icons.shield_outlined,
              ),
              const SizedBox(height: 16),

              // Level 5: Dalang Maestro
              _buildLevelCard(
                context,
                level: 5,
                title: 'DALANG MAESTRO',
                subtitle: 'Filosofi & Nilai Moral',
                isCompleted: false,
                icon: Icons.local_fire_department,
              ),

              const SizedBox(height: 32),

              // Tombol Kembali
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.exit_to_app, size: 18),
                  label: Text(
                    'KEMBALI',
                    style: AppTypography.buttonText.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.textDark),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context, {
    required int level,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.primary : AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? AppColors.accent : AppColors.accent.withValues(alpha: 0.5),
          width: isCompleted ? 2 : 1,
        ),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
      ),
      child: Column(
        children: [
          Icon(icon, color: isCompleted ? AppColors.secondary : AppColors.primary, size: 32),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTypography.headingMedium.copyWith(
              color: isCompleted ? AppColors.secondary : AppColors.textDark,
              letterSpacing: 2,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: isCompleted ? AppColors.secondary.withValues(alpha: 0.8) : AppColors.textDark.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '10 Pertanyaan',
            style: AppTypography.labelText.copyWith(
              color: isCompleted ? AppColors.accent : AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => KuisGameScreen(level: level),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isCompleted ? Colors.transparent : AppColors.accent,
                foregroundColor: isCompleted ? AppColors.accent : AppColors.primary,
                elevation: 0,
                side: isCompleted ? const BorderSide(color: AppColors.accent) : BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(
                isCompleted ? 'SELESAI' : 'MULAI',
                style: AppTypography.buttonText.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
