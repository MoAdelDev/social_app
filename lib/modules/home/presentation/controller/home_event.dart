part of 'home_bloc.dart';

abstract class BaseHomeEvent {
  const BaseHomeEvent();
}

class HomeChangeBottomNavIndexEvent extends BaseHomeEvent {
  final int index;

  HomeChangeBottomNavIndexEvent(this.index);
}

class HomePickImageFromCameraOrGalleryEvent extends BaseHomeEvent {
  final bool isCamera;
  final BuildContext context;

  const HomePickImageFromCameraOrGalleryEvent(this.isCamera, this.context);
}

class HomePublishPostEvent extends BaseHomeEvent {
  final File imageFile;
  final String captionText;
  final BuildContext context;

  HomePublishPostEvent(this.imageFile, this.captionText, this.context);
}


class HomeGetPostsEvent extends BaseHomeEvent {
  const HomeGetPostsEvent();
}

class HomeGetPostsUsersEvent extends BaseHomeEvent {
  final List<Post> posts;

  const HomeGetPostsUsersEvent(this.posts);
}
