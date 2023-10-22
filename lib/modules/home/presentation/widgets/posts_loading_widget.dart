import 'package:flutter/material.dart';
import 'package:social_app/core/components/default_shimmer.dart';

class PostsLoadingWidget extends StatelessWidget {
  const PostsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return DefaultShimmer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 28.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 8,
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            color: Colors.grey,
                            height: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    color: Colors.grey,
                    height: 8,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: Colors.grey,
                  height: 270,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10.0,
        );
      },
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
