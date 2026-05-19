import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class JenisWayangScreen extends StatefulWidget {
  const JenisWayangScreen({super.key});

  @override
  State<JenisWayangScreen> createState() => _JenisWayangScreenState();
}

class _JenisWayangScreenState extends State<JenisWayangScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  static const List<Map<String, String>> _staticJenis = [
    {
      'title': 'WAYANG KULIT PURWA',
      'description': 'Wayang kulit adalah jenis wayang paling terkenal di Indonesia yang terbuat dari kulit sapi atau kerbau. Dimainkan dengan teknik bayangan (menggunakan kelir dan blencong), mengangkat kisah epik Mahabharata dan Ramayana.',
      'tag': 'KULIT (LEATHER)',
    },
    {
      'title': 'WAYANG GOLEK',
      'description': 'Boneka kayu tiga dimensi yang populer di tanah Sunda (Jawa Barat). Dipertontonkan tanpa layar bayangan, menggunakan bahasa Sunda, dan sering menyisipkan kisah bernuansa jenaka (Cepot) maupun epik lokal.',
      'tag': 'KAYU (WOODEN)',
    },
    {
      'title': 'WAYANG ORANG (WONG)',
      'description': 'Seni pertunjukan di mana tokoh wayang diperankan langsung oleh manusia dengan kostum, tata rias, dan tarian. Menggabungkan seni drama, tari, dan iringan gamelan khas keraton Jawa.',
      'tag': 'MANUSIA (HUMAN)',
    },
    {
      'title': 'WAYANG BEBER',
      'description': 'Salah satu bentuk wayang tertua di Indonesia. Ceritanya dilukis pada gulungan kain atau kertas (dibeber/dibentangkan). Dalang menceritakan kisah sambil menunjuk gambar pada gulungan tersebut.',
      'tag': 'GULUNGAN (SCROLL)',
    },
    {
      'title': 'WAYANG KLITIK (KRUCIL)',
      'description': 'Wayang pipih yang terbuat dari kayu jati. Berbeda dengan wayang golek yang 3D, wayang klitik berbentuk 2D. Dinamakan klitik karena suara kayu yang berbenturan saat wayang digerakkan berbunyi "klitik-klitik".',
      'tag': 'KAYU PIPIH (FLAT WOOD)',
    },
    {
      'title': 'WAYANG GEDOG',
      'description': 'Mirip dengan wayang kulit purwa, namun khusus mengangkat cerita-cerita Panji (kisah romansa Raden Panji Asmarabangun dan Dewi Sekartaji) dari zaman Kerajaan Kediri dan Jenggala.',
      'tag': 'CERITA PANJI',
    },
    {
      'title': 'WAYANG SULUH',
      'description': 'Wayang modern yang muncul pada masa perjuangan kemerdekaan Indonesia. Digunakan sebagai alat penerangan (penyuluhan) dan propaganda. Tokoh-tokohnya digambarkan seperti manusia modern.',
      'tag': 'PENYULUHAN (MODERN)',
    },
    {
      'title': 'WAYANG WAHYU',
      'description': 'Wayang kulit yang diciptakan untuk menyebarkan ajaran agama Katolik. Kisah yang diangkat diambil dari Alkitab, diciptakan oleh Bruder Timotheus L. Wignyosubroto pada tahun 1960-an.',
      'tag': 'KULIT (ALKITAB)',
    },
    {
      'title': 'WAYANG POTEHI',
      'description': 'Wayang boneka kain hasil asimilasi budaya Tionghoa dan Indonesia. Dimainkan dengan memasukkan tangan dalang ke dalam kantong boneka, biasanya membawakan kisah klasik Tiongkok kuno.',
      'tag': 'BONEKA KAIN (CLOTH)',
    },
    {
      'title': 'WAYANG SASAK',
      'description': 'Wayang kulit khas dari Pulau Lombok, Nusa Tenggara Barat. Banyak dipengaruhi oleh penyebaran agama Islam, menceritakan kisah-kisah Serat Menak dengan tokoh utama Amir Hamzah.',
      'tag': 'KULIT (LOMBOK)',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              'PRAKARA',
              style: AppTypography.headingLarge.copyWith(
                color: AppColors.textDark,
                letterSpacing: 2,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'JENIS-JENIS WAYANG',
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
              colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
            ),
            const SizedBox(height: 32),

            Expanded(
              child: PageView(
                controller: _pageController,
                children: _staticJenis.map((jenis) => _buildWayangCard(
                  title: jenis['title']!,
                  description: jenis['description']!,
                  tag: jenis['tag']!,
                )).toList(),
              ),
            ),
            const SizedBox(height: 80), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildWayangCard({
    required String title,
    required String description,
    required String tag,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                border: Border(bottom: BorderSide(color: AppColors.accent, width: 1)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_outlined, color: AppColors.accent, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      '(Gambar $title)',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.secondary),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // Content Section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.textDark,
                            fontSize: 18,
                            letterSpacing: 1.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Text(
                      description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textDark.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tag,
                    style: AppTypography.labelText.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
