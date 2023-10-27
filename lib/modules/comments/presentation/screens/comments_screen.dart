import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/presentation/controller/comments_bloc.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_add_widget.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_item_widget.dart';
import 'package:social_app/modules/comments/presentation/widgets/comments_loading_widget.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/widgets/bottom_sheet_divider.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;
  final User user;

  const CommentsScreen({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentsBloc>(context)
        .add(CommentsGetEvent(widget.post.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state.commentsState == RequestState.loading) {
          return const CommentsLoadingWidget();
        }
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              const BottomSheetDivider(),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  physics: DefaultScrollPhysics.bouncing(),
                  itemBuilder: (context, index) {
                    int itemIndex = state.comments.length - 1 - index;
                    Comment comment = state.comments[itemIndex];
                    return CommentItemWidget(
                      post: widget.post,
                      user: widget.user,
                      comment: comment,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: state.comments.length,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CommentAddWidget(
                user: widget.user,
                post: widget.post,
              ),
            ],
          ),
        );
      },
    );
  }
}
