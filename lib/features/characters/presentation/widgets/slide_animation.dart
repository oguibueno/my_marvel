// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  final int index;
  final int itemCount;
  final Widget child;
  final AnimationController animationController;

  SlideAnimation({
    Key? key,
    required this.index,
    required this.itemCount,
    required this.animationController,
    required this.child,
  }) : super(key: key);

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> {
  @override
  Widget build(BuildContext context) {
    final _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          (1 / widget.itemCount) * widget.index,
          1.0,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
    );

    widget.animationController.forward();

    return AnimatedBuilder(
      key: Key('slide_animation'),
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: Transform(
            child: widget.child,
            transform: Matrix4.translationValues(
              500 * (1.0 - _animation.value),
              0.0,
              0.0,
            ),
          ),
        );
      },
    );
  }
}
