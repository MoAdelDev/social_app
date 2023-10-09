import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

enum AnimationDirection { right, left, down, up }

class DefaultAnimation extends StatelessWidget {
  final Widget child;
  final AnimationDirection animationDirection;
  final int milliseconds;

  const DefaultAnimation({
    Key? key,
    this.milliseconds = 2000,
    required this.child,
    required this.animationDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animationDirection == AnimationDirection.right) {
      return FadeInRightBig(
        duration: Duration(milliseconds: milliseconds),
        child: child,
      );
    } else if (animationDirection == AnimationDirection.left) {
      return FadeInLeftBig(
        duration: Duration(milliseconds: milliseconds),
        child: child,
      );
    } else if (animationDirection == AnimationDirection.up) {
      return FadeInUpBig(
        duration: Duration(milliseconds: milliseconds),
        child: child,
      );
    }
    return FadeInDownBig(
      duration: Duration(milliseconds: milliseconds),
      child: child,
    );
  }
}
