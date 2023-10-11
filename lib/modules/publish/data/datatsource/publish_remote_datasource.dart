import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';

abstract class BasePublishRemoteDataSource {
  Future<void> publish(
      {required PublishModel publishModel, required File imageFile});
}

class PublishRemoteDataSource extends BasePublishRemoteDataSource {
  @override
  Future<void> publish(
      {required PublishModel publishModel, required File imageFile}) async {
    final result = await FirebaseStorage.instance
        .ref('posts')
        .child(publishModel.id)
        .putFile(imageFile)
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    final image = await result.ref.getDownloadURL();
    PublishModel publish = PublishModel(
      publishModel.id,
      publishModel.uid,
      publishModel.captionText,
      image,
      publishModel.date,
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(publishModel.id)
        .set(publish.toJson())
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }
}
