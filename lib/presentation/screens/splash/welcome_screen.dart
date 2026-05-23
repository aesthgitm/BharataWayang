import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo
              Image.asset(
                'assets/images/ui/digital_gunungan_nobg.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ).animate().fade(duration: 800.ms).scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeOutBack,
              ),
              const SizedBox(height: 24),
              // App Title
              Text(
                'BHARATAWAYANG',
                style: AppTypography.headingMedium.copyWith(
                  letterSpacing: 4,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ).animate().fade(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0.0),
              const SizedBox(height: 16),
              // Decorative Line
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: AppColors.accent.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.diamond_outlined,
                    color: AppColors.accent,
                    size: 12,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 1,
                    width: 40,
                    color: AppColors.accent.withValues(alpha: 0.5),
                  ),
                ],
              ).animate().fade(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2, end: 0.0),
              const SizedBox(height: 48),
              // Subtitle
              Text(
                'Jelajahi epik Mahabharata dalam\nbalutan estetika keraton modern.\nMulai perjalanan spiritual Anda.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.secondary,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ).animate().fade(delay: 450.ms, duration: 600.ms).slideY(begin: 0.2, end: 0.0),
              const Spacer(),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOutCubic;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MASUK',
                        style: AppTypography.buttonText.copyWith(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.login, size: 18),
                    ],
                  ),
                ),
              ).animate().fade(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2, end: 0.0),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const RegisterScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOutCubic;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.accent, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DAFTAR',
                        style: AppTypography.buttonText.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.person_add_outlined, size: 18, color: AppColors.accent),
                    ],
                  ),
                ),
              ).animate().fade(delay: 700.ms, duration: 600.ms).slideY(begin: 0.2, end: 0.0),
            ],
          ),
        ),
      ),
    );
  }
}
