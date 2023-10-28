part of 'home_bloc.dart';

abstract class BaseHomeEvent {
  const BaseHomeEvent();
}

class HomeChangeBottomNavIndexEvent extends BaseHomeEvent {
  final int index;

  HomeChangeBottomNavIndexEvent(this.index);
}

class HomeGetUserEvent extends BaseHomeEvent {
  const HomeGetUserEvent();
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

class HomeGetIsLikedPostEvent extends BaseHomeEvent {
  final List<Post> posts;
  final Map<String, user_entity.User> postsUsers;

  const HomeGetIsLikedPostEvent(this.posts, this.postsUsers);
}

class HomeGetPostsLikesEvent extends BaseHomeEvent {
  final List<Post> posts;
  final Map<String, user_entity.User> postsUsers;
  final Map<String, bool> isLikedMap;

  const HomeGetPostsLikesEvent(
    this.posts,
    this.postsUsers,
    this.isLikedMap,
  );
}

class HomeGetSavedPostsEvent extends BaseHomeEvent {
  final List<Post> posts;
  final Map<String, user_entity.User> postsUsers;
  final Map<String, bool> isLikedMap;
  final Map<String, int> postLikes;

  const HomeGetSavedPostsEvent(
    this.posts,
    this.postsUsers,
    this.isLikedMap,
    this.postLikes,
  );
}

class HomeGetPostsCommentsEvent extends BaseHomeEvent {
  final List<Post> posts;
  final Map<String, user_entity.User> postsUsers;
  final Map<String, bool> isLikedMap;
  final Map<String, int> postLikes;
  final Map<String, bool> postsSaved;

  const HomeGetPostsCommentsEvent(
    this.posts,
    this.postsUsers,
    this.isLikedMap,
    this.postLikes,
    this.postsSaved,
  );
}

class HomeLoadPostsEvent extends BaseHomeEvent {
  const HomeLoadPostsEvent();
}

class HomeLikePostEvent extends BaseHomeEvent {
  final String postId;

  const HomeLikePostEvent(this.postId);
}

class HomeDeletePostEvent extends BaseHomeEvent {
  final String postId;

  const HomeDeletePostEvent(
    this.postId,
  );
}

class HomeModifyPostEvent extends BaseHomeEvent {
  final String postId;
  final String captionText;
  final File imageFile;

  HomeModifyPostEvent(this.postId, this.captionText, this.imageFile);
}

class HomeSavePostEvent extends BaseHomeEvent {
  final String postId;

  HomeSavePostEvent(
    this.postId,
  );
}
