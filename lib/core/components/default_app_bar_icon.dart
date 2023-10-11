import 'package:flutter/material.dart';

class DefaultAppBarIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DefaultAppBarIcon({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CircleAvatar(
        radius: 25.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: IconButton(
          splashRadius: 27.0,
          splashColor: Theme.of(context).colorScheme.surface,
          onPressed: onPressed,
          icon: child,
        ),
      ),
    );
  }
}
