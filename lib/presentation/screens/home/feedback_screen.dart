import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/database/database_helper.dart';
import '../../../providers/auth_provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = 'Tampilan';
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildCategoryButton(String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.textDark.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          category,
          style: AppTypography.bodyMedium.copyWith(
            color: isSelected ? AppColors.textDark : AppColors.textDark.withValues(alpha: 0.6),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

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
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'BHARATAWAYANG',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              fontSize: 14,
            ),
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
                'SARAN & MASUKAN',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              Text(
                'Sampaikan pemikiran Anda mengenai pengalaman menjelajahi dunia wayang. Suara Anda berharga bagi pelestarian budaya ini.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDark.withValues(alpha: 0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Form Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLabel('Nama Lengkap'),
                    const SizedBox(height: 8),
                    _buildTextField(_nameController, 'Nama Anda'),
                    
                    const SizedBox(height: 20),
                    
                    _buildLabel('Email'),
                    const SizedBox(height: 8),
                    _buildTextField(_emailController, 'email@contoh.com'),
                    
                    const SizedBox(height: 20),
                    
                    _buildLabel('Kategori Masukan'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildCategoryButton('Isi Cerita')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildCategoryButton('Tampilan')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildCategoryButton('Teknis')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildCategoryButton('Lainnya')),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel('Pesan Anda'),
                        const Icon(Icons.edit, size: 14, color: AppColors.textDark),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _messageController,
                      maxLines: 5,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
                      decoration: InputDecoration(
                        hintText: 'Tuliskan saran atau masukan Anda di sini...',
                        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textDark.withValues(alpha: 0.4)),
                        filled: true,
                        fillColor: AppColors.secondary.withValues(alpha: 0.5),
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.accent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.3))),
                        const SizedBox(width: 8),
                        const Icon(Icons.diamond_outlined, color: AppColors.accent, size: 12),
                        const SizedBox(width: 8),
                        Expanded(child: Container(height: 1, color: AppColors.accent.withValues(alpha: 0.3))),
                      ],
                    ),
                    
                    const SizedBox(height: 24),

                    // Tombol Kirim
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _isSending
                            ? null
                            : () async {
                                final name = _nameController.text.trim();
                                final email = _emailController.text.trim();
                                final message = _messageController.text.trim();

                                if (name.isEmpty || message.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Nama dan pesan masukan tidak boleh kosong!',
                                        style: AppTypography.bodyMedium.copyWith(color: AppColors.secondary),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                setState(() => _isSending = true);

                                try {
                                  // Mendapatkan User ID dari AuthProvider
                                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                  final userId = authProvider.currentUser?.id;

                                  // Menyimpan feedback ke database lokal
                                  final db = await DatabaseHelper.instance.database;
                                  await db.insert('feedback', {
                                    'user_id': userId,
                                    'isi_feedback': 'Nama: $name\nEmail: $email\nKategori: $_selectedCategory\nMasukan: $message',
                                    'dikirim_pada': DateTime.now().toIso8601String(),
                                  });
                                } catch (e) {
                                  debugPrint("Gagal menyimpan feedback ke database: $e");
                                }

                                // Simulasi jeda waktu pengiriman ke server
                                await Future.delayed(const Duration(seconds: 1));

                                if (!context.mounted) return;
                                setState(() => _isSending = false);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Terima kasih atas masukannya, $name! Masukan Anda sangat berharga bagi kami. ✓',
                                      style: AppTypography.bodyMedium.copyWith(color: AppColors.secondary),
                                    ),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isSending) ...[
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              _isSending ? 'MENGIRIM...' : 'KIRIM',
                              style: AppTypography.buttonText.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (!_isSending) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.play_arrow, size: 14, color: AppColors.primary),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.labelText.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textDark.withValues(alpha: 0.4)),
        filled: true,
        fillColor: AppColors.secondary.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.accent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
