// lib/components.dart

library components;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ─── REUSABLE NAV BUTTON ─────────────────────────────────
class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const NavButton(this.label, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) => TextButton(
        onPressed: onTap,
        child: Text(label, style: const TextStyle(color: Colors.white)),
      );
}

// ─── SOCIAL ICON + LABEL ─────────────────────────────────
class SocialItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const SocialItem(this.icon, this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      );
}

// ─── SIMPLE GLOWED IMAGE ─────────────────────────────────
class GlowImage extends StatelessWidget {
  final String assetPath;
  final double width, height;
  final BoxFit fit;
  const GlowImage({
    required this.assetPath,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final glow = BoxShadow(color: Colors.white24, blurRadius: 20, spreadRadius: 4);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [glow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(assetPath, width: width, height: height, fit: fit),
      ),
    );
  }
}

// ─── STAGGERED SECTION HEADER ────────────────────────────
class StaggeredHeader extends StatelessWidget {
  final String title;
  final bool lineBefore;
  const StaggeredHeader(this.title, {this.lineBefore = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            if (lineBefore) ...[
              const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
              const SizedBox(width: 12),
            ],
            Text(title,
                style:
                    const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            if (!lineBefore) ...[
              const SizedBox(width: 12),
              const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
            ],
          ],
        ),
      );
}
// ─── CENTERED SECTION HEADER ────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
        ]),
      );
}
// ─── GENERIC IMAGE+TEXT SECTION ───────────────────────────
class ImageTextSection extends StatelessWidget {
  /// If true, image appears on the left; otherwise on the right
  final bool imageLeft;
  final String imagePath;
  final Widget text;
  const ImageTextSection({
    required this.imageLeft,
    required this.imagePath,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: imageLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: GlowImage(
                assetPath: imagePath,
                width: 300,
                height: 225,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(flex: 2, child: text),
        ],
      ),
    );
  }
}

// ─── PROJECT ITEM ────────────────────────────────────────
class ProjectItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool reverse; // flip sides
  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.reverse = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: reverse ? TextDirection.rtl : TextDirection.ltr,
        children: [
          // 2/3 image
          Expanded(
            flex: 2,
            child: Center(
              child: GlowImage(
                assetPath: imagePath,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 1/3 text
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── FOOTER SECTION ───────────────────────────────────────
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Divider(color: Colors.white54, thickness: 1),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            SocialItem(FontAwesomeIcons.instagram, 'Instagram'),
            VerticalDivider(color: Colors.white54, thickness: 1),
            SocialItem(FontAwesomeIcons.github, 'Github'),
            VerticalDivider(color: Colors.white54, thickness: 1),
            SocialItem(FontAwesomeIcons.linkedin, 'LinkedIn'),
          ]),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Have something you want to reach out to me for? Contact me @ these socials or send me an email',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
