import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:tioirawan/sections/more_works_section.dart';

import '../main.dart';
import '../utils/scroll_value_notifier_adapter.dart';

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  // basically margin top
  static const double bufferHeight = 300;

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  late final ValueNotifier<ScrollPosition?> _scrollNotifier;
  late final ScrollController _scrollController;

  final double buttonWidth = 400;
  final double buttonHeight = 200;

  bool _shouldShowContacts = false;

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

    final top = MediaQuery.of(context).size.height * 3 +
        MoreWorksSection.height +
        ContactSection.bufferHeight / 2;
    final offset = _scrollController.offset;

    if (offset > top && !_shouldShowContacts) {
      setState(() {
        _shouldShowContacts = true;
      });
      debugPrint("show contacts");
    } else if (offset < top && _shouldShowContacts) {
      setState(() {
        _shouldShowContacts = false;
      });
      debugPrint("hide contacts");
    }
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
    debugPrint("build: ContactSection");

    final size = MediaQuery.of(context).size;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final TextTheme textTheme = Theme.of(context).textTheme;

    final top = size.height * 3 + MoreWorksSection.height;

    // button size: 200, need to be: size.height + bufferHeight * 2
    final buttonScale =
        (size.height + ContactSection.bufferHeight * 2) / buttonHeight;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: ContactSection.bufferHeight),
          SizedBox(
            height: size.height,
            // constraints: const BoxConstraints(maxWidth: 1000),
            child: ParallaxStack(
              layers: [
                ParallaxLayer(
                  xRotation: 0.15,
                  yRotation: 0.15,
                  xOffset: -10,
                  yOffset: -10,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: (size.height + buttonHeight) / 2,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            "Or contact me via",
                            style: textTheme.labelMedium!.apply(
                              color: colorScheme.onSurface.withOpacity(0.5),
                            ),
                          )
                              .animate(
                                target: _shouldShowContacts ? 1 : 0,
                              )
                              .fadeIn(delay: 0.5.seconds),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RepaintBoundary(
                                  child: Image.asset(
                                "assets/images/social/linkedin.png",
                                width: 24,
                                height: 24,
                              )
                                      .animate(
                                        target: _shouldShowContacts ? 1 : 0,
                                      )
                                      .fadeIn(delay: 1.seconds)),
                              const SizedBox(width: 14),
                              RepaintBoundary(
                                  child: Image.asset(
                                "assets/images/social/github.png",
                                width: 24,
                                height: 24,
                              )
                                      .animate(
                                        target: _shouldShowContacts ? 1 : 0,
                                      )
                                      .fadeIn(delay: 1.5.seconds)),
                              const SizedBox(width: 14),
                              RepaintBoundary(
                                  child: Image.asset(
                                "assets/images/social/twitter.png",
                                width: 24,
                                height: 24,
                              )
                                      .animate(
                                        target: _shouldShowContacts ? 1 : 0,
                                      )
                                      .fadeIn(delay: 2.seconds)),
                              const SizedBox(width: 14),
                              RepaintBoundary(
                                child: Image.asset(
                                  "assets/images/social/instagram.png",
                                  width: 24,
                                  height: 24,
                                )
                                    .animate(
                                      target: _shouldShowContacts ? 1 : 0,
                                    )
                                    .fadeIn(delay: 2.5.seconds),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ParallaxLayer(
                  xRotation: 0.35,
                  yRotation: 0.35,
                  xOffset: 15,
                  yOffset: 15,
                  offset: const Offset(-160 * 2, -20),
                  child: Center(
                    child: SizedBox(
                      width: 160,
                      height: 120,
                      child: Image.asset(
                        'assets/images/arrow.png',
                        fit: BoxFit.fill,
                      ),
                    )
                        .animate(target: _shouldShowContacts ? 1 : 0)
                        .fadeIn()
                        .then()
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            period: 1.seconds,
                            reverse: true,
                          ),
                        )
                        .scaleXY(
                          end: 1.1,
                          curve: Curves.easeInOut,
                        ),
                  ),
                ),
                ParallaxLayer(
                  xRotation: 0.25,
                  yRotation: 0.25,
                  xOffset: -10,
                  yOffset: -10,
                  offset: const Offset(160 * 2, 30),
                  child: Center(
                    child: Transform.rotate(
                      // 180
                      angle: math.pi,
                      child: SizedBox(
                        width: 160,
                        height: 120,
                        child: Image.asset(
                          'assets/images/arrow.png',
                          fit: BoxFit.fill,
                        ),
                      )
                          .animate(target: _shouldShowContacts ? 1 : 0)
                          .fadeIn()
                          .then()
                          .animate(
                            delay: 1.seconds,
                            onPlay: (controller) => controller.repeat(
                              period: 1.seconds,
                              reverse: true,
                            ),
                          )
                          .scaleXY(
                            end: 1.1,
                            curve: Curves.easeInOut,
                          ),
                    ),
                  ),
                ),
                ParallaxLayer(
                  xRotation: 0.25,
                  yRotation: 0.25,
                  child: Center(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150),
                            ),
                            elevation: 0,
                            textStyle: textTheme.displaySmall!.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          child: const Text(
                            "Let's get in touch!",
                            textAlign: TextAlign.center,
                          )
                              .animate(
                                  adapter: ScrollValueNotifierAdapter(
                                _scrollNotifier,
                                begin: top - size.height / 2,
                                end: top + ContactSection.bufferHeight,
                              ))
                              .fadeIn(curve: Curves.easeInExpo)),
                    )
                        .animate(
                          adapter: ScrollValueNotifierAdapter(
                            _scrollNotifier,
                            begin: top - size.height / 2,
                            end: top + ContactSection.bufferHeight,
                          ),
                        )
                        // find
                        .scaleXY(begin: buttonScale, curve: Curves.easeInOut),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
