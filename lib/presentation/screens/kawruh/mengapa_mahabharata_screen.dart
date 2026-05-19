import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class MengapaMahabharataScreen extends StatelessWidget {
  const MengapaMahabharataScreen({super.key});

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
                'DARMANING MAHABHARATA',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'MENGAPA KISAH MAHABHARATA?',
                style: AppTypography.labelText.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // SVG Divider
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

              // Content 1: Dharma (previously drop caps layout)
              _buildContentSection(
                title: 'DHARMA: JALAN KEBENARAN',
                content:
                    'Mahabharata bukan sekadar kisah perseteruan keluarga, melainkan panggung besar untuk mengeksplorasi konsep Dharma. Dharma menjadi sebuah prinsip universal tentang tugas, kebenaran, dan hukum kosmik, menjadi benang merah yang mengikat seluruh narasi epik ini. Setiap karakter, dari Pandawa yang luhur hingga Kurawa yang ambisius, diuji oleh pemahaman dan pelaksanaan Dharma mereka masing-masing.',
              ),
              const SizedBox(height: 2),
              _buildContentSection(
                title: '',
                content:
                    'Kisah ini mengajarkan bahwa Dharma bukanlah aturan yang kaku, melainkan pilihan etis yang kompleks dalam situasi yang seringkali abu-abu. Arjuna di padang Kurukshetra menghadapi dilema terbesarnya: haruskah ia memerangi saudara-saudaranya demi kebenaran (Dharma ksatria), atau mundur demi menjaga ikatan keluarga? Jawaban Krishna dalam Bhagavad Gita memberikan panduan spiritual yang mendalam tentang tindakan tanpa pamrih dan penyerahan diri kepada Yang Maha Kuasa.',
              ),
              const SizedBox(height: 74),

              // Content 2: Konflik dan Karma
              _buildContentSection(
                title: 'KONFLIK DAN KARMA',
                content:
                    'Setiap tokoh dalam Mahabharata memanifestasikan nyata dari Hukum Karma. Sengkuni, Duryudana, dan Dursasana yang selalu berbuat jahat pada akhirnya menuai nasib menyedihkan. Sebaliknya, yang memegang teguh kebenaran mendapat tempat layak.',
              ),
              const SizedBox(height: 46),

              // Quote Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.05),
                  border: const Border(
                    left: BorderSide(color: AppColors.accent, width: 4),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: AppColors.accent,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '"Apa yang ada di sini, mungkin ada di tempat lain; tetapi apa yang tidak ada di sini, tidak akan ada di mana pun."',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textDark,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- Resi Byasa (Penulis Mahabharata)',
                      style: AppTypography.labelText.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              _buildContentSection(
                title: '',
                content:
                    'Perang Kurukshetra bukanlah perayaan kemenangan, melainkan tragedi tentang harga yang harus dibayar demi menegakkan Dharma. Kehancuran massal yang terjadi menyadarkan kita bahwa perang, meskipun terkadang dianggap perlu untuk menghancurkan kejahatan (Adharma), selalu membawa penderitaan dan kehilangan yang mendalam..',
              ),
              const SizedBox(height: 74),

              // Content 3: Pelajaran Spiritual
              _buildContentSection(
                title: 'PELAJARAN SPIRITUAL (MOKSHA)',
                content:
                    'Melalui kerumitan cerita karakternya, Mahabharata merepresentasikan jiwa manusia itu sendiri. Yudhistira dengan kejujurannya yang kadang melemahkan, Bima dengan kekuatan kasarnya, atau Karna dengan kesetiaannya yang salah tempat; mereka semua adalah cermin dari kelemahan dan kekuatan kita. Epik ini mengajak kita untuk merenungkan makna sejati dari kehidupan, melampaui ambisi duniawi menuju pencapaian spiritual (Moksha).',
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
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTypography.headingMedium.copyWith(
            color: AppColors.textDark,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textDark.withValues(alpha: 0.8),
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
