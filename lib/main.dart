import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:term_summary/components.dart';

void main() => runApp(const MyApp());

// Disable the default scroll glow
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
      title: 'Portfolio',
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
  final _scroll = ScrollController();
  final _aboutKey = GlobalKey();
  final _expKey = GlobalKey();
  final _projKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // glow for images
    final imageShadow = BoxShadow(
      color: Colors.white24,
      blurRadius: 40,
      spreadRadius: 8,
    );
    // detect portrait vs. landscape
    final isPortrait =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(children: [
      Center(
        // Center the content, try also with Align
        child: ConstrainedBox(
          // Constrain the width of the content
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            controller: _scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ─── NAV BAR ───────────────────────────────────────
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NavButton('About', () => _scrollTo(_aboutKey)),
                        NavButton('Experience', () => _scrollTo(_expKey)),
                        NavButton('Projects', () => _scrollTo(_projKey)),
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
                // ─── HERO / PROFILE ────────────────────────────────
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Row(
                    children: [
                      // Intro + buttons + socials
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hi, my name is',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20)),
                            const SizedBox(height: 8),
                            const Text('Loh Kun Hong',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            const Text(
                              'Welcome to my website. Scroll down to find out more about me.',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 16),
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
                              EmailButton(toAddress: '', label: 'Reach me')
                            ]),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SocialItem(
                                  icon: FontAwesomeIcons.instagram,
                                  label: 'Instagram',
                                  url: 'https://www.instagram.com/',),
                                  SocialItem(
                                  icon: FontAwesomeIcons.github,
                                  label: 'GitHub',
                                  url: 'https://github.com/',),
                                  SocialItem(
                                    icon: FontAwesomeIcons.linkedin,
                                    label: 'LinkedIn',
                                    url: 'https://www.linkedin.com/',
                                ),
                                
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 32),

                      // Profile image
                      Expanded(
                          flex: 1,
                          child: GlowImage(
                              assetPath: 'lib/assets/profile.png',
                              width: 300,
                              height: 300,
                              shadow: imageShadow))
                    ],
                  ),
                ),
                // ─── ABOUT ME ─────────────────────────────────────
                Container(key: _aboutKey),
               const StaggeredHeader('About Me', lineBefore: true),
               Padding(
                 padding:
                     const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                 child: Row(
                   children: [
                     Expanded(
                       flex: 1,
                       child: GlowImage(
                         assetPath: 'lib/assets/profile.png',
                         width: 300,
                         height: 225,
                         fit: BoxFit.cover,
                         shadow: imageShadow,
                       ),
                     ),
                     const SizedBox(width: 24),
                     Expanded(
                       flex: 2,
                       child: const Text(
                         'I am an Aspiring Mechanical Engineer studying in the Singapore University of Technology and Design (SUTD). A multitude of projects instilled into me the spirit of proactive learning and effective communication. I approach tasks with diligence and humility, pushing for clarity on my doubts, especially when dealing with unfamiliar grounds.\n\n'
                         'While being meticulous is my pride, details can distract me from the bigger picture, so I consciously push for an iterative, “just do it” approach. In my free time, I love to dance and exercise, keeping my body and mind active.',
                         style: TextStyle(
                             color: Colors.white70, fontSize: 16, height: 1.5),
                       ),
                     ),
                   ],
                 ),
               ),


                // ─── PROJECTS ────────────────────────────────────────
                Container(key: _projKey),
               const SectionHeader('Projects'),


               const ProjectCard(
                 imagePath: 'lib/assets/verbasense.png',
                 title: 'Ground-Breaking',
                 description:
                     'A comprehensive sensing solution for forest monitoring efforts.\n\nAwarded:\nPeople’s Choice Award.',
                 techLine: 'FEA Simulations | Mathematical Modelling',
                 aspectRatio: 16 / 9,
                 reverse: false,
               ),


               const ProjectCard(
                 imagePath: 'lib/assets/projex.png',
                 title: 'Projex',
                 description: 'Portable projector that navigates unfamiliar indoor spaces.',
                 techLine: 'Design Thinking | Raspberry Pi | Electronics | CLI',
                 aspectRatio: 16/9, // square image
                 reverse: true, // image on right side
               ),


               const ProjectCard(
                 imagePath: 'lib/assets/car.jpg',
                 title: 'Rubberband Car',
                 description: 'Mechanical car with adjustable rubber-based suspension.',
                 techLine: 'Fusion360 CAD | Additive Manufacturing | Laser Cutting',
                 aspectRatio: 16 / 9,
                 reverse: false,
               ),

               const ProjectCard(
                 imagePath: 'lib/assets/SDW.png',
                 title: 'Spatial Design World',
                 description: 'Comprehensive sketching and modelling methods with Rhino CAD software.',
                 techLine: 'Rhino CAD | Technical Sketching',
                 aspectRatio: 16/9, // square image
                 reverse: true, // image on right side
               ),


               const ProjectCard(
                 imagePath: 'lib/assets/ML.png',
                 title: 'Machine Learning Exploration',
                 description: 'Gained exposure to common Machine Learning methods.',
                 techLine: 'Time Series Forecasting | Inverse Design', // no tech line
                 aspectRatio: 16 / 9,
                 reverse: false,
               ),

               const ProjectCard(
                 imagePath: 'lib/assets/CTD.png',
                 title: 'Calendar and Schedule Tracker',
                 description: 'A scheduling application coded from scratch',
                 techLine: 'Python | Tkinter GUI',
                 aspectRatio: 16/9, // square image
                 reverse: true, // image on right side
               ),

                
                // ─── THE END ─────────────────────────────────────────
                const SectionHeader('The End'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'That’s all I have done so far… but more is coming soon.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),

                // ─── FOOTER ───────────────────────────────────────────
                const Divider(color: Colors.white54, thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialItem(
                            icon: FontAwesomeIcons.instagram,
                            label: 'Instagram',
                            url: 'https://www.instagram.com/',
                          ),
                          SizedBox(width: 16),
                          SocialItem(
                            icon: FontAwesomeIcons.github,
                            label: 'GitHub',
                            url: 'https://github.com/',
                          ),
                          SizedBox(width: 16),
                          SocialItem(
                            icon: FontAwesomeIcons.linkedin,
                            label: 'LinkedIn',
                            url: 'https://www.linkedin.com/',
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
    if (isPortrait)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.screen_rotation, size: 64, color: Colors.white24),
                    const SizedBox(height: 24),
                    const Text(
                      'Please rotate your device\ninto landscape mode',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        height: 1.3,),
                    ),
                  ],
                ),
              ),
            ),
          ),
    ]),
    );   
  }
}
