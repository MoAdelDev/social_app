import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/style/fonts.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.separated(
        physics:  DefaultScrollPhysics.bouncing(),
        itemBuilder: (context, index) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(40.38),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorWidget: (context, url, error) =>
                                const DefaultProgressIndicator(),
                            placeholder: (
                              context,
                              url,
                            ) =>
                                const DefaultProgressIndicator(),
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
                            'Mohammed Abdelaziz',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontFamily: AppFonts.bold),
                          ),
                          Text(
                            '5/10/2022',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontFamily: AppFonts.regular,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'I liked this image',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: AppFonts.semiBold),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 270.53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.28),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='),
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
                      child: Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/comments.svg',
                              ),
                              const SizedBox(width: 5.0,),
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 10.0,),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/heart.svg',
                              ),
                              const SizedBox(width: 5.0,),
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/save.svg',
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10.0,
        ),
        itemCount: 30,
      ),
    );
  }
}
