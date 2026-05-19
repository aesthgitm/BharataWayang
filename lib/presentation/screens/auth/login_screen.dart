import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'register_screen.dart';
import '../../widgets/main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // Assuming authProvider uses username/email
      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MainShell(),
            settings: const RouteSettings(name: '/main_shell'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login gagal'),
            backgroundColor: AppColors.highlight,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(color: AppColors.accent, width: 1),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/ui/digital_gunungan_nobg.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'BHARATAWAYANG',
                      style: AppTypography.headingSmall.copyWith(
                        letterSpacing: 3,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Decorative Line
                    Container(
                      height: 1,
                      width: 40,
                      color: AppColors.accent.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'MASUK',
                      style: AppTypography.headingLarge.copyWith(
                        letterSpacing: 4,
                        color: AppColors.textDark,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masuk ke Akun Ksatria-mu',
                      style: AppTypography.bodyMedium.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textDark.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildInputLabel('EMAIL'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
                      decoration: InputDecoration(
                        hintText: 'nama@email.id',
                        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textDark.withValues(alpha: 0.3)),
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.accent),
                        fillColor: AppColors.secondary,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.accent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.accent, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildInputLabel('KATA SANDI'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textDark.withValues(alpha: 0.3)),
                        prefixIcon: const Icon(Icons.key, color: AppColors.accent),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.accent,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        fillColor: AppColors.secondary,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.accent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.accent, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata sandi tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Lupa Kata Sandi?',
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          return ElevatedButton(
                            onPressed: auth.isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.secondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: auth.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.secondary,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'MASUK',
                                        style: AppTypography.buttonText.copyWith(
                                          color: AppColors.secondary,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.login, size: 18, color: AppColors.secondary),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum memiliki akun? ',
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.textDark),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            'DAFTAR SEKARANG',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTypography.labelText.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
