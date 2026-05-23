import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConfettiParticle {
  final Color color;
  double x, y;
  double vx, vy;
  final double size;
  double rotation;
  final double rotationSpeed;
  double opacity = 1.0;
  final double decayRate;

  ConfettiParticle({
    required this.color,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.decayRate,
  });

  void update(double dt) {
    x += vx * dt;
    y += vy * dt;
    vy += 150.0 * dt; // Gravity vertical pull
    vx *= 0.98;       // Air resistance friction
    rotation += rotationSpeed * dt;
    opacity = (opacity - decayRate * dt).clamp(0.0, 1.0);
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      if (p.opacity <= 0) continue;
      paint.color = p.color.withValues(alpha: p.opacity);
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ConfettiWidget extends StatefulWidget {
  final bool active;
  const ConfettiWidget({super.key, required this.active});

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (widget.active) {
      _generateParticles();
      _controller.repeat();
    }
  }

  void _generateParticles() {
    final colors = [
      Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.pink, Colors.orange, Colors.purple, Colors.cyan, Colors.amber
    ];
    final random = math.Random();
    
    // Generate particles on left and right borders shooting upwards and inwards
    for (int i = 0; i < 35; i++) {
      // Left side launcher
      _particles.add(
        ConfettiParticle(
          color: colors[random.nextInt(colors.length)],
          x: -10,
          y: 450,
          vx: random.nextDouble() * 320 + 120,    // Moves rightwards
          vy: -random.nextDouble() * 450 - 250,   // Shoots upwards
          size: random.nextDouble() * 8 + 6,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 6 - 3.0,
          decayRate: random.nextDouble() * 0.15 + 0.15, // decay rate between 0.15 and 0.30
        ),
      );
      // Right side launcher
      _particles.add(
        ConfettiParticle(
          color: colors[random.nextInt(colors.length)],
          x: 450, // Updated dynamically in LayoutBuilder
          y: 450,
          vx: -random.nextDouble() * 320 - 120,   // Moves leftwards
          vy: -random.nextDouble() * 450 - 250,   // Shoots upwards
          size: random.nextDouble() * 8 + 6,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 6 - 3.0,
          decayRate: random.nextDouble() * 0.15 + 0.15, // decay rate between 0.15 and 0.30
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust right side X positions dynamically based on screen width
        if (_particles.isNotEmpty && _particles[0].x == -10 && _particles[1].x == 450) {
          for (int i = 0; i < _particles.length; i++) {
            if (i % 2 == 1) { // Right side launcher particles
              _particles[i].x = constraints.maxWidth + 10;
            }
          }
        }
        
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            const double dt = 0.016; // Approx. frame duration
            bool anyVisible = false;
            for (final p in _particles) {
              p.update(dt);
              if (p.opacity > 0 && p.y < constraints.maxHeight) {
                anyVisible = true;
              }
            }
            
            // Stop the ticker once all particles are fully faded out/off-screen to conserve battery/CPU
            if (!anyVisible && _controller.isAnimating) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && _controller.isAnimating) {
                  _controller.stop();
                }
              });
            }

            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ConfettiPainter(_particles),
            );
          },
        );
      },
    );
  }
}
