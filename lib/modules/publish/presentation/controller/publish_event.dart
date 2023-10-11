part of 'publish_bloc.dart';

abstract class BasePublishEvent {
  const BasePublishEvent();
}

class PublishEvent extends BasePublishEvent {
  final File imageFile;
  final String captionText;
  final BuildContext context;

  PublishEvent(this.imageFile, this.captionText, this.context);
}

class PublishSuccessEvent extends BasePublishEvent {
  final BuildContext context;
  const PublishSuccessEvent(this.context);
}
