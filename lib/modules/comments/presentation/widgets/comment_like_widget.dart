import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';

import '../../../../core/style/colors.dart';

class CommentLikeWidget extends StatelessWidget {
  const CommentLikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LikeButton(
          onTap: (isLiked) async {
            return !isLiked;
          },
          size: 30,
          likeCountAnimationType: LikeCountAnimationType.all,
          bubblesColor: const BubblesColor(
              dotPrimaryColor: AppColorDark.primary,
              dotSecondaryColor: AppColorDark.secondary),
          circleColor: const CircleColor(
              start: AppColorDark.primary, end: AppColorDark.secondary),
          circleSize: 35,
          isLiked: true,
          likeBuilder: (isLiked) {
            if (isLiked) {
              return SvgPicture.asset('assets/icons/heart_filled.svg');
            }
            return SvgPicture.asset('assets/icons/heart.svg');
          },
          animationDuration: const Duration(milliseconds: 1000),
        ),
        Text(
          '20',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 14.0),
        )
      ],
    );
  }
}
