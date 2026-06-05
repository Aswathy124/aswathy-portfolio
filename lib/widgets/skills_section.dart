import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import '../models/portfolio_models.dart';
import 'common_widgets.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import '../models/portfolio_models.dart';
import 'common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Technical',
            gradTitle: 'Skills',
          ),

          SizedBox(height: 3.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.skills.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent:
              Device.screenType == ScreenType.mobile
                  ? 250
                  : 280,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio:
              Device.screenType == ScreenType.mobile
                  ? 1.05
                  : 0.95,
            ),
            itemBuilder: (_, index) {
              return _SkillCard(
                skill: PortfolioData.skills[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;

  const _SkillCard({
    required this.skill,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim;

  bool _visible = false;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _progressAnim = Tween<double>(
      begin: 0,
      end: widget.skill.percentage,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _startAnimation() {
    if (!_visible) {
      _visible = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.skill.name),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > .2) {
          _startAnimation();
        }
      },
      child: FadeInUp(
        duration: const Duration(milliseconds: 700),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: _hovering ? 1.04 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(
                Device.screenType == ScreenType.mobile
                    ? 14
                    : 22,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.teal.withOpacity(
                    _hovering ? .6 : .15,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.teal.withOpacity(
                      _hovering ? .15 : .05,
                    ),
                    blurRadius: _hovering ? 20 : 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.skill.icon,
                    style: TextStyle(
                      fontSize: Device.screenType ==
                          ScreenType.mobile
                          ? 20.sp
                          : 15.sp,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    widget.skill.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: Device.screenType ==
                          ScreenType.mobile
                          ? 15.sp
                          : 16.sp,
                    ),
                  ),

                  SizedBox(height: 1.5.h),

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        widget.skill.level,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '${(widget.skill.percentage * 100).toInt()}%',
                        style: TextStyle(
                          color: AppColors.teal,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  AnimatedBuilder(
                    animation: _progressAnim,
                    builder: (_, __) {
                      return ClipRRect(
                        borderRadius:
                        BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: _progressAnim.value,
                          minHeight: 5,
                          backgroundColor:
                          Colors.white.withOpacity(
                            .08,
                          ),
                          valueColor:
                          const AlwaysStoppedAnimation(
                            AppColors.teal,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}