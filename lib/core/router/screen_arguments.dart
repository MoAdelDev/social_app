import 'dart:io';

import 'package:social_app/modules/home/domain/entities/post.dart';

class ScreenArguments{
  late File imageFile;

  late Post post;

  ScreenArguments.toPublishScreen({required this.imageFile});

  ScreenArguments.toModifyPostScreen({required this.post});
}