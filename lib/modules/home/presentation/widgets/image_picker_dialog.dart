import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/presentation/controller/modify_post/modify_post_bloc.dart';

import '../../../../core/style/fonts.dart';
import '../controller/home/home_bloc.dart';

class ImagePickerDialog extends StatelessWidget {
  final bool isModify;

  const ImagePickerDialog({super.key, required this.isModify});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Image source',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontFamily: AppFonts.bold),
      ),
      content: Text(
        'Please choose image source',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      titlePadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      actionsPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      elevation: 0.0,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                if (isModify) {
                  BlocProvider.of<ModifyPostBloc>(context).add(
                      ModifyPostImagePickedFromCameraOrGalleryEvent(
                          true, context));
                } else {
                  BlocProvider.of<HomeBloc>(context).add(
                      HomePickImageFromCameraOrGalleryEvent(true, context));
                }
              },
              child: Text(
                'Camera',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: AppFonts.semiBold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (isModify) {
                  BlocProvider.of<ModifyPostBloc>(context).add(
                      ModifyPostImagePickedFromCameraOrGalleryEvent(
                          false, context));
                } else {
                  BlocProvider.of<HomeBloc>(context).add(
                      HomePickImageFromCameraOrGalleryEvent(false, context));
                }
              },
              child: Text(
                'Gallery',
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
  }
}
