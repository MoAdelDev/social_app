import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';
import 'package:social_app/modules/publish/domain/repository/base_publish_repository.dart';

class PublishUseCase {
  final BasePublishRepository basePublishRepository;

  PublishUseCase(this.basePublishRepository);

  Future<Either<Failure, void>> call(
          {required PublishModel publishModel,
          required File imageFile}) async =>
      await basePublishRepository.publish(
          publishModel: publishModel, imageFile: imageFile);
}
