import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class KelolaProfilScreen extends StatefulWidget {
  const KelolaProfilScreen({super.key});

  @override
  State<KelolaProfilScreen> createState() => _KelolaProfilScreenState();
}

class _KelolaProfilScreenState extends State<KelolaProfilScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    _nameController = TextEditingController(text: user?.namaLengkap ?? user?.username ?? "Arjuna Dananjaya");
    _emailController = TextEditingController(text: "arjuna@pandawa.id");
    _bioController = TextEditingController(text: "Ksatria Pandawa • Penikmat Serat");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
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
          'KELOLA PROFIL',
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
              // Avatar with Edit Badge
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accent, width: 3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/ui/digital_gunungan_nobg.png',
                          fit: BoxFit.contain,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondary, width: 2),
                      ),
                      child: const Icon(Icons.edit, color: AppColors.primary, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Nama
              Text(
                'RADEN ARJUNA',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),

              // Form Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.secondary, // Krem
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormField(
                      label: 'NAMA LENGKAP',
                      icon: Icons.badge_outlined,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'EMAIL',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'BIO',
                      icon: Icons.military_tech_outlined,
                      controller: _bioController,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Simpan Button
                    ElevatedButton.icon(
                      onPressed: () async {
                        final authProvider = context.read<AuthProvider>();
                        final success = await authProvider.updateProfile(_nameController.text);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success ? 'Profil berhasil diperbarui!' : 'Gagal memperbarui profil: ${authProvider.errorMessage ?? ""}',
                              style: AppTypography.bodyMedium.copyWith(color: AppColors.secondary),
                            ),
                            backgroundColor: success ? AppColors.primary : Colors.red,
                          ),
                        );
                        if (success) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.save, size: 18),
                      label: Text(
                        'SIMPAN PERUBAHAN',
                        style: AppTypography.buttonText.copyWith(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for floating nav if any
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.labelText.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: AppTypography.bodyLarge.copyWith(color: AppColors.textDark),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
