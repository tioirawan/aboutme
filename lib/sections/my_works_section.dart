import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_parallax/mouse_parallax.dart';

import '../main.dart';
import '../utils/scroll_value_notifier_adapter.dart';

class MyWorksSection extends ConsumerStatefulWidget {
  const MyWorksSection({super.key});

  @override
  ConsumerState<MyWorksSection> createState() => _MyWorksSectionState();
}

class _MyWorksSectionState extends ConsumerState<MyWorksSection> {
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
    debugPrint("build: MyWorksSection");

    final size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: SizedBox(
        height: size.height,
        child: ParallaxStack(
          layers: [
            // bottom left
            ParallaxLayer(
              offset: const Offset(-250, 200),
              xOffset: -15,
              yOffset: -15,
              xRotation: 0.08,
              yRotation: 0.1,
              child: Center(
                child: MyWorkImage(
                  image: Image.asset(
                    "assets/images/rejoin.png",
                    width: 130,
                  ),
                  shadowColor: const Color.fromARGB(255, 138, 186, 226),
                ),
              )
                  .animate(
                    adapter: ScrollValueNotifierAdapter(
                      _scrollNotifier,
                      begin: size.height * 1.5,
                      end: size.height * 3,
                    ),
                  )
                  .slideY(end: -0.2),
            ),
            // top left
            ParallaxLayer(
              offset: const Offset(-400, 100),
              xOffset: 10,
              yOffset: 10,
              xRotation: 0.05,
              yRotation: 0.05,
              child: Center(
                child: MyWorkImage(
                  image: Image.asset(
                    "assets/images/bukulistrik.png",
                    width: 150,
                  ),
                  shadowColor: const Color(0xff126F84),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height * 1.2,
                        end: size.height * 3,
                      ),
                    )
                    .slideY(end: -1.5),
              ),
            ),
            // top right
            ParallaxLayer(
              offset: const Offset(250, -100),
              xOffset: -8,
              yOffset: -8,
              xRotation: 0.08,
              yRotation: 0.1,
              child: Center(
                child: MyWorkImage(
                  image: Image.asset(
                    "assets/images/diiket.png",
                    width: 140,
                  ),
                  shadowColor: const Color(0xffFE8526),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height * 1.5,
                        end: size.height * 3,
                      ),
                    )
                    .slideY(end: -0.2),
              ),
            ),
            ParallaxLayer(
              xOffset: 15,
              yOffset: 35,
              xRotation: 0.05,
              yRotation: 0.05,
              child: Center(
                child: RichText(
                  text: TextSpan(style: textTheme.displayMedium, children: [
                    const TextSpan(text: "My "),
                    TextSpan(
                      text: "Works",
                      style: textTheme.displayMedium!.apply(
                        color: colorScheme.primary,
                      ),
                    ),
                  ]),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height * 1.5,
                        end: size.height * 3,
                      ),
                    )
                    .slideY(begin: 0, end: -4, curve: Curves.easeInOutBack),
              ),
            ),
            // bottom right
            ParallaxLayer(
              offset: const Offset(400, 200),
              xOffset: 15,
              yOffset: 15,
              xRotation: 0.08,
              yRotation: 0.1,
              child: Center(
                child: MyWorkImage(
                  image: Image.asset(
                    "assets/images/bukutugas.png",
                    width: 150,
                  ),
                  shadowColor: const Color(0xff44526B),
                )
                    .animate(
                      adapter: ScrollValueNotifierAdapter(
                        _scrollNotifier,
                        begin: size.height * 1.5,
                        end: size.height * 3,
                      ),
                    )
                    .slideY(end: -0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWorkImage extends StatelessWidget {
  final Widget image;
  final Color shadowColor;

  const MyWorkImage({
    super.key,
    required this.image,
    this.shadowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // very smooth shadow
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: 14,
            blurRadius: 50,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: image,
    );
  }
}
