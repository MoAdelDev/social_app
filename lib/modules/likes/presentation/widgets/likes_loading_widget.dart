import 'package:flutter/material.dart';
import 'package:social_app/core/components/default_shimmer.dart';

class LikesLoadingWidget extends StatelessWidget {
  const LikesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return DefaultShimmer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    height: 15,
                  ),
                )
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
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
