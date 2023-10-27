import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:social_app/core/components/default_shimmer.dart';
import 'package:social_app/core/style/colors.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart'
    as user_entity;
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/comments/presentation/screens/comments_screen.dart';
import 'package:social_app/modules/home/presentation/widgets/post_user_widget.dart';
import '../../../../core/style/fonts.dart';
import '../controller/home/home_bloc.dart';

class PostItemWidget extends StatefulWidget {
  final Post post;
  final user_entity.User user;

  const PostItemWidget({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  final likeKey = GlobalKey<LikeButtonState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(40.38),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostUserWidget(user: widget.user, post: widget.post),
          const SizedBox(
            height: 20.0,
          ),
          if (widget.post.captionText.isNotEmpty ||
              widget.post.captionText != '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    widget.post.captionText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontFamily: AppFonts.semiBold),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: widget.post.image,
                height: 270.53,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => DefaultShimmer(
                  child: Container(
                    height: 270.0,
                    color: Colors.grey,
                  ),
                ),
                placeholder: (context, url) => DefaultShimmer(
                  child: Container(
                    height: 270.0,
                    color: Colors.grey,
                  ),
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 270.53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.28),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: 47.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: const Color(0xff000000).withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.28),
                    bottomRight: Radius.circular(30.28),
                  ),
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
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
                              post: widget.post,
                              user: widget.user,
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/comments.svg',
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          LikeButton(
                            onTap: (isLiked) async {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeLikePostEvent(widget.post.id));
                              return !isLiked;
                            },
                            key: likeKey,
                            size: 30,
                            likeCountAnimationType: LikeCountAnimationType.all,
                            bubblesColor: const BubblesColor(
                                dotPrimaryColor: AppColorDark.primary,
                                dotSecondaryColor: AppColorDark.secondary),
                            circleColor: const CircleColor(
                                start: AppColorDark.primary,
                                end: AppColorDark.secondary),
                            circleSize: 35,
                            isLiked: state.isLikedMap[widget.post.id],
                            likeBuilder: (isLiked) {
                              if (state.isLikedMap[widget.post.id] ?? false) {
                                return SvgPicture.asset(
                                    'assets/icons/heart_filled.svg');
                              }
                              return SvgPicture.asset('assets/icons/heart.svg');
                            },
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            likeCount: state.postsLikes[widget.post.id],
                            countBuilder: (likeCount, isLiked, text) {
                              return Text(
                                '${state.postsLikes[widget.post.id]}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)),
                              );
                            },
                          ),
                          const Spacer(),
                          LikeButton(
                            onTap: (isSaved) async {
                              context.read<HomeBloc>().add(
                                    HomeSavePostEvent(
                                      widget.post.id,
                                    ),
                                  );
                              return !isSaved;
                            },
                            size: 30,
                            likeCountAnimationType: LikeCountAnimationType.all,
                            bubblesColor: const BubblesColor(
                                dotPrimaryColor: AppColorDark.primary,
                                dotSecondaryColor: AppColorDark.secondary),
                            circleColor: const CircleColor(
                              start: AppColorDark.primary,
                              end: AppColorDark.secondary,
                            ),
                            circleSize: 35,
                            isLiked: state.savedPosts[widget.post.id],
                            likeBuilder: (isSaved) {
                              if (state.savedPosts[widget.post.id] ?? false) {
                                return SvgPicture.asset(
                                    'assets/icons/save_filled.svg');
                              }
                              return SvgPicture.asset('assets/icons/save.svg');
                            },
                            animationDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
