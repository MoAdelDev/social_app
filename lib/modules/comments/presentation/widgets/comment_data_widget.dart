import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';

import '../../../../core/style/fonts.dart';
import '../../../../main.dart';

class CommentDataWidget extends StatelessWidget {
  final Comment comment;
  const CommentDataWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MyApp.user?.name ?? '',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFamily: AppFonts.bold,
                    ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    MyApp.isDark
                        ? 'assets/icons/light/world.svg'
                        : 'assets/icons/dark/world.svg',
                    width: 15.0,
                    height: 15.0,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Expanded(
                    child: Text(
                      comment.date,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontFamily: AppFonts.regular,
                              color: MyApp.isDark
                                  ? Colors.grey[300]
                                  : Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                comment.commentText,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ],
    );
  }
}
