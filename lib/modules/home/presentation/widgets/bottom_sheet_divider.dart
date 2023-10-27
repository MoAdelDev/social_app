import 'package:flutter/material.dart';

class BottomSheetDivider extends StatelessWidget {
  const BottomSheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 100,
      child: Divider(
        color: Colors.grey[500],
        thickness: 4,
        height: 5,
      ),
    );
  }
}
