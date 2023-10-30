import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/core/style/fonts.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';

import '../../../../core/components/default_progress_indicator.dart';

class LikesItemWidget extends StatelessWidget {
  final User user;

  const LikesItemWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 29,
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
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: AppFonts.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
