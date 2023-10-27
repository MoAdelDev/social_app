import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/presentation/controller/modify_post/modify_post_bloc.dart';

import '../controller/home/home_bloc.dart';

class ImagePickerDialog extends StatelessWidget {
  final bool isModify;

  const ImagePickerDialog({super.key, required this.isModify});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Image source',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      content: Text(
        'Please choose image source',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (isModify) {
              BlocProvider.of<ModifyPostBloc>(context).add(
                  ModifyPostImagePickedFromCameraOrGalleryEvent(true, context));
            } else {
              BlocProvider.of<HomeBloc>(context)
                  .add(HomePickImageFromCameraOrGalleryEvent(true, context));
            }
          },
          child: Text(
            'Camera',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        TextButton(
          onPressed: () {
            if (isModify) {
              BlocProvider.of<ModifyPostBloc>(context).add(
                  ModifyPostImagePickedFromCameraOrGalleryEvent(
                      false, context));
            } else {
              BlocProvider.of<HomeBloc>(context)
                  .add(HomePickImageFromCameraOrGalleryEvent(false, context));
            }
          },
          child: Text(
            'Gallery',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}
