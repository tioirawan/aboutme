import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tioirawan/utils/theme.dart';

import '../main.dart';
import '../utils/scroll_value_notifier_adapter.dart';

class MoreWorksSection extends ConsumerStatefulWidget {
  const MoreWorksSection({super.key});

  static const double height = ProjectCard.totalHeight * 4;

  @override
  ConsumerState<MoreWorksSection> createState() => _MoreWorksSectionState();
}

class _MoreWorksSectionState extends ConsumerState<MoreWorksSection> {
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
    debugPrint("build: MoreWorksSection");

    final size = MediaQuery.of(context).size;

    // debugPrint("top: $_top");

    // debugPrint(
    //     "build: MoreWorksSection ${_top + size.height}, ${_top + size.height * 2}");
    // debugPrint(
    //     "build: MoreWorksSection ${size.height * 2}, ${size.height * 3}");

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final TextTheme textTheme = Theme.of(context).textTheme;

    final top = size.height * 3;
    final distInMid = (size.height - ProjectCard.totalHeight) / 2;

    // jarak sebelum card direveal
    final revealDist = size.height / 2;
    final e1 = top - distInMid;
    final s1 = e1 - revealDist;
    final e2 = top + ProjectCard.totalHeight - distInMid;
    final s2 = e2 - revealDist;
    final e3 = top + ProjectCard.totalHeight * 2 - distInMid;
    final s3 = e3 - revealDist;
    final e4 = top + ProjectCard.totalHeight * 3 - distInMid;
    final s4 = e4 - revealDist;

    return Center(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                // border: Border.all(color: Colors.red),
                ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                // project 1
                ProjectCard(
                  image: Image.network(
                    "https://picsum.photos/seed/2/300/200",
                    fit: BoxFit.cover,
                  ),
                  title: "Example Project 1",
                  description:
                      "A tool to help us to hack NASA's servers and steal their data.\n\nI use a bunch of NSA tools to do this. I also use a bunch of other tools that I found on the internet from CIA and BNK.\n\nI learnt a lot from this project and I hope you do too.",
                )
                    .animate(
                      delay: 2.seconds,
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: s1,
                        end: e1,
                      ),
                    )
                    .custom(
                      builder: (context, value, child) => Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-0.5 * (1 - value)),
                        child: child,
                      ),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
                // project 2
                ProjectCard(
                  position: ProjectCardPosition.right,
                  image: Image.network(
                    "https://picsum.photos/seed/sfdf/200/300",
                    fit: BoxFit.cover,
                  ),
                  title: "Example Project 2",
                  description:
                      "AI to generate fake news and spread it to the world.\n\nThis is a very dangerous project. I hope you don't use it for bad things.\n\nThis project is still in development. I will update it soon.",
                  backgroundColor: vueColor,
                )
                    .animate(
                      delay: 2.seconds,
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: s2,
                        end: e2,
                      ),
                    )
                    .custom(
                      builder: (context, value, child) => Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(0.5 * (1 - value)),
                        child: child,
                      ),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
                // project 3
                ProjectCard(
                  image: Image.network(
                    "https://picsum.photos/seed/3/300/200",
                    fit: BoxFit.cover,
                  ),
                  title: "Example Project 3",
                  description:
                      "I create this project to donate to the poor people in the world.\n\nI hope you can donate too. I will update this project soon cause I runs out of money. This project is pretty expensive to run.",
                  backgroundColor: laravelColor,
                )
                    .animate(
                      delay: 2.seconds,
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: s3,
                        end: e3,
                      ),
                    )
                    .custom(
                      builder: (context, value, child) => Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-0.5 * (1 - value)),
                        child: child,
                      ),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
                // project 4
                ProjectCard(
                  position: ProjectCardPosition.right,
                  image: Image.network(
                    "https://picsum.photos/seed/999/200/300",
                    fit: BoxFit.cover,
                  ),
                  title: "Example Project 4",
                  description:
                      "Leaked data from Tesla's servers.\n\nI found this data on the internet. I don't know how it got there. I hope you can use it to make the world a better place.\n\nI will archive this project soon.",
                  backgroundColor: bukuListrikColor,
                )
                    .animate(
                      delay: 2.seconds,
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: s4,
                        end: e4,
                      ),
                    )
                    .custom(
                      builder: (context, value, child) => Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(0.5 * (1 - value)),
                        child: child,
                      ),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
              ],
            ),
          ),
          // Positioned(
          //   top: ProjectCard.cardHeight - distInMid,
          //   left: 0,
          //   right: 0,
          //   child: const Divider(
          //     color: Colors.red,
          //     thickness: 2,
          //     height: 0,
          //   ),
          // ),
        ],
      ),
    );
  }
}

enum ProjectCardPosition {
  left,
  right,
}

// project card
class ProjectCard extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;
  final String? link;
  final ProjectCardPosition position;
  final Color? backgroundColor;

  static const double cardHeight = 300;
  static const double cardMarginBottom = 120;
  static const double totalHeight = cardHeight + cardMarginBottom;

  const ProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.link,
    this.position = ProjectCardPosition.left,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          margin: const EdgeInsets.only(
              bottom: cardMarginBottom, left: 150, right: 150),
          decoration: const BoxDecoration(
              // color: colorScheme.onBackground.withOpacity(0.05),
              // left and bottom border only
              // border: Border(
              //   left: BorderSide(
              //     color: colorScheme.onBackground.withOpacity(0.15),
              //     width: 2,
              //   ),
              //   bottom: BorderSide(
              //     color: colorScheme.onBackground.withOpacity(0.15),
              //     width: 2,
              //   ),
              // ),
              // borderRadius: BorderRadius.circular(8),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.05),
              //     blurRadius: 20,
              //     offset: const Offset(0, 10),
              //   ),
              // ],
              ),
          child: DottedBorder(
            color: (backgroundColor ?? colorScheme.primary).withOpacity(0),
            strokeWidth: 4,
            strokeCap: StrokeCap.round,
            dashPattern: const [8, 8],
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: position == ProjectCardPosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  if (ProjectCardPosition.left == position)
                    SizedBox(
                      width: 150,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildButton(context),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: position == ProjectCardPosition.left
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: textTheme.titleLarge!.apply(
                              fontWeightDelta: 2,
                              fontSizeFactor: 1.5,
                              color: colorScheme.onBackground,
                            ),
                            textAlign: position == ProjectCardPosition.left
                                ? TextAlign.left
                                : TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineThickness: 2.0,
                            dashLength: 10,
                            dashColor: (backgroundColor ?? colorScheme.primary)
                                .withOpacity(0.25),
                            dashRadius: 4,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            description,
                            style: textTheme.bodyMedium!.apply(
                              color: colorScheme.onBackground,
                            ),
                            textAlign: position == ProjectCardPosition.left
                                ? TextAlign.left
                                : TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (ProjectCardPosition.right == position)
                    SizedBox(
                      width: 150,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildButton(context),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (ProjectCardPosition.left == position)
          Positioned(
            top: 24,
            left: 0,
            child: _buildImage(context),
          )
        else
          Positioned(
            top: 24,
            right: 0,
            child: _buildImage(context),
          ),
      ],
    );
  }

  final buttonTexts = const [
    "Take a look",
    "See more",
    "View details",
    "Check it out",
  ];

  ElevatedButton _buildButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      child: Text(
        buttonTexts[Random().nextInt(buttonTexts.length)],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final Widget background = Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (position == ProjectCardPosition.left)
          Positioned(
            top: 10,
            right: 10,
            child: background,
          )
        else
          Positioned(
            top: 10,
            left: 10,
            child: background,
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 300,
            height: 200,
            child: image,
          ),
        ),
      ],
    );
  }
}
