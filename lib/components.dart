// COMPONENTS — Flutter Web Workshop
// All text elements now appear with a gentle“typewriter” animation
// using the `animated_text_kit` package.
// ------------------------------------------------------------
// pubspec.yaml dependency:
//   animated_text_kit: ^4.2.2
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:html' as html;

// ─────────────────────────────────────────────────────────────
//  HELPER: single‑line typewriter text
// ─────────────────────────────────────────────────────────────
class TypeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  const TypeText(
    this.text, {
    required this.style,
    this.speed = const Duration(milliseconds: 100),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: style,
          speed: speed,
          cursor: '▌',
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STAGGERED HEADER
// ─────────────────────────────────────────────────────────────
class StaggeredHeader extends StatelessWidget {
  final String title;
  final bool lineBefore; // if true short line appears before text
  const StaggeredHeader(this.title, {this.lineBefore = false, super.key});

  @override
  Widget build(BuildContext context) {
    final beforeFlex = lineBefore ? 1 : 15;
    final afterFlex = lineBefore ? 15 : 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: beforeFlex,
            child: const Divider(color: Colors.white54, thickness: 1),
          ),
          const SizedBox(width: 8),
          TypeText(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: afterFlex,
            child: const Divider(color: Colors.white54, thickness: 1),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  IMAGE WITH GLOW
// ─────────────────────────────────────────────────────────────
class GlowImage extends StatelessWidget {
  final String assetPath;
  final double width, height;
  final BoxFit fit;
  final BoxShadow shadow;
  const GlowImage({
    required this.assetPath,
    required this.width,
    required this.height,
    required this.shadow,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [shadow]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(assetPath, width: width, height: height, fit: fit),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
//  EXPERIENCE CARD
// ─────────────────────────────────────────────────────────────
class ExperienceSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tasks;
  const ExperienceSection({required this.title, required this.subtitle, required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypeText(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TypeText(
          subtitle,
          style: const TextStyle(color: Colors.white54),
        ),
        const SizedBox(height: 8),
        if (tasks.isNotEmpty) ...[
          TypeText('My tasks include:', style: const TextStyle(color: Colors.white70)),
          for (final t in tasks)
            TypeText('• $t', style: const TextStyle(color: Colors.white70), speed: const Duration(milliseconds: 20)),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  PROJECT CARD
// ─────────────────────────────────────────────────────────────
class ProjectCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String techLine;
  final double aspectRatio;
  final bool reverse;
  const ProjectCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.techLine,
    this.aspectRatio = 16 / 9,
    this.reverse = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageShadow = const BoxShadow(color: Colors.white24, blurRadius: 20, spreadRadius: 4);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        textDirection: reverse ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [imageShadow]),
                child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(imagePath, fit: BoxFit.cover)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeText(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TypeText(description, style: const TextStyle(color: Colors.white70)),
                if (techLine.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  TypeText(techLine, style: const TextStyle(color: Colors.white54)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SECTION HEADER (centered)
// ─────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
          const SizedBox(width: 12),
          TypeText(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            speed: const Duration(milliseconds: 30),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
        ]),
      );
}

// ─────────────────────────────────────────────────────────────
//  NAV BUTTON
// ─────────────────────────────────────────────────────────────
class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const NavButton(this.label, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: TypeText(label, style: const TextStyle(color: Colors.white)),
      );
}

// ─────────────────────────────────────────────────────────────
//  SOCIAL ICON + LABEL
// ─────────────────────────────────────────────────────────────
class SocialItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  const SocialItem({required this.icon, required this.label, required this.url, super.key});

  void _launch() => html.window.open(url, '_blank');

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: _launch,
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 4),
              TypeText(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
//  EMAIL BUTTON (opens dialog then mailto:)
// ─────────────────────────────────────────────────────────────
class EmailButton extends StatelessWidget {
  final String toAddress;
  final String label;
  final Color accentColor;
  const EmailButton({required this.toAddress, required this.label, this.accentColor = Colors.cyanAccent, super.key});

  void _openEmailDialog(BuildContext context) {
    final subjectCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.grey[900],
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TypeText('Send me an email', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                _styledField(label: 'Subject', ctrl: subjectCtrl),
                const SizedBox(height: 16),
                _styledField(label: 'Message', ctrl: bodyCtrl, maxLines: 5),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel', style: TextStyle(color: Colors.white70))),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: accentColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        final subject = Uri.encodeComponent(subjectCtrl.text);
                        final body = Uri.encodeComponent(bodyCtrl.text);
                        html.window.open('mailto:$toAddress?subject=$subject&body=$body', '_self');
                        Navigator.of(context).pop();
                      },
                      child: const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), child: Text('Send', style: TextStyle(color: Colors.black))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledField({required String label, required TextEditingController ctrl, int maxLines = 1}) => TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(borderSide: BorderSide(color: accentColor), borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentColor, width: 2), borderRadius: BorderRadius.circular(8)),
        ),
      );

  @override
  Widget build(BuildContext context) => OutlinedButton(
        onPressed: () => _openEmailDialog(context),
        style: OutlinedButton.styleFrom(side: BorderSide(color: accentColor), foregroundColor: accentColor),
        child: TypeText(label, style: const TextStyle()),
      );
}
