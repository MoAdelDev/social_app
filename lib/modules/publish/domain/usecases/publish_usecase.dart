import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';
import 'package:social_app/modules/publish/data/repository/publish_repository.dart';

class PublishUseCase {
  final PublishRepository publishRepository;

  PublishUseCase(this.publishRepository);

  Future<Either<Failure, void>> call(
          {required PublishModel publishModel,
          required File imageFile}) async =>
      await publishRepository.publish(
          publishModel: publishModel, imageFile: imageFile);
}
