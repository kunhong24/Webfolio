//flutter run -t lib/practice.dart

import 'package:flutter/material.dart';
import 'package:term_summary/components.dart'; // StaggeredHeader & GlowImage

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget { //run app stateless widget cause your app dont change
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Me Only',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const AboutPage(), // its very first widget/child of the app
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // just one local var for our long text
  final String aboutText = '''
At the age of 6, I unspooled my brother’s correction tape, resulting in the loss of his stationery before his exam. On that day I learned two things: the pain of a cane and how gears work.

Today, I am passionate about engineering and problem solving as an aspiring entrepreneur. I’m currently pursuing my degree in SUTD under the STEP Scholarship Programme.
''';

  @override
  Widget build(BuildContext context) {
    // reuse your glow shadow
    final imageShadow = BoxShadow(
      color: Colors.white24,
      blurRadius: 40,
      spreadRadius: 8,
    );

    return Scaffold( // material scaffold
      body: Center( // center the content
        child: Padding( // padding around the content
          padding: const EdgeInsets.all(24),
          child: Column( // main column
            mainAxisSize: MainAxisSize.min, // shrink-wrap vertically
            children: [ // childrens of column
              const StaggeredHeader('About Me', lineBefore: true), // header with short line before
              const SizedBox(height: 16), // fixed size gap
              Row(
                children: [
                  // image on the left
                  Flexible( // flexible widget to allow resizing, limited space follow flex
                    flex: 1,
                    child: GlowImage(
                      assetPath: 'lib/assets/about.png',
                      width: 300,
                      height: 225,
                      shadow: imageShadow,
                    ),
                  ),

                  const SizedBox(width: 24),

                  // text on the right
                  Flexible(
                    flex: 2,
                    child: Text(
                      aboutText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
