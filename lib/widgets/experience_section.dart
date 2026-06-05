import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import '../models/portfolio_models.dart';
import 'common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader( title: 'Professional', gradTitle: 'Experience'),
          ...PortfolioData.experience.map((e) => _ExperienceCard(exp: e)),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel exp;
  const _ExperienceCard({required this.exp});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.tealLight.withOpacity(0.18)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left accent bar
          Container(
            width: 3,
            height: 100,
            constraints: const BoxConstraints(minHeight: 300),
            decoration: const BoxDecoration(
              gradient: AppColors.gradient,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exp.role,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                            const SizedBox(height: 3),
                            ShaderMask(
                              shaderCallback: (b) => AppColors.gradient.createShader(b),
                              child: Text(exp.company,
                                  style: const TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w700,
                                      color: Colors.white, fontFamily: 'SpaceMono', letterSpacing: 0.3)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _CurrentBadge(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Duration chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.08),
                      border: Border.all(color: AppColors.teal.withOpacity(0.25)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('🕐  ${exp.duration} · ${exp.period}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontFamily: 'SpaceMono')),
                  ),
                  const SizedBox(height: 14),
                  Text(exp.description,
                      style: const TextStyle(fontSize: 13.5, color: AppColors.textMuted, height: 1.75)),
                  const SizedBox(height: 14),
                  // Responsibilities
                  ...exp.responsibilities.map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('▹ ', style: TextStyle(color: AppColors.tealLight, fontSize: 12, height: 1.6)),
                            Expanded(
                              child: Text(r,
                                  style: const TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.6)),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 14),
                  // Tech stack
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: exp.techStack.map((t) => TechChip(t, blue: true)).toList(),
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

class _CurrentBadge extends StatefulWidget {
  @override
  State<_CurrentBadge> createState() => _CurrentBadgeState();
}

class _CurrentBadgeState extends State<_CurrentBadge> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _glow = Tween(begin: 0.0, end: 1.0).animate(_ctrl);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, __) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.teal.withOpacity(0.15 + _glow.value * 0.1),
          border: Border.all(color: AppColors.teal.withOpacity(0.4 + _glow.value * 0.3)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.teal.withOpacity(_glow.value * 0.25),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Text('🟢 Current',
            style: TextStyle(fontSize: 11, color: AppColors.tealLight, fontFamily: 'SpaceMono')),
      ),
    );
  }
}
