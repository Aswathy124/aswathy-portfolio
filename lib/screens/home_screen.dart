import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/app_constants.dart';
import '../widgets/about_section.dart';
import '../widgets/common_widgets.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  final Map<String, GlobalKey> _keys = {
    'hero': GlobalKey(),
    'skills': GlobalKey(),
    'education': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };

  int _activeTab = 0;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();

    _scrollCtrl.addListener(() {
      final showFab = _scrollCtrl.offset > 300;

      if (showFab != _showFab && mounted) {
        setState(() {
          _showFab = showFab;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollTo(String key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _keys[key]?.currentContext;

      if (context == null) return;

      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _scrollToTop() {
    _scrollCtrl.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      floatingActionButton: _showFab
          ? FloatingActionButton.small(
        onPressed: _scrollToTop,
        backgroundColor: AppColors.teal,
        child: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
      )
          : null,

      body: Column(
        children: [
          _NavBar(
            activeTab: _activeTab,
            onTab: (key, index) {
              setState(() {
                _activeTab = index;
              });

              _scrollTo(key);
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              child: Column(
                children: [
                  KeyedSubtree(
                    key: _keys['hero'],
                    child: HeroSection(
                      onHireMe: () {
                        setState(() {
                          _activeTab = 6;
                        });

                        _scrollTo('contact');
                      },
                      onViewExperience: () {
                        setState(() {
                          _activeTab = 3;
                        });

                        _scrollTo('experience');
                      },
                    ),
                  ),

                  KeyedSubtree(
                    key: _keys['skills'],
                    child: const SkillsSection(),
                  ),

                  KeyedSubtree(
                    key: _keys['education'],
                    child: const EducationSection(),
                  ),

                  KeyedSubtree(
                    key: _keys['experience'],
                    child: const ExperienceSection(),
                  ),

                  KeyedSubtree(
                    key: _keys['projects'],
                    child: const ProjectsSection(),
                  ),

                  KeyedSubtree(
                    key: _keys['about'],
                    child: const AboutSection(),
                  ),

                  KeyedSubtree(
                    key: _keys['contact'],
                    child: const ContactSection(),
                  ),

                  const _Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBar extends StatefulWidget {
  final void Function(String key, int index) onTab;
  final int activeTab;

  const _NavBar({
    required this.onTab,
    required this.activeTab,
  });

  @override
  State<_NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<_NavBar> {
  int _hoveredIndex = -1;

  static const tabs = [
    ('hero', 'Home'),
    ('skills', 'Skills'),
    ('education', 'Education'),
    ('experience', 'Work'),
    ('projects', 'Projects'),
    ('about', 'About'),
    ('contact', 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    if (isMobile) {
      return SafeArea(
        child: Container(
          height: 60,
          color: AppColors.bg,
          child: Row(
            children: [
              SizedBox(width: 2.w),
              Text(
                "<Build. Learn. Grow>",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
              const Spacer(),
              PopupMenuButton<int>(
                icon: const Icon(Icons.menu, color: Colors.white),
                onSelected: (index) {
                  widget.onTab(tabs[index].$1, index);
                },
                itemBuilder: (context) => List.generate(
                  tabs.length,
                      (index) => PopupMenuItem(
                    value: index,
                    child: Text(tabs[index].$2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ---------------- DESKTOP NAVBAR ----------------
    return Container(
      color: AppColors.bg,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 65,
          child: Row(
            children: [
              Text(
                "<Build. Learn. Grow>",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),

              SizedBox(width: 5.w),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    final tab = tabs[index];
                    final selected = widget.activeTab == index;
                    final hovered = _hoveredIndex == index;

                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredIndex = index),
                      onExit: (_) => setState(() => _hoveredIndex = -1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 10,
                        ),
                        curve: Curves.easeOut,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () =>
                                widget.onTab(tab.$1, index),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 200),
                              scale: hovered ? 1.05 : 1.0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selected
                                      ? AppColors.teal
                                      : hovered
                                      ? AppColors.teal.withOpacity(0.15)
                                      : Colors.transparent,
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : hovered
                                        ? AppColors.teal
                                        : AppColors.textMuted,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                  child: Text(tab.$2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      padding: const EdgeInsets.all(24),
      child: const Column(
        children: [
          GradientDivider(),
          SizedBox(height: 16),
          Text(
            'Built with Flutter',
            style: TextStyle(
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 8),

        ],
      ),
    );
  }
}