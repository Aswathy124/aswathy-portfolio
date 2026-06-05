import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolia/widgets/floating_badge.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onHireMe;
  final VoidCallback onViewExperience;
  const HeroSection({super.key, required this.onHireMe, required this.onViewExperience});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

    return Container(
      width: double.infinity,
      color: AppColors.bg,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.6, -0.2),
                  radius: 1.2,
                  colors: [AppColors.blue.withOpacity(0.18), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.7, 0.6),
                  radius: 1.0,
                  colors: [AppColors.teal.withOpacity(0.13), Colors.transparent],
                ),
              ),
            ),
          ),
          isWide
              ? _WideLayout(onHireMe: onHireMe, onViewExperience: onViewExperience)
              : _NarrowLayout(onHireMe: onHireMe, onViewExperience: onViewExperience),
        ],
      ),
    );
  }
}

// ── WIDE LAYOUT (phone on right) ───────────────────────────────
class _WideLayout extends StatelessWidget {
  final VoidCallback onHireMe;
  final VoidCallback onViewExperience;
  const _WideLayout({required this.onHireMe, required this.onViewExperience});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 80, 48, 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left content
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GradientBadge(text: 'Open to Flutter Opportunities', pulseDot: true),
                const SizedBox(height: 20),
                const _TypewriterTitle(),
                const SizedBox(height: 14),
                const Text(
                  AppStrings.heroBio,
                  style: TextStyle(fontSize: 15, color: AppColors.textMuted, height: 1.75),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    GradientButton(label: 'View Experience', onTap: onViewExperience),
                    GradientButton(label: "Let's Connect", onTap: onHireMe, outline: true),
                  ],
                ),
                const SizedBox(height: 30),
                _StatsRow(),
              ],
            ),
          ),
          const SizedBox(width: 40),
          // Right: Phone mockup
           Expanded(
  flex: 4,
  child: SizedBox(
    height: 500,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [

       SizedBox(height: 10.h),

        SizedBox(
          width: isMobile ? 300 : 420,
          height: isMobile ? 420 : 500,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const _PhoneMockup(),

              Positioned(
                left: isMobile ? -20 : 0,
                top: isMobile ? 180 : 260,
                child: const FloatingBadge(
                  text: "🧩 Getx",
                ),
              ),

              Positioned(
                right: isMobile ? -20 : 0,
                top: isMobile ? 60 : 120,
                child: const FloatingBadge(
                  text: "🎯 Flutter",
                ),
              ),

              Positioned(
                right: isMobile ? -20 : -10,
                bottom: isMobile ? 50 : 110,
                child: const FloatingBadge(
                  text: "🚀 Play Store",
                ),
              ),
            ],
          ),
        )
      ],
    ),
  ),
),
        ],
      ),
    );
  }
}

// ── NARROW LAYOUT (phone below, original mobile) ───────────────
class _NarrowLayout extends StatelessWidget {
  final VoidCallback onHireMe;
  final VoidCallback onViewExperience;
  const _NarrowLayout({required this.onHireMe, required this.onViewExperience});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 100, 22, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientBadge(text: 'Open to Flutter Opportunities', pulseDot: true),
          const SizedBox(height: 20),
          const _TypewriterTitle(),
          const SizedBox(height: 14),
          const Text(
            AppStrings.heroBio,
            style: TextStyle(fontSize: 15, color: AppColors.textMuted, height: 1.75),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GradientButton(label: 'View Experience', onTap: onViewExperience),
              GradientButton(label: "Let's Connect", onTap: onHireMe, outline: true),
            ],
          ),
          const SizedBox(height: 30),
          _StatsRow(),
          SizedBox(height: 10.h),

          Center(
            child: SizedBox(
              width: 320,
              height: 450,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const _PhoneMockup(),

                  Positioned(
                    left: -35,
                    top: 180,
                    child: FloatingBadge(
                      text: "🧩 Getx",
                    ),
                  ),

                  Positioned(
                    right: -25,
                    top: 90,
                    child: FloatingBadge(
                      text: "🎯 Flutter",
                    ),
                  ),

                  Positioned(
                    right: -20,
                    bottom: 120,
                    child: FloatingBadge(
                      text: "🚀 Play Store",
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

// ── GRID BACKGROUND ────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.tealLight.withOpacity(0.04)
      ..strokeWidth = 0.8;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── TYPEWRITER TITLE ───────────────────────────────────────────
class _TypewriterTitle extends StatefulWidget {
  const _TypewriterTitle();

  @override
  State<_TypewriterTitle> createState() => _TypewriterTitleState();
}

class _TypewriterTitleState extends State<_TypewriterTitle> {
  static const _words = ['Developer', 'Engineer', 'Problem Solver'];
  int _wordIndex = 0;
  String _displayed = '';
  bool _deleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startTyping();
    });
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 110), (_) {
      if (!mounted) return;
      final target = _words[_wordIndex];
      setState(() {
        if (!_deleting) {
          if (_displayed.length < target.length) {
            _displayed = target.substring(0, _displayed.length + 1);
          } else {
            _deleting = true;
          }
        } else {
          if (_displayed.isNotEmpty) {
            _displayed = _displayed.substring(0, _displayed.length - 1);
          } else {
            _deleting = false;
            _wordIndex = (_wordIndex + 1) % _words.length;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Flutter',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.1,
            letterSpacing: -1.5,
          ),
        ),
        Row(
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.gradient.createShader(b),
              child: Text(
                _displayed,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
            ),
            _BlinkingCursor(),
          ],
        ),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> {
  bool _visible = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _timer = Timer.periodic(const Duration(milliseconds: 530), (_) {
        if (mounted) setState(() => _visible = !_visible);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        width: 2.5,
        height: 36,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ── STATS ROW ──────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0x301D9E75))),
      ),
      child: Row(
        children: PortfolioData.stats
            .map(
              (s) => Expanded(
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (b) => AppColors.gradient.createShader(b),
                      child: Text(
                        s.value,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      s.label,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted, letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ── PHONE MOCKUP ───────────────────────────────────────────────
class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 420,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.teal, width: 2),
        boxShadow: [
          BoxShadow(color: AppColors.teal.withOpacity(0.2), blurRadius: 40, spreadRadius: 2),
          BoxShadow(color: AppColors.blue.withOpacity(0.1), blurRadius: 80, spreadRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            // Notch
            Container(
              height: 20,
              width: 65,
              decoration: const BoxDecoration(
                color: Color(0xFF08101F),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Header card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: AppColors.gradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Flutter Portfolio',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              Text('Good morning, Dev 👋',
                                  style: TextStyle(fontSize: 9, color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Skill cards
                    ...[
                      ('📱', 'Flutter & Dart', 'Cross-platform', 0.90),
                      ('🔥', 'Firebase', 'Auth, Firestore', 0.82),
                      ('🧩', 'BLoC/Riverpod', 'State mgmt', 0.78),
                      ('🎓', 'MCA Graduate', 'CGPA 7.5', 0.75),
                    ].map(
                      (d) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _MockCard(
                            icon: d.$1, title: d.$2, sub: d.$3, pct: d.$4 as double),
                      ),
                    ),
                    const Spacer(),
                    // Bottom nav dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _NavDot(active: true),
                        _NavDot(),
                        _NavDot(),
                        _NavDot(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockCard extends StatelessWidget {
  final String icon, title, sub;
  final double pct;
  const _MockCard(
      {required this.icon, required this.title, required this.sub, required this.pct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        border: Border.all(color: AppColors.tealLight.withOpacity(0.12)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    gradient: AppColors.gradient,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 10))),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    Text(sub,
                        style: const TextStyle(fontSize: 8, color: AppColors.textMuted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 2.5,
              backgroundColor: Colors.white.withOpacity(0.07),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavDot extends StatelessWidget {
  final bool active;
  const _NavDot({this.active = false});

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Container(
        width: 16,
        height: 6,
        decoration: BoxDecoration(
            gradient: AppColors.gradient, borderRadius: BorderRadius.circular(3)),
      );
    }
    return Container(
      width: 6,
      height: 6,
      decoration:
          const BoxDecoration(color: Color(0x33FFFFFF), shape: BoxShape.circle),
    );
  }
}