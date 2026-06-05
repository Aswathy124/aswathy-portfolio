import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/app_constants.dart';

class FloatingBadge extends StatefulWidget {
  final String text;

  const FloatingBadge({
    super.key,
    required this.text,
  });

  @override
  State<FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<FloatingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _offsetAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offsetAnimation.value),
          child: child,
        );
      },
      child: Container(
        padding:  EdgeInsets.symmetric(
          horizontal: 1.w,
          vertical:1.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff081A2D),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.teal.withOpacity(.3),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.teal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}