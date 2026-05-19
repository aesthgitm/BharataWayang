import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class PengertianWayangScreen extends StatelessWidget {
  const PengertianWayangScreen({super.key});

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
                'PANYANDRA',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PENGERTIAN WAYANG',
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

              // Wayang Performance Image
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.accent, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/images/ui/wayang_performance.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: AppColors.accent,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Explanation Text
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textDark.withValues(alpha: 0.8),
                    height: 1.8,
                  ),
                  children: const [
                    TextSpan(
                      text:
                          'Wayang adalah seni pertunjukan tradisional Indonesia yang bercerita tentang kehidupan, nilai moral, dan petualangan tokoh-tokoh tertentu. Pertunjukan ini bisa menggunakan boneka (seperti wayang kulit atau wayang golek) atau dimainkan langsung oleh manusia (wayang orang). Biasanya, cerita yang dibawakan berasal dari kisah-kisah terkenal seperti Ramayana dan Mahabharata, tapi ada juga yang mengangkat cerita lokal atau kehidupan sehari-hari. Wayang tidak hanya untuk hiburan, tapi juga menjadi media untuk menyampaikan pesan tentang kebaikan, kejujuran, dan kebijaksanaan.\n\n',
                    ),
                    TextSpan(
                      text:
                          'Di balik tampilannya yang tradisional, wayang sebenarnya punya makna yang dalam dan masih relevan sampai sekarang. Lewat karakter dan alur cerita, kita bisa belajar tentang cara menghadapi masalah, memilih yang benar, dan memahami berbagai sifat manusia. Bahkan, wayang sudah diakui dunia sebagai warisan budaya yang berharga. Jadi, meskipun terlihat “jadul”, wayang tetap keren untuk dipelajari karena mengandung banyak pelajaran hidup yang bisa diterapkan di zaman sekarang.',
                    ),
                  ],
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
}
