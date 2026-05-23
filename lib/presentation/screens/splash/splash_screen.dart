import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'welcome_screen.dart';
import '../../widgets/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      _checkAuthAndNavigate();
    });
  }

  void _checkAuthAndNavigate() {
    if (!mounted) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final Widget destination = authProvider.isLoggedIn 
        ? const MainShell() 
        : const WelcomeScreen();
        
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
        settings: authProvider.isLoggedIn 
            ? const RouteSettings(name: '/main_shell') 
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ui/digital_gunungan_nobg.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(
                 begin: const Offset(0.92, 0.92),
                 end: const Offset(1.06, 1.06),
                 duration: 1800.ms,
                 curve: Curves.easeInOutSine,
               ),
              const SizedBox(height: 24),
              Text(
                'BHARATAWAYANG',
                style: AppTypography.headingMedium.copyWith(
                  letterSpacing: 4,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 16),
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
                  ).animate(onPlay: (controller) => controller.repeat())
                   .rotate(duration: 4000.ms),
                  const SizedBox(width: 8),
                  Container(
                    height: 1,
                    width: 40,
                    color: AppColors.accent.withValues(alpha: 0.5),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'SACRED MANUSCRIPT',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
