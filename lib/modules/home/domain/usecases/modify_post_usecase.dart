import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class ModifyPostUseCase {
  final BaseHomeRepository baseHomeRepository;

  ModifyPostUseCase(this.baseHomeRepository);

  Future<Either<Failure, void>> call({
    required String postId,
    required String captionText,
    File? imageFile,
  }) async =>
      await baseHomeRepository.modifyPost(
        postId: postId,
        captionText: captionText,
        imageFile: imageFile,
      );
}
