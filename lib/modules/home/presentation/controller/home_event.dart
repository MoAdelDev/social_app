part of 'home_bloc.dart';

abstract class BaseHomeEvent {
  const BaseHomeEvent();
}

class HomeChangeBottomNavIndexEvent extends BaseHomeEvent {
  final int index;

  HomeChangeBottomNavIndexEvent(this.index);
}

class HomePickImageFromCameraOrGallery extends BaseHomeEvent {
  final bool isCamera;
  final BuildContext context;

  const HomePickImageFromCameraOrGallery(this.isCamera, this.context);
}
