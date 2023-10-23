import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/core/components/default_shimmer.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart'
    as user_entity;
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/widgets/post_user_widget.dart';
import '../../../../core/style/fonts.dart';
import '../controller/home_bloc.dart';

class PostItemWidget extends StatelessWidget {
  final Post post;
  final user_entity.User user;

  const PostItemWidget({
    super.key,
    required this.post,
    required this.user,
  });

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
          PostUserWidget(user: user, post: post),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              post.captionText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontFamily: AppFonts.semiBold),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: post.image,
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
                      return Row(
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
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeLikePostEvent(post.id));
                                },
                                icon: SvgPicture.asset(
                                  state.isLikedMap[post.id] ?? false
                                      ? 'assets/icons/heart_filled.svg'
                                      : 'assets/icons/heart.svg',
                                ),
                              ),
                              Text(
                                '${state.postsLikes[post.id]}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)),
                              )
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/save.svg',
                          ),
                        ],
                      );
                    },
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
