import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lo Khye He Portfolio',
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoGlowScrollBehavior(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll   = ScrollController();
  final _aboutKey = GlobalKey();
  final _expKey   = GlobalKey();
  final _projKey  = GlobalKey();
  final _endKey   = GlobalKey();

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Clean rectangular glow around each image
    final imageShadow = BoxShadow(
      color: Colors.white24,
      blurRadius: 20,
      spreadRadius: 4,
    );

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            controller: _scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // NAV BAR
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _NavButton('About',     () => _scrollTo(_aboutKey)),
                        _NavButton('Experience',() => _scrollTo(_expKey)),
                        _NavButton('Projects',  () => _scrollTo(_projKey)),
                        _NavButton('Resume',    () => _scrollTo(_endKey)),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.wb_sunny_outlined),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                // HERO / PROFILE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Row(
                    children: [
                      // Left side: text, buttons, socials
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hi, my name is',
                                style: TextStyle(color: Colors.white70, fontSize: 20)),
                            const SizedBox(height: 8),
                            const Text('Lo Khye He',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            const Text(
                              'Welcome to my website. Scroll down to find out more about me.',
                              style: TextStyle(color: Colors.white54, fontSize: 16),
                            ),
                            const SizedBox(height: 24),
                            Row(children: [
                              ElevatedButton(
                                onPressed: () => _scrollTo(_aboutKey),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Check me out'),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.cyanAccent),
                                  foregroundColor: Colors.cyanAccent,
                                ),
                                child: const Text('Reach Me'),
                              ),
                            ]),
                            const SizedBox(height: 32),
                            // inline socials + dividers
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 28),
                                    SizedBox(height: 4),
                                    Text('Instagram', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: VerticalDivider(color: Colors.white54, thickness: 1),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    FaIcon(FontAwesomeIcons.github, color: Colors.white, size: 28),
                                    SizedBox(height: 4),
                                    Text('Github', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: VerticalDivider(color: Colors.white54, thickness: 1),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 28),
                                    SizedBox(height: 4),
                                    Text('LinkedIn', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 32),

                      // Right side: profile image with glow
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [imageShadow],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'lib/assets/profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ABOUT ME
                Container(key: _aboutKey),
                const StaggeredHeader('About Me', lineBefore: false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image 1/3
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: SizedBox(
                            height: 250,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [imageShadow],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset('lib/assets/about.png', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // text 2/3
                      Expanded(
                        flex: 2,
                        child: const Text(
                          'From a young age, I have always tinkered with things. At the age of 6, I unspooled my brother’s correction tape, resulting in the loss of one of his stationery before his exam. On that day I learned two things: the pain of a cane and how gears work.\n\n'
                          'Today, I am passionate about engineering and problem solving as an aspiring entrepreneur. I’m currently pursuing my degree at SUTD under the STEP Scholarship Programme. As well as working on a Baby Shark Fund Project.',
                          style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),

                // EXPERIENCE
                Container(key: _expKey),
                const StaggeredHeader('Experience', lineBefore: true),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image 1/3
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: SizedBox(
                            height: 250,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [imageShadow],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset('lib/assets/experience.png', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // text 2/3
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Assistant Engineer @ Temasek Polytechnic',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('Part-time | Apr 2022 – Oct 2022', style: TextStyle(color: Colors.white54)),
                            SizedBox(height: 8),
                            Text('My tasks include:', style: TextStyle(color: Colors.white70)),
                            Text(
                              '• Developing the software portion of an IOT Module for students to learn the process of connecting health sensors to the cloud and dashboarding.',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '• Provide consultation services for Final Year Project students in prototyping.',
                              style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Robotics Intern @ Weston Robot',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('Internship | Sep 2021 – Feb 2022', style: TextStyle(color: Colors.white54)),
                            SizedBox(height: 8),
                            Text('My tasks include:', style: TextStyle(color: Colors.white70)),
                            Text(
                              '• Developing a mobile application capable of interfacing with in-house robots for diagnostic purposes using Flutter.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // PROJECTS (centered header)
                Container(key: _projKey),
                const SectionHeader('Projects'),
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: i.isOdd ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        // image 2/3
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: SizedBox(
                              height: 300,
                              child: AspectRatio(
                                aspectRatio: i == 1 ? 1 : 16 / 9,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [imageShadow],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      i == 0
                                          ? 'lib/assets/verbasense.png'
                                          : i == 1
                                              ? 'lib/assets/capacitor.png'
                                              : 'lib/assets/icecream.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // text 1/3
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 300,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    i == 0
                                        ? 'Verbasense'
                                        : i == 1
                                            ? 'DIY Capacitor'
                                            : 'Battle of the Ice Cream Cup',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i == 0
                                        ? 'Smart backlight that helps students raise their hands'
                                        : i == 1
                                            ? 'Variable Capacitor Disk Style'
                                            : 'Lifecycle analysis of different materials.',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  if (i == 0) ...[
                                    const SizedBox(height: 8),
                                    const Text('Python | ESP32 | Flutter | Dart',
                                        style: TextStyle(color: Colors.white54)),
                                  ] else if (i == 1) ...[
                                    const SizedBox(height: 8),
                                    const Text('Fusion 360 | Additive Manufacturing',
                                        style: TextStyle(color: Colors.white54)),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // THE END (centered header)
                Container(key: _endKey),
                const SectionHeader('The End'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'That’s all I have done so far… but more is coming soon.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),

                // FOOTER + contact line
                const Divider(color: Colors.white54, thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                              SizedBox(height: 4),
                              Text('Instagram',
                                  style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: VerticalDivider(color: Colors.white54, thickness: 1),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              FaIcon(FontAwesomeIcons.github, color: Colors.white),
                              SizedBox(height: 4),
                              Text('Github',
                                  style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: VerticalDivider(color: Colors.white54, thickness: 1),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                              SizedBox(height: 4),
                              Text('LinkedIn',
                                  style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Have something you want to reach out to me for? Contact me @ these socials or send me an email',
                          style: TextStyle(color: Colors.white54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── CENTERED SECTION HEADER ────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext c) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,              // ← bumped from 24
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
        ]),
      );
}

// NAV BUTTON HELPER
class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavButton(this.label, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) =>
      TextButton(onPressed: onTap, child: Text(label, style: const TextStyle(color: Colors.white)));
}

// SECTION HEADER WITH LINES ON ONE SIDE
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
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            if (!lineBefore) ...[
              const SizedBox(width: 12),
              const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
            ],
          ],
        ),
      );}