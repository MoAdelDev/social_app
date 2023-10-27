part of 'modify_post_bloc.dart';

abstract class BaseModifyPostEvent {
  const BaseModifyPostEvent();
}

class ModifyPostRemoveImagePickedEvent extends BaseModifyPostEvent {
  const ModifyPostRemoveImagePickedEvent();
}

class ModifyPostImagePickedFromCameraOrGalleryEvent
    extends BaseModifyPostEvent {
  final bool isCamera;
  final BuildContext context;

  const ModifyPostImagePickedFromCameraOrGalleryEvent(
      this.isCamera, this.context);
}

class ModifyPostEvent extends BaseModifyPostEvent {
  final String postId;
  final String captionText;

  ModifyPostEvent(
    this.postId,
    this.captionText,
  );
}
