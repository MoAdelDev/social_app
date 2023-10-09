import 'package:flutter/material.dart';

import '../style/fonts.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(40.0)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontFamily: AppFonts.regular,
              ),
        ),
      ),
    );
  }
}
