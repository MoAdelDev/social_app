import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class PublishPostUseCase {
  final BaseHomeRepository baseHomeRepository;

  PublishPostUseCase(this.baseHomeRepository);

  Future<Either<Failure, void>> call(
          {required PostModel postModel,
          required File imageFile}) async =>
      await baseHomeRepository.publishPost(
          postModel: postModel, imageFile: imageFile);
}
