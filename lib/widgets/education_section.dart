import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../constants/app_constants.dart';
import '../models/portfolio_data.dart';
import '../models/portfolio_models.dart';
import 'common_widgets.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader( title: 'Education', gradTitle: 'Background'),
          ...PortfolioData.education.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _EduCard(edu: e),
              )),
        ],
      ),
    );
  }
}

class _EduCard extends StatefulWidget {
  final EducationModel edu;

  const _EduCard({required this.edu});

  @override
  State<_EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<_EduCard> {
  bool _visible = false;
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.edu.shortName),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > .2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 700),
        opacity: _visible ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 700),
          offset: _visible ? Offset.zero : const Offset(0, 0.2),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: _hovering ? 1.02 : 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.teal.withOpacity(
                      _hovering ? .5 : .18,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal.withOpacity(
                        _hovering ? .15 : .05,
                      ),
                      blurRadius: _hovering ? 20 : 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 3,
                      decoration: const BoxDecoration(
                        gradient: AppColors.gradient,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.teal
                                      .withOpacity(.1),
                                  border: Border.all(
                                    color: AppColors.teal
                                        .withOpacity(.3),
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${widget.edu.emoji} ${widget.edu.shortName}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color:
                                    AppColors.tealLight,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.edu.year,
                                style: const TextStyle(
                                  color:
                                  AppColors.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            widget.edu.degree,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color:
                              AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            widget.edu.field,
                            style: const TextStyle(
                              fontSize: 13,
                              color:
                              AppColors.textMuted,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              ShaderMask(
                                shaderCallback: (b) =>
                                    AppColors.gradient
                                        .createShader(b),
                                child: Text(
                                  widget.edu.cgpa
                                      .toString(),
                                  style:
                                  const TextStyle(
                                    fontSize: 36,
                                    fontWeight:
                                    FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                EdgeInsets.only(
                                  left: 6,
                                  bottom: 6,
                                ),
                                child: Text(
                                  '/ 10 CGPA',
                                  style: TextStyle(
                                    color:
                                    AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
