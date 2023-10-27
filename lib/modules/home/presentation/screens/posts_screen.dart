import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_app_bar_icon.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/controller/home/home_bloc.dart';
import 'package:social_app/modules/home/presentation/widgets/post_item_widget.dart';
import 'package:social_app/modules/home/presentation/widgets/posts_loading_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late ScrollController _scrollController;
  bool isLoading = false;

  late HomeState homeState;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
             _scrollController.position.minScrollExtent) {
          if (!homeState.isLoading) {
            BlocProvider.of<HomeBloc>(context).add(const HomeLoadPostsEvent());
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        homeState = state;
        if (state.postsState == RequestState.loading) {
          return const PostsLoadingWidget();
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
            if (state.isLoading)
              const Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  DefaultProgressIndicator(),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  controller: _scrollController,
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
