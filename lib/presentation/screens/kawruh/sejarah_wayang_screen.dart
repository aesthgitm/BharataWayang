import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SejarahWayangScreen extends StatelessWidget {
  const SejarahWayangScreen({super.key});

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
          'PENGENALAN WAYANG',
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
              Text(
                'BEBUKA',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ASAL-USUL & SEJARAH',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Decorative Line
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
              const SizedBox(height: 32),

              _buildSejarahCard(
                title: 'ERA KUNO (ANIMISME)',
                description:
                    'Awal mula pertunjukan wayang diyakini berasal dari ritual pemujaan roh nenek moyang pada zaman prasejarah di Nusantara, sebelum masuknya pengaruh Hindu-Buddha.',
              ),
              const SizedBox(height: 16),
              _buildSejarahCard(
                title: 'PENGARUH HINDU-BUDDHA',
                description:
                    'Masuknya epik Mahabharata dan Ramayana dari India memperkaya repertoar cerita wayang, diadaptasi dengan kearifan lokal Jawa menjadi karya sastra dan pertunjukan yang luhur.',
              ),
              const SizedBox(height: 16),
              _buildSejarahCard(
                title: 'ERA KESULTANAN ISLAM',
                description:
                    'Wali Songo menggunakan wayang sebagai media dakwah Islam. Bentuk fisik wayang kulit dimodifikasi untuk menghindari penggambaran makhluk bernyawa secara realistis, melahirkan bentuk stilasi yang kita kenal sekarang.',
              ),
              const SizedBox(height: 16),
              _buildSejarahCard(
                title: 'PELESTARIAN MODERN',
                description:
                    'Diakui oleh UNESCO sebagai Karya Agung Warisan Budaya Lisan dan Nonbendawi Manusia. Upaya pelestarian terus berlanjut melalui pendidikan, inovasi pertunjukan, dan dokumentasi digital.',
              ),

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
                height: 80,
              ), // Padding bottom for floating navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSejarahCard({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textDark,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textDark.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
