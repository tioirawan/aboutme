import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tioirawan/sections/contact_section.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'sections/aboutme_section.dart';
import 'sections/landing_section.dart';
import 'sections/more_works_section.dart';
import 'sections/my_works_section.dart';
import 'utils/theme.dart';

void main() {
  Animate.restartOnHotReload = true;

  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  static final scrollController =
      Provider<ScrollController>((ref) => ScrollController());
  // static final scrollNotifier =
  static final themeMode = StateProvider<ThemeMode>((ref) => ThemeMode.light);

  @override
  ConsumerState<App> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<App> {
  late final ScrollController _scrollController =
      ref.read(App.scrollController);

  final List<Widget> sections = [
    const LandingSection(),
    const AboutMeSection(),
    const MyWorksSection(),
    const MoreWorksSection(),
    const ContactSection(),
  ];

  bool hasScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(onScroll);

    Future.delayed(const Duration(seconds: 6), () {
      ref.read(LandingSection.isContinueScrollShown.notifier).state =
          !hasScrolled;
    });
  }

  void onScroll() {
    if (!hasScrolled && _scrollController.offset > 0) {
      hasScrolled = true;
    } else if (hasScrolled && ref.read(LandingSection.isContinueScrollShown)) {
      ref.read(LandingSection.isContinueScrollShown.notifier).state = false;
    }

    // debugPrint("onScroll: ${_scrollController.offset}");
  }

  @override
  void dispose() {
    _scrollController.removeListener(onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build: App");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tio Irawan',
      theme: kTheme,
      darkTheme: kDarkTheme,
      themeMode: ref.watch(App.themeMode),
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: RepaintBoundary(
                child: Transform.rotate(
                  angle: -0.1,
                  child: Text(
                    "👷‍♂️ UNDER DEVELOPMENT 🚧",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.grey.withOpacity(0.2),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ).animate().fade(delay: 5.seconds),
              ),
            ),
            Positioned.fill(
              child: WebSmoothScroll(
                animationDuration: 400,
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) => sections[index],
                ),
                // child: SingleChildScrollView(
                //   controller: _scrollController,
                //   physics: const NeverScrollableScrollPhysics(),
                //   // itemCount: sections.length,
                //   // itemBuilder: (context, index) => sections[index],
                //   child: Column(
                //     children: sections,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),

      // https://github.com/gskinner/flutter_animate/issues/51
      // home: Scaffold(
      //   body: ListView.builder(
      //     controller: _scrollController,
      //     itemCount: 3,
      //     itemBuilder: (context, index) {
      //       final text = Text(
      //         index.toString(),
      //       );

      //       return SizedBox(
      //         height: MediaQuery.of(context).size.height,
      //         child: index == 0
      //             ? text
      //                 .animate(adapter: ScrollAdapter(_scrollController))
      //                 .slideY(end: 2.5)
      //             : text,
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
