import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/kartu_wayang_model.dart';

class ProfilKsatriaScreen extends StatelessWidget {
  final KartuWayang kartu;

  const ProfilKsatriaScreen({super.key, required this.kartu});

  @override
  Widget build(BuildContext context) {
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
          'MUSTIKA KSATRIA',
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
              // Avatar Section
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
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
              const SizedBox(height: 24),

              // Name and Afiliasi
              Text(
                kartu.nama.toUpperCase(),
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 4),
              if (kartu.afiliasi != null)
                Text(
                  kartu.afiliasi!,
                  style: AppTypography.labelText.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1,
                  ),
                ),
              const SizedBox(height: 12),

              // Rarity Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accent, width: 1),
                ),
                child: Text(
                  (kartu.rarity ?? 'COMMON').toUpperCase(),
                  style: AppTypography.labelText.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              // Decorative Line
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1, width: 60, color: AppColors.accent.withValues(alpha: 0.5)),
                  const SizedBox(width: 8),
                  const Icon(Icons.diamond, color: AppColors.accent, size: 8),
                  const SizedBox(width: 8),
                  Container(height: 1, width: 60, color: AppColors.accent.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 32),

              // Details Section - dari database
              if (kartu.pusaka != null && kartu.pusaka!.isNotEmpty)
                _buildDetailRow(Icons.colorize, 'Senjata & Pusaka', kartu.pusaka!),
              if (kartu.kekuatan != null && kartu.kekuatan!.isNotEmpty)
                _buildDetailRow(Icons.local_fire_department, 'Ajian & Kesaktian', kartu.kekuatan!),
              if (kartu.nilaiMoral != null && kartu.nilaiMoral!.isNotEmpty)
                _buildDetailRow(Icons.psychology, 'Nilai Moral', kartu.nilaiMoral!),
              if (kartu.deskripsi != null && kartu.deskripsi!.isNotEmpty)
                _buildDetailRow(Icons.auto_stories, 'Kisah & Peran', kartu.deskripsi!),

              const SizedBox(height: 16),
              // Skor unlock info
              if (kartu.unlockSkorMin != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined, color: AppColors.accent, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Kartu dibuka dengan skor ≥ ${kartu.unlockSkorMin} di Kuis',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDark.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 40),
              const Icon(Icons.diamond_outlined, color: AppColors.accent, size: 24),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textDark,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textDark.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
