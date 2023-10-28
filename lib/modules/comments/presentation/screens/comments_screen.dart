import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/services/service_locator.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/presentation/controller/comments_bloc.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_add_widget.dart';
import 'package:social_app/modules/comments/presentation/widgets/comment_item_widget.dart';
import 'package:social_app/modules/comments/presentation/widgets/comments_loading_widget.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/controller/home/home_bloc.dart';
import 'package:social_app/modules/home/presentation/widgets/bottom_sheet_divider.dart';

import '../../../../core/components/default_progress_indicator.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User user;

  const CommentsScreen({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      )..add(CommentsGetEvent(post.id)),
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state.addCommentState == RequestState.success) {
            BlocProvider.of<HomeBloc>(context).add(const HomeGetPostsEvent());
          }
          if (state.commentsState == RequestState.loading) {
            return const CommentsLoadingWidget();
          }
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const BottomSheetDivider(),
                if (state.isCommentsLoading)
                  const Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      DefaultProgressIndicator(),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                state.comments.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            S.of(context).noCommentsMsg,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          physics: DefaultScrollPhysics.bouncing(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            int itemIndex = state.comments.length - 1 - index;
                            Comment comment = state.comments[itemIndex];
                            User? user = state.commentsUsers[comment.id];
                            return CommentItemWidget(
                              post: post,
                              user: user!,
                              comment: comment,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: state.comments.length,
                        ),
                      ),
                Divider(
                  height: 1,
                  color: Colors.grey[500],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CommentAddWidget(
                  user: user,
                  post: post,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
