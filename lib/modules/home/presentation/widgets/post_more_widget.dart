import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/style/fonts.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart' as user_entity;
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/likes/presentation/screens/likes_screen.dart';
import 'package:social_app/modules/home/presentation/widgets/bottom_sheet_divider.dart';
import 'package:social_app/modules/home/presentation/widgets/delete_post_dialog.dart';

import '../../../comments/presentation/screens/comments_screen.dart';

class PostMoreWidget extends StatelessWidget {
  final Post post;
  final user_entity.User user;

  const PostMoreWidget({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          elevation: 3.0,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xff5790DF).withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const BottomSheetDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        if (post.uid == FirebaseAuth.instance.currentUser?.uid)
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScreenArguments args =
                                      ScreenArguments.toModifyPostScreen(
                                          post: post);
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.kModifyPostScreen,
                                    arguments: args,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      S.of(context).editPostTitle,
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: AppFonts.bold,
                                          color: Colors.white),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeletePostDialog(
                                        post: post,
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      S.of(context).deletePostTitle,
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: AppFonts.bold,
                                          color: Colors.white),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              enableDrag: true,
                              useSafeArea: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                return CommentsScreen(
                                  post: post,
                                  user: user,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).showCommentsTitle,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: AppFonts.bold,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                'assets/icons/light/comments.svg',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              enableDrag: true,
                              useSafeArea: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                return LikesScreen(
                                  post: post,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).showLikesTitle,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: AppFonts.bold,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                'assets/icons/light/heart.svg',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.more_horiz,
      ),
    );
  }
}
