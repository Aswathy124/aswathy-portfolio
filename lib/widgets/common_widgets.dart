import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

// ── GRADIENT TEXT ──────────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const GradientText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.gradient.createShader(bounds),
      child: Text(text, style: (style ?? const TextStyle()).copyWith(color: Colors.white)),
    );
  }
}

// ── GRADIENT BUTTON ────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool outline;
  const GradientButton({super.key, required this.label, required this.onTap, this.outline = false});

  @override
  Widget build(BuildContext context) {
    if (outline) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tealLight.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(label, style: const TextStyle(color: AppColors.tealLight, fontWeight: FontWeight.w600, fontSize: 14)),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
      ),
    );
  }
}

// ── SECTION HEADER ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {

  final String title;
  final String gradTitle;
  const SectionHeader({super.key, required this.title, required this.gradTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: AppColors.textPrimary),
            children: [
              TextSpan(text: '$title '),
              WidgetSpan(
                child: ShaderMask(
                  shaderCallback: (b) => AppColors.gradient.createShader(b),
                  child: Text(gradTitle,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ── GRADIENT BADGE ─────────────────────────────────────────────
class GradientBadge extends StatelessWidget {
  final String text;
  final bool pulseDot;
  const GradientBadge({super.key, required this.text, this.pulseDot = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.teal.withOpacity(0.1),
        border: Border.all(color: AppColors.teal.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pulseDot) ...[
            _PulseDot(),
            const SizedBox(width: 8),
          ],
          Text(text,
              style: const TextStyle(
                  fontFamily: 'SpaceMono', fontSize: 11, color: AppColors.tealLight, letterSpacing: 0.6)),
        ],
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _anim = Tween(begin: 1.0, end: 0.25).animate(_ctrl);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.tealLight, shape: BoxShape.circle)),
    );
  }
}

// ── GLASS CARD ─────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  const GlassCard({super.key, required this.child, this.padding, this.radius = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.tealLight.withOpacity(0.18)),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}

// ── TECH TAG CHIP ──────────────────────────────────────────────
class TechChip extends StatelessWidget {
  final String label;
  final bool blue;
  const TechChip(this.label, {super.key, this.blue = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (blue ? AppColors.blue : AppColors.teal).withOpacity(0.1),
        border: Border.all(color: (blue ? AppColors.blue : AppColors.teal).withOpacity(0.32)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label,
          style: TextStyle(
              fontFamily: 'SpaceMono',
              fontSize: 11,
              color: blue ? AppColors.blueLight : AppColors.tealLight)),
    );
  }
}

// ── GRADIENT DIVIDER ───────────────────────────────────────────
class GradientDivider extends StatelessWidget {
  const GradientDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: const BoxDecoration(gradient: AppColors.gradient),
    );
  }
}
