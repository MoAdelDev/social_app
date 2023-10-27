import 'package:flutter/material.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_like_widget.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_data_widget.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';

class CommentItemWidget extends StatelessWidget {
  final Post post;
  final User user;

  const CommentItemWidget({super.key, required this.post, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommentDataWidget(),
          ),
          CommentLikeWidget(),
        ],
      ),
    );
  }
}
