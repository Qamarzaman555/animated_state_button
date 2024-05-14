import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class UKAnimController {
  final int duration;
  double tweenStart;
  double tweenEnd;
  late AnimationController controller;
  late Animation<double> tween;

  UKAnimController(
      {required this.duration, this.tweenStart = 0, this.tweenEnd = 1}) {
    controller = AnimationController(
        duration: Duration(milliseconds: duration),
        vsync: CustomTickerProvider());

    tween = Tween<double>(begin: tweenStart, end: tweenEnd).animate(controller);
  }

  forward() {
    controller.forward();
  }

  reverse() {
    controller.reverse();
  }

  dispose() {
    controller.dispose();
  }
}

class CustomTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
