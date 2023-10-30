import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';

import '../../../../core/style/colors.dart';
import '../controller/comments_bloc.dart';

class CommentLikeWidget extends StatelessWidget {
  final Comment comment;

  const CommentLikeWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        return Column(
          children: [
            LikeButton(
              onTap: (isLiked) async {
                context
                    .read<CommentsBloc>()
                    .add(CommentsLikeCommentEvent(comment));
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
              isLiked: state.isLikedMap[comment.id],
              likeBuilder: (isLiked) {
                if (isLiked) {
                  return SvgPicture.asset('assets/icons/heart_filled.svg');
                }
                return SvgPicture.asset(
                  MyApp.isDark
                      ? 'assets/icons/heart.svg'
                      : 'assets/icons/dark/heart.svg',
                );
              },
              animationDuration: const Duration(milliseconds: 1000),
            ),
            Text(
              state.commentsLikesCount[comment.id].toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14.0,
              ),
            )
          ],
        );
      },
    );
  }
}
