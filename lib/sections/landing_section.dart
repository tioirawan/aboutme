import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:tioirawan/main.dart';

import '../utils/scroll_value_notifier_adapter.dart';

class LandingSection extends ConsumerStatefulWidget {
  const LandingSection({super.key});

  static final isContinueScrollShown = StateProvider<bool>((ref) => false);

  @override
  ConsumerState<LandingSection> createState() => _LandingSectionState();
}

class _LandingSectionState extends ConsumerState<LandingSection> {
  late final ValueNotifier<ScrollPosition?> _scrollNotifier;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollNotifier = ValueNotifier(null);
    _scrollController = ref.read(App.scrollController);

    _scrollController.addListener(onScroll);
  }

  void onScroll() {
    _scrollNotifier.value = _scrollController.position;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    _scrollNotifier.notifyListeners();
  }

  @override
  void dispose() {
    // always dispose notifier
    _scrollController.removeListener(onScroll);
    _scrollNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build: LandingSection");

    final showContinueScroll = ref.watch(LandingSection.isContinueScrollShown);
    final themeMode = ref.watch(App.themeMode);

    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ParallaxStack(
            layers: [
              ParallaxLayer(
                xRotation: 0.20,
                yRotation: 0.20,
                xOffset: -10,
                yOffset: -10,
                child: Center(
                  child: SelectableText.rich(
                    TextSpan(
                      style: textTheme.displayMedium!.apply(
                        color: colorScheme.onBackground.withOpacity(0.2),
                      ),
                      children: [
                        TextSpan(
                          text: "Mobile",
                          style: TextStyle(
                            color: colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                        const TextSpan(
                          text: " Developer",
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1.seconds, duration: 1.seconds)
                      .slideX(
                        end: .3,
                        delay: 1000.ms,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .slideY(
                        end: .3,
                        duration: 1.seconds,
                        curve: Curves.easeOut,
                      )
                      .then()
                      .animate(
                        adapter: ScrollValueNotifierAdapter(_scrollNotifier,
                            end: size.height),
                        // ScrollAdapter(scrollController, end: size.height),
                        onPlay: (controller) =>
                            debugPrint("onPlay: ${controller.value}"),
                      )
                      .slideY(end: -1.5)
                      .animate(
                        adapter: ScrollValueNotifierAdapter(_scrollNotifier,
                            end: size.height / 2),
                      )
                      .fadeOut(curve: Curves.easeOut),
                ),
              ),
              ParallaxLayer(
                xRotation: 0.20,
                yRotation: 0.20,
                xOffset: 10,
                yOffset: 10,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tio Irawan",
                        style: textTheme.displayLarge,
                      ),
                      RichText(
                          text: TextSpan(
                        style: textTheme.bodyMedium,
                        children: const [
                          TextSpan(
                            text: "Hi!, I'm ",
                          ),
                          TextSpan(
                            text: "Tio Irawan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ", a mobile developer from Indonesia.\nI do mobile development using ",
                          ),
                          TextSpan(
                            text: "Flutter",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: ". I also do web development using ",
                          ),
                          TextSpan(
                            text: "Vue.js",
                            // style: TextStyle(color: vueColor),
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                            text: "Laravel",
                            // style: TextStyle(color: laravelColor),
                          ),
                          TextSpan(
                            text: ".",
                          )
                        ],
                      )).animate().fadeIn(delay: 2.seconds),
                    ],
                  )
                      .animate()
                      .slideX(
                        end: -.2,
                        delay: 1000.ms,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .animate(
                        delay: 2.seconds,
                        adapter: ScrollValueNotifierAdapter(_scrollNotifier,
                            end: size.height),
                      )
                      .slideY(end: -0.4)
                      .animate(
                        adapter: ScrollValueNotifierAdapter(_scrollNotifier,
                            end: size.height / 2),
                      )
                      .fadeOut(curve: Curves.easeOut),
                ),
              ),
            ],
          )
              .animate()
              .slideY(
                begin: .2,
                duration: 1.seconds,
                // end slowly
                curve: Curves.ease,
              )
              .fadeIn(
                duration: 2.seconds,
                curve: Curves.easeInOutSine,
              ),
          Positioned(
            bottom: 20,
            child: AnimatedSwitcher(
              duration: 500.ms,
              child: !showContinueScroll
                  ? const SizedBox(
                      key: Key("continueScrollHidden"),
                    )
                  : Column(
                      children: [
                        SelectableText(
                          "Scroll down to know me more...",
                          key: const Key("continueScrollVisible"),
                          style: textTheme.bodyMedium!.apply(
                            color: colorScheme.onBackground.withOpacity(0.5),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: colorScheme.onBackground.withOpacity(0.5),
                        ),
                      ],
                    )
                      .animate()
                      .fadeIn()
                      .then()
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(delay: 800.ms, duration: 800.ms),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: 1000.ms,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: RotationTransition(turns: animation, child: child),
                ),
                child: themeMode == ThemeMode.light
                    ? FaIcon(
                        FontAwesomeIcons.sun,
                        key: const Key("sun"),
                        color: Colors.yellow[800],
                      )
                        .animate(
                          onPlay: (controller) => controller.repeat(),
                        )
                        .rotate(duration: 20.seconds)
                    : const FaIcon(
                        FontAwesomeIcons.moon,
                        key: Key("moon"),
                        color: Colors.white,
                      )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .rotate(
                            duration: 2.seconds,
                            begin: -0.15,
                            end: 0.05,
                            curve: Curves.easeInOut),
              ),
              onPressed: () => themeMode == ThemeMode.light
                  ? ref.read(App.themeMode.notifier).state = ThemeMode.dark
                  : ref.read(App.themeMode.notifier).state = ThemeMode.light,
            )
                .animate()
                .fadeIn(
                  begin: -2,
                  delay: 2.seconds,
                  duration: 3.seconds,
                  curve: Curves.easeOut,
                )
                .rotate(
                  alignment: const Alignment(-1, -1),
                ),
          ),
        ],
      ),
    );
  }
}
