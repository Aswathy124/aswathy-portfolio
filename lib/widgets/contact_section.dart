import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';
import 'common_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose();
    _subjectCtrl.dispose(); _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _subjectCtrl.text.isEmpty ||
        _msgCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    final gmailUrl =
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=aswathykannan523@gmail.com'
        '&su=${Uri.encodeComponent(_subjectCtrl.text)}'
        '&body=${Uri.encodeComponent(
      'Name: ${_nameCtrl.text}\n'
          'Email: ${_emailCtrl.text}\n\n'
          '${_msgCtrl.text}',
    )}';

    await launchUrl(
      Uri.parse(gmailUrl),
      mode: LaunchMode.platformDefault,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader( title: "Let's", gradTitle: 'Connect'),
          // Social links
          _SocialLink(icon: 'in', label: 'LinkedIn', sub:AppStrings.linkedin, url: AppStrings.linkedin),
          const SizedBox(height: 10),
          _SocialLink(icon: 'GH', label: 'GitHub', sub: AppStrings.github, url: AppStrings.github),
          const SizedBox(height: 10),
          _SocialLink(icon: '✉', label: 'Email', sub: AppStrings.email, url: 'mailto:${AppStrings.email}'),
       SizedBox(height: 4.h),
          // Form
          _FormField(label: 'Your Name', ctrl: _nameCtrl, hint: 'John Doe'),
          const SizedBox(height: 12),
          _FormField(label: 'Email Address', ctrl: _emailCtrl, hint: 'john@company.com', keyboard: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _FormField(label: 'Subject', ctrl: _subjectCtrl, hint: 'Flutter Developer Opportunity'),
          const SizedBox(height: 12),
          _FormField(label: 'Message', ctrl: _msgCtrl, hint: 'Tell me about the  project...', maxLines: 5),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _sent ? null : () async => await _submit(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                gradient: _sent
                    ? const LinearGradient(colors: [AppColors.tealDark, AppColors.blueDark])
                    : AppColors.gradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _sent ? '✓  Message Sent!' : 'Send Message  →',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String icon, label, sub, url;
  const _SocialLink({required this.icon, required this.label, required this.sub, required this.url});
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        openUrl(url);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.tealLight.withOpacity(0.18)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(gradient: AppColors.gradient, shape: BoxShape.circle),
              child: Center(child: Text(icon, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13))),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 13, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label, hint;
  final TextEditingController ctrl;
  final int maxLines;
  final TextInputType keyboard;

  const _FormField({
    required this.label,
    required this.ctrl,
    required this.hint,
    this.maxLines = 1,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: const TextStyle(fontFamily: 'SpaceMono', fontSize: 10, color: AppColors.textMuted, letterSpacing: 0.8)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboard,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0x557DA8C0)),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.tealLight.withOpacity(0.18)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.tealLight.withOpacity(0.18)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.tealLight, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
