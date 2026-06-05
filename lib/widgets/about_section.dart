import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader( title: 'Who', gradTitle: 'I Am'),
          _AboutText(),
          const SizedBox(height: 28),
          const Text('Career Timeline',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          _Timeline(),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const paras = [
  " I’m a Flutter Developer with over a year of hands-on industry experience at Inciem Business Consultants.", "I’m passionate about building clean, performant, and visually appealing mobile applications using Flutter & Dart. I enjoy transforming complex business requirements into smooth, intuitive, and user-friendly app experiences", "I’m continuously improving my skills and exploring advanced Flutter patterns, state management, and scalable app architecture to build better and more efficient applications.",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...paras.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(p, style: const TextStyle(fontSize: 14, color: AppColors.textMuted, height: 1.8)),
            )),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PortfolioData.techTags.map((t) => TechChip(t)).toList(),
        ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(PortfolioData.timeline.length, (i) {
        final item = PortfolioData.timeline[i];
        final isLast = i == PortfolioData.timeline.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Line + dot
              SizedBox(
                width: 24,
                child: Column(
                  children: [
                    Container(
                      width: 9, height: 9,
                      decoration: const BoxDecoration(
                        gradient: AppColors.gradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1.5,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: const BoxDecoration(
                            gradient: AppColors.gradient,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['year']!,
                          style: const TextStyle(fontFamily: 'SpaceMono', fontSize: 10, color: AppColors.tealLight, letterSpacing: 0.6)),
                      const SizedBox(height: 3),
                      Text(item['role']!,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text(item['place']!,
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
