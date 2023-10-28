part of 'comments_bloc.dart';

abstract class BaseCommentsEvent {
  const BaseCommentsEvent();
}

class CommentsAddEvent extends BaseCommentsEvent {
  final String postId;
  final String commentText;

  const CommentsAddEvent(
    this.postId,
    this.commentText,
  );
}

class CommentsGetEvent extends BaseCommentsEvent {
  final String postId;
  const CommentsGetEvent(
    this.postId,
  );
}

class CommentsAddSuccessEvent extends BaseCommentsEvent {
  const CommentsAddSuccessEvent();
}

class CommentsReloadEvent extends BaseCommentsEvent {
  final String postId;

  const CommentsReloadEvent(
    this.postId,
  );
}

class CommentsGetCommentsUsersEvent extends BaseCommentsEvent {
  final String postId;
  final List<Comment> comments;

  const CommentsGetCommentsUsersEvent(
    this.postId,
    this.comments,
  );
}

class CommentsGetIsLikedMapEvent extends BaseCommentsEvent {
  final List<Comment> comments;
  final Map<String, user_entity.User> commentsUsers;

  const CommentsGetIsLikedMapEvent(
    this.comments,
    this.commentsUsers,
  );
}

class CommentsGetCommentsLikesEvent extends BaseCommentsEvent {
  final List<Comment> comments;
  final Map<String, user_entity.User> commentsUsers;
  final Map<String, bool> isLikedMap;

  const CommentsGetCommentsLikesEvent(
    this.comments,
    this.commentsUsers,
    this.isLikedMap,
  );
}

class CommentsLikeCommentEvent extends BaseCommentsEvent {
  final Comment comment;

  const CommentsLikeCommentEvent(
    this.comment,
  );
}
