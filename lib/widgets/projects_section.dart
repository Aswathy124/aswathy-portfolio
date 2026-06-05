import 'package:flutter/cupertino.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/app_constants.dart';
import 'common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Personal',
            gradTitle: 'Projects',
          ),
          _ProjectCard(
            delay: 0,
            title: '🚌 Campus Navigator (MCA)',
            description:
            'Developed a Flutter-based mobile application with Node.js and MongoDB to digitize campus bus pass requests and concession card management. Features include pass purchases, transaction management, and faculty vehicle booking.',
            technologies: const [
              'Flutter',
              'Node.js',
              'MongoDB',
              'REST API',
            ],
          ),

          _ProjectCard(
            delay: 200,
            title: '🧠 Liver Disease Prediction Using Neural Networks (MCA)',
            description:
            'Built a machine learning model to predict liver disease risk using Neural Networks. Implemented with Python and Flask to improve early disease detection accuracy.',
            technologies: const [
              'Python',
              'Flask',
              'Machine Learning',
              'Neural Networks',
            ],
          ),

          _ProjectCard(
            delay: 400,
            title: '🧪 Advanced Lab Care Services (BCA)',
            description:
            'Developed a web platform for online laboratory service booking, including sample collection, registration, and report management.',
            technologies: const [
              'HTML',
              'CSS',
              'JavaScript',
              'SQL',
            ],
          ),

        ],
      ),
    );
  }
}
class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final int delay;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.technologies,
    this.delay = 0,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(
      Duration(milliseconds: widget.delay),
          () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: Matrix4.identity()
              ..translate(
                0.0,
                _isHovered ? -8.0 : 0.0,
              ),
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.teal.withOpacity(
                  _isHovered ? .6 : .25,
                ),
              ),
              boxShadow: _isHovered
                  ? [
                BoxShadow(
                  color: AppColors.teal.withOpacity(.20),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  widget.description,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 18),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.technologies
                      .map((tech) => TechChip(tech))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}