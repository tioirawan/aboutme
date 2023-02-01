import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollValueNotifierAdapter extends Adapter {
  const ScrollValueNotifierAdapter(this.notifier,
      {this.begin, this.end, bool? animated})
      : super(animated: animated);

  final ValueNotifier<ScrollPosition?> notifier;
  final double? begin;
  final double? end;

  @override
  void init(AnimationController controller) {
    controller.value = notifier.value == null
        ? 0
        : mapScrollToValue(notifier.value!, begin: begin, end: end);

    notifier.addListener(() {
      if (notifier.value == null) return;
      controller.animateTo(
        mapScrollToValue(notifier.value!, begin: begin, end: end),
        duration: animated ? null : Duration.zero,
      );
    });
  }
}

double mapScrollToValue(
  ScrollPosition pos, {
  double? begin,
  double? end,
}) {
  double min = pos.minScrollExtent, max = pos.maxScrollExtent;
  double minPx = _getPx(begin, min, max, min);
  double maxPx = _getPx(end, min, max, max);
  return (pos.pixels - minPx) / (maxPx - minPx);
}

double _getPx(double? val, double min, double max, double def) {
  if (val == null) return def;
  return val + (val <= 0 ? max : min);
}
