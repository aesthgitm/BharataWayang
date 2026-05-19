import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SeratDetailScreen extends StatelessWidget {
  final String title;

  const SeratDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTypography.headingMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.accent),
            const SizedBox(height: 16),
            Text(
              'Teks narasi untuk lakon $title akan dimuat dari database secara dinamis. Narasi ini menceritakan peristiwa epik Mahabharata yang disesuaikan dengan pakem pewayangan Jawa, seperti kisah Bale Sigala-gala atau gugurnya pahlawan di medan Kurusetra.',
              style: AppTypography.bodyLarge.copyWith(height: 1.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Pada akhir narasi, pengguna akan mendapatkan pencapaian dan mungkin membuka Mustika Wayang baru yang terkait dengan tokoh dalam lakon ini.',
              style: AppTypography.bodyLarge.copyWith(height: 1.6, fontStyle: FontStyle.italic, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                // Tandai selesai dan kembali
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Babak ditandai selesai!')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Tandai Selesai Dibaca'),
            )
          ],
        ),
      ),
    );
  }
}
