import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class UnsurPertunjukanScreen extends StatelessWidget {
  const UnsurPertunjukanScreen({super.key});

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
                'UBARAMPE',
                style: GoogleFonts.cinzel(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'UNSUR PERTUNJUKAN',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.accent,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              // Decorative Line
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
              ),
              const SizedBox(height: 24),
              
              Text(
                'Sebuah glosarium suci yang merinci unsur-unsur fisik dan spiritual penting yang digunakan oleh Dalang untuk menghidupkan kembali kisah pewayangan Jawa kuno.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textDark.withValues(alpha: 0.8),
                  height: 1.6,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 40),

              // DALANG CARD (Puppeteer)
              _buildStaticCard(
                imagePath: 'assets/images/ui/dalang_illustration.png',
                title: 'DALANG',
                subtitle: 'Sang Pengendali Bayangan',
                description: 'Sang narator utama dan konduktor pertunjukan. Dalang memberikan kehidupan pada bayangan-bayangan kulit, menyalurkan roh para pahlawan dan tokoh antagonis melalui suara, gerakan, dan kebijaksanaan kuno.',
              ),
              const SizedBox(height: 24),

              // GAMELAN CARD (Musical Ensemble)
              _buildStaticCard(
                imagePath: 'assets/images/ui/gamelan_illustration.png',
                title: 'GAMELAN',
                subtitle: 'Ansambel Musik',
                description: 'Ansambel instrumen tradisional yang mengiringi pertunjukan, menentukan suasana hati, tempo, dan resonansi emosional dari setiap adegan melalui ritme perkusi yang kompleks.',
              ),
              const SizedBox(height: 24),

              // CEMPALA CARD (Wooden mallet)
              _buildStaticCard(
                imagePath: 'assets/images/ui/cempala_illustration.png',
                title: 'CEMPALA',
                subtitle: 'Ketukan Sutradara',
                description: 'Sebuah palu kayu kecil yang digunakan oleh Dalang untuk mengetuk kotak wayang, memberikan isyarat ritmis kepada gamelan dan menciptakan efek suara dramatis.',
              ),
              const SizedBox(height: 24),

              // KELIR CARD (Screen/Canvas)
              _buildStaticCard(
                imagePath: 'assets/images/ui/kelir_illustration.png',
                title: 'KELIR',
                subtitle: 'Layar Kosmik',
                description: 'Layar kanvas putih yang melambangkan alam semesta. Saat diterangi oleh blencong (lampu minyak), kelir menjadi panggung di mana bayangan berubah menjadi legenda hidup.',
              ),
              const SizedBox(height: 24),

              // BLENCONG CARD (Oil lamp)
              _buildStaticCard(
                imagePath: 'assets/images/ui/blencong_illustration.png',
                title: 'BLENCONG',
                subtitle: 'Matahari Purba',
                description: 'Lampu minyak perunggu tradisional berbentuk seperti burung yang digantung di belakang layar. Nyala apinya yang berkedip-kedip memberikan kualitas bayangan yang bergetar seakan bernapas.',
              ),
              const SizedBox(height: 24),

              // KOTAK CARD (Wayang chest/box)
              _buildStaticCard(
                imagePath: 'assets/images/ui/kotak_illustration.png',
                title: 'KOTAK',
                subtitle: 'Peti Dunia',
                description: 'Peti kayu besar tempat wayang bersemayam. Kotak melambangkan dunia bawah atau kekosongan sebelum penciptaan, dari mana semua karakter muncul dan akhirnya kembali.',
              ),

              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaticCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.5), width: 1),
      ),
      child: Column(
        children: [
          // White Square Image Container (Mockup Style)
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, color: AppColors.accent, size: 48),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            title,
            style: GoogleFonts.cinzel(
              color: AppColors.textDark,
              letterSpacing: 2,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.accent,
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          // Thin Golden Divider
          Container(
            width: 40,
            height: 1,
            color: AppColors.accent.withValues(alpha: 0.5),
            margin: const EdgeInsets.symmetric(vertical: 16),
          ),
          
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textDark.withValues(alpha: 0.8),
              height: 1.6,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
