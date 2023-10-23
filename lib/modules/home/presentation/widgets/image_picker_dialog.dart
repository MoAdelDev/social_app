import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/home_bloc.dart';

class ImagePickerDialog extends StatelessWidget {
  final bool isModify;

  const ImagePickerDialog({super.key, required this.isModify});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                  context.read<HomeBloc>().add(
                        HomeModifyImageFromCameraOrGalleryEvent(
                          true,
                          context,
                        ),
                      );
                } else {
                  context.read<HomeBloc>().add(
                        HomePickImageFromCameraOrGalleryEvent(
                          true,
                          context,
                        ),
                      );
                }
              },
              child: Text(
                'Camera',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeBloc>().add(
                      HomePickImageFromCameraOrGalleryEvent(
                        false,
                        context,
                      ),
                    );
              },
              child: Text(
                'Gallery',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        );
      },
    );
  }
}
