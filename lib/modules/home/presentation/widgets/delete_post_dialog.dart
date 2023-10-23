import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/controller/home_bloc.dart';

import '../../../../core/style/fonts.dart';

class DeletePostDialog extends StatelessWidget {
  final Post post;

  const DeletePostDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            S.of(context).deletePostTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontFamily: AppFonts.bold),
          ),
          content: Text(
            S.of(context).deletePostMsg,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancelTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: AppFonts.semiBold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<HomeBloc>().add(HomeDeletePostEvent(post.id));
                  },
                  child: Text(
                    S.of(context).deleteTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: AppFonts.semiBold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
