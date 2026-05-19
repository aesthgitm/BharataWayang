import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class FaqMahabharataScreen extends StatelessWidget {
  const FaqMahabharataScreen({super.key});

  static const List<Map<String, String>> _staticFaq = [
    {
      'tanya': 'Kenapa Bisma memihak Kurawa padahal tahu mereka salah?',
      'jawab': 'Bisma terikat sumpah setia kepada tahta Hastinapura, bukan kepada orangnya. Siapa pun yang duduk di tahta (saat itu Dretarastra dan Kurawa), wajib ia lindungi. Jadi ini konflik antara dharma (kewajiban) melawan kebenaran moral.',
    },
    {
      'tanya': 'Kenapa Drona juga memihak Kurawa?',
      'jawab': 'Drona memihak Kurawa bukan cuma karena balas budi ke Hastinapura, tapi juga karena rasa sayang dan tanggung jawab terhadap Aswatama. Ia ingin anaknya memiliki kedudukan, kekuasaan, dan masa depan yang aman di kerajaan. Kurawa (khususnya Duryudana) memberikan posisi dan kehormatan itu, sehingga Drona merasa harus tetap setia.',
    },
    {
      'tanya': 'Kenapa Karna memihak Kurawa padahal dia kakak tertua Pandava?',
      'jawab': 'Karna tidak tahu jati dirinya sejak kecil dan dibesarkan sebagai rakyat biasa. Saat dihina, hanya Duryudana yang mengangkat derajatnya. Karena itu, Karna memilih loyalitas dan balas budi kepada Duryudana dibanding hubungan darah yang baru ia ketahui belakangan.',
    },
    {
      'tanya': 'Kenapa Krishna tidak langsung menghentikan perang saja?',
      'jawab': 'Krishna datang bukan untuk menghentikan takdir, tetapi untuk menegakkan dharma. Perang Bharatayuda dianggap sebagai cara untuk mengakhiri kejahatan yang sudah terlalu lama terjadi. Jadi perang ini adalah “pembersihan” dunia dari adharma.',
    },
    {
      'tanya': 'Apa sebenarnya isi ajaran Krishna pada Arjuna (Bhagavad Gita)?',
      'jawab': 'Krishna mengajarkan bahwa manusia harus menjalankan kewajibannya tanpa terikat hasil (karma yoga). Arjuna diajarkan bahwa sebagai ksatria, ia harus berperang demi kebenaran, bukan karena emosi atau kepentingan pribadi.',
    },
    {
      'tanya': 'Kenapa Abimanyu bisa masuk Cakravyuha tapi tidak bisa keluar?',
      'jawab': 'Abimanyu hanya mengetahui cara masuk formasi Cakravyuha sejak dalam kandungan, tapi tidak sempat mendengar cara keluar. Ia tetap maju demi tugas, namun akhirnya gugur karena dikeroyok. Ini menunjukkan keberanian tanpa pengetahuan lengkap bisa berakibat fatal.',
    },
    {
      'tanya': 'Kenapa Duryudana begitu membenci Pandava?',
      'jawab': 'Duryudana iri karena Pandawa lebih disukai rakyat, lebih kuat, dan lebih berbudi. Ditambah pengaruh Sengkuni, kebenciannya makin besar. Jadi akar masalahnya adalah iri hati + hasutan.',
    },
    {
      'tanya': 'Kenapa Yudistira yang dikenal jujur bisa kalah dalam permainan dadu?',
      'jawab': 'Yudistira terjebak dalam dharma sebagai raja yang tidak boleh menolak undangan. Namun ia juga punya kelemahan, yaitu suka berjudi. Sengkuni memanfaatkan hal ini dengan kecurangan. Ini menunjukkan bahwa bahkan orang baik tetap punya celah kelemahan.',
    },
    {
      'tanya': 'Kenapa Krishna melanggar aturan perang dalam Bharatayuda?',
      'jawab': 'Krishna memahami bahwa melawan kejahatan besar tidak selalu bisa dengan cara ideal. Ia membiarkan strategi seperti menjatuhkan Drona dengan tipu daya atau membunuh Karna saat tidak siap, karena tujuan utamanya adalah menegakkan dharma. Ini menunjukkan bahwa dalam kondisi tertentu, cara tidak sempurna bisa dipakai untuk mencapai tujuan yang benar.',
    },
    {
      'tanya': 'Kenapa Gandari mengutuk Krishna setelah perang berakhir?',
      'jawab': 'Gandari sangat berduka karena kehilangan semua anaknya (Kurawa). Ia menyalahkan Krishna karena dianggap bisa mencegah perang tetapi tidak melakukannya. Karena kesedihan dan kemarahannya, Gandari mengutuk bahwa kelak bangsa Yadawa (keluarga Krishna) juga akan hancur. Dan benar, di kemudian hari kutukan itu terjadi. Ini menunjukkan bahwa bahkan kemenangan besar tetap meninggalkan luka dan dendam yang panjang.',
    },
  ];

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
          'SERAT MAHABHARATA',
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
                'PERTANYAAN SEPUTAR MAHABHARATA',
                textAlign: TextAlign.center,
                style: AppTypography.headingMedium.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Mengungkap Rahasia, Konflik Besar, dan Plot Twist Mendalam di Balik Kisah Epik Mahabharata',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.accent,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
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

              // FAQ List - Purely static
              ..._staticFaq.map((faq) => _buildFaqItem(faq['tanya']!, faq['jawab']!)),

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

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.accent,
          title: Text(
            question,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                textAlign: TextAlign.justify,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDark.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
