import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:tioirawan/widgets/hover_unsaturate.dart';

import '../main.dart';
import '../utils/scroll_value_notifier_adapter.dart';

class AboutMeSection extends ConsumerStatefulWidget {
  const AboutMeSection({super.key});

  @override
  ConsumerState<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends ConsumerState<AboutMeSection> {
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
    debugPrint("build: AboutMeSection");

    final size = MediaQuery.of(context).size;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: SizedBox(
        height: size.height,
        // constraints: const BoxConstraints(maxWidth: 1000),
        child: ParallaxStack(
          layers: [
            ParallaxLayer(
              yRotation: 0.05,
              xRotation: 0.05,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectableText.rich(
                                TextSpan(
                                  style: textTheme.displayMedium,
                                  children: [
                                    const TextSpan(
                                      text: "About ",
                                    ),
                                    TextSpan(
                                      text: "Me",
                                      style:
                                          TextStyle(color: colorScheme.primary),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineThickness: 1.0,
                                dashLength: 10,
                                dashColor:
                                    colorScheme.primary.withOpacity(0.25),
                                dashRadius: 4,
                              ),
                              const SizedBox(height: 14),
                              Markdown(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                selectable: true,
                                data:
                                    // "Hello! I'm **Tio** and I am a *Mobile Developer* specializing in **Flutter**, but I also have some experience in *Web Development*. I'm not just someone who writes code - I'm a problem solver who is always seeking new and innovative ways to enhance the user experience.\n\nMy ultimate goal is to make a meaningful impact by delivering high-quality and intuitive applications that are both functional and visually appealing. When I'm not coding, I enjoy exploring new technologies and refining my craft, always looking for ways to push the boundaries of what's possible. **Let's make amazing things together!**",
                                    "Hello! I'm **Tio** and I am a *Mobile Developer* specializing in **Flutter**, but I also have some experience in *Web Development*. When I'm not coding, I enjoy exploring new technologies and refining my craft, always looking for ways to push the boundaries of what's possible. **Let's make amazing things together!**",
                                softLineBreak: true,
                                styleSheet: MarkdownStyleSheet(
                                  p: textTheme.bodyMedium,
                                  strong: textTheme.bodyMedium!.apply(
                                    color: colorScheme.primary,
                                    fontWeightDelta: 2,
                                    fontSizeFactor: 1.1,
                                  ),
                                  em: textTheme.bodyMedium!.apply(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                // style: textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  HoverUnsaturate(
                                    child: FlutterLogo(
                                      size: 24,
                                      textColor: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  const HoverUnsaturate(
                                    child: FaIcon(FontAwesomeIcons.laravel,
                                        color: Color(0xfff55247)),
                                  ),
                                  const SizedBox(width: 24),
                                  const HoverUnsaturate(
                                    child: FaIcon(
                                      FontAwesomeIcons.vuejs,
                                      color: Color(0xff42b883),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                              .animate(
                                adapter: ScrollValueNotifierAdapter(
                                  _scrollNotifier,
                                  begin: size.height,
                                  end: size.height * 2,
                                ),
                              )
                              .slideY(end: -0.1)
                              .animate(
                                adapter: ScrollValueNotifierAdapter(
                                  _scrollNotifier,
                                  end: size.height * 0.9,
                                ),
                              )
                              .slideX(begin: -1.6, curve: Curves.easeOut),
                        ),
                        const SizedBox(width: 32),
                        const SizedBox(
                          width: 300,
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ParallaxLayer(
              xOffset: 10,
              yOffset: 10,
              offset: const Offset(10, 10),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ClipOval(
                      child: Container(
                        width: 300,
                        height: 300,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height,
                        end: size.height * 2,
                      ),
                    )
                    .slideY(end: -0.5)
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        end: size.height * 0.9,
                      ),
                    )
                    .slideX(begin: 1.6, curve: Curves.easeOut),
              ),
            ),
            ParallaxLayer(
              xOffset: 20,
              yOffset: 20,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/profile_picture.webp",
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height,
                        end: size.height * 2,
                      ),
                    )
                    .slideY(end: -0.5)
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        end: size.height * 0.9,
                      ),
                    )
                    .slideX(begin: 1.2, curve: Curves.easeOut),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
