import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_app_bar_icon.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/controller/home_bloc.dart';
import 'package:social_app/modules/home/presentation/widgets/post_item_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.postsState == RequestState.loading) {
          return const Center(
            child: DefaultProgressIndicator(
              size: 60.0,
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultAppBarIcon(
                    onPressed: () {},
                    child: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    S.of(context).explore,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  DefaultAppBarIcon(
                    onPressed: () {},
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  physics: DefaultScrollPhysics.bouncing(),
                  itemBuilder: (context, index) {
                    int itemIndex = state.posts.length - 1 - index;
                    Post post = state.posts[itemIndex];
                    return PostItemWidget(
                      post: post,
                      user: state.postsUsers[post.id]!,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: state.posts.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
