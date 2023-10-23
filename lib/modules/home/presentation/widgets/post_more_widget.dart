import 'package:flutter/material.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/style/fonts.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/widgets/delete_post_dialog.dart';

class PostMoreWidget extends StatelessWidget {
  final Post post;

  const PostMoreWidget({super.key, required this.post});

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
                  const SizedBox(
                    width: 100,
                    child: Divider(
                      color: Colors.white,
                      thickness: 4,
                      height: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScreenArguments args =
                                ScreenArguments.toModifyPostScreen(post: post);
                            Navigator.pushNamed(
                              context,
                              AppRouter.kModifyPostScreen,
                              arguments: args,
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Edit Post',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: AppFonts.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
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
                          child: const Row(
                            children: [
                              Text(
                                'Delete Post',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: AppFonts.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              )
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
