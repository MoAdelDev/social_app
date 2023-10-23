import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart'
    as user_entity;
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/widgets/post_more_widget.dart';

import '../../../../core/components/default_progress_indicator.dart';
import '../../../../core/style/fonts.dart';

class PostUserWidget extends StatelessWidget {
  final user_entity.User user;
  final Post post;

  const PostUserWidget({super.key, required this.user, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(30.0),
              child: user.photo == ''
                  ? SvgPicture.asset(
                      user.gender == 'Male'
                          ? 'assets/icons/man.svg'
                          : 'assets/icons/woman.svg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: user.photo,
                      errorWidget: (context, url, error) =>
                          const DefaultProgressIndicator(),
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
                          )),
                        );
                      },
                    ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontFamily: AppFonts.bold),
              ),
              const SizedBox(
                height: 3.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/world.svg',
                    width: 23.0,
                    height: 23.0,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Expanded(
                    child: Text(
                      post.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: AppFonts.regular,
                          color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (user.uid == FirebaseAuth.instance.currentUser?.uid)
          PostMoreWidget(post: post),
      ],
    );
  }
}
