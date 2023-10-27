import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/presentation/controller/comments_bloc.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';

class CommentAddWidget extends StatelessWidget {
  final User user;
  final Post post;
  final TextEditingController _commentController = TextEditingController();

  CommentAddWidget({
    super.key,
    required this.user,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MyApp.user?.photo == ''
                        ? SvgPicture.asset(
                            MyApp.user?.gender == 'Male'
                                ? 'assets/icons/man.svg'
                                : 'assets/icons/woman.svg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: MyApp.user?.photo ?? '',
                            errorWidget: (context, url, error) {
                              return const DefaultProgressIndicator();
                            },
                            placeholder: (
                              context,
                              url,
                            ) =>
                                const DefaultProgressIndicator(),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          '${S.of(context).addCommentHintText}${user.name}',
                      hintStyle: const TextStyle(
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      enabled: true),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 14.0,
                  ),
                  autofocus: true,
                  cursorHeight: 15,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              ConditionalBuilder(
                condition: state.addCommentState != RequestState.loading,
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        BlocProvider.of<CommentsBloc>(context).add(
                          CommentsAddEvent(post.id, _commentController.text),
                        );
                        _commentController.text = '';
                      } else {
                        AppToast.showToast(
                          msg: S.of(context).addCommentWarningText,
                          state: RequestState.nothing,
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      MyApp.isDark
                          ? 'assets/icons/light/publish.svg'
                          : 'assets/icons/dark/publish.svg',
                      width: 20,
                      height: 20,
                    ),
                  );
                },
                fallback: (context) => const DefaultProgressIndicator(),
              )
            ],
          ),
        );
      },
    );
  }
}
