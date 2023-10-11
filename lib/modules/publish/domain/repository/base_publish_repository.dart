import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';

abstract class BasePublishRepository {

  Future<Either<Failure, void>> publish({required PublishModel publishModel, required File imageFile});
}