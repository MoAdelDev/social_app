import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/publish/data/datatsource/publish_remote_datasource.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';
import 'package:social_app/modules/publish/domain/repository/base_publish_repository.dart';

class PublishRepository extends BasePublishRepository {
  final PublishRemoteDataSource publishRemoteDataSource;

  PublishRepository(this.publishRemoteDataSource);

  @override
  Future<Either<Failure, void>> publish(
      {required PublishModel publishModel,  required File imageFile}) async {
    try {
      final result =
          await publishRemoteDataSource.publish(publishModel: publishModel, imageFile: imageFile);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
