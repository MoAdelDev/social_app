part of 'comments_bloc.dart';

class CommentsState extends Equatable {
  final RequestState addCommentState;
  final String addCommentError;

  final List<Comment> comments;
  final RequestState commentsState;
  final String commentsError;
  final Map<String, user_entity.User> commentsUsers;

  final RequestState likeState;
  final String likeError;
  final Map<String, bool> isLikedMap;
  final Map<String, int> commentsLikesCount;

  const CommentsState({
    this.addCommentState = RequestState.nothing,
    this.addCommentError = '',
    this.comments = const [],
    this.commentsState = RequestState.nothing,
    this.commentsError = '',
    this.commentsUsers = const {},
    this.likeState = RequestState.nothing,
    this.likeError = '',
    this.isLikedMap = const {},
    this.commentsLikesCount = const {},
  });

  CommentsState copyWith({
    RequestState? addCommentState,
    String? addCommentError,
    List<Comment>? comments,
    RequestState? commentsState,
    String? commentsError,
    Map<String, user_entity.User>? commentsUsers,
    RequestState? likeState,
    String? likeError,
    Map<String, bool>? isLikedMap,
    Map<String, int>? commentsLikesCount,
  }) =>
      CommentsState(
        addCommentState: addCommentState ?? this.addCommentState,
        addCommentError: addCommentError ?? this.addCommentError,
        comments: comments ?? this.comments,
        commentsState: commentsState ?? this.commentsState,
        commentsError: commentsError ?? this.commentsError,
        commentsUsers: commentsUsers ?? this.commentsUsers,
        likeState: likeState ?? this.likeState,
        likeError: likeError ?? this.likeError,
        isLikedMap: isLikedMap ?? this.isLikedMap,
        commentsLikesCount: commentsLikesCount ?? this.commentsLikesCount,
      );

  @override
  List<Object> get props => [
        addCommentState,
        addCommentError,
        comments,
        commentsState,
        commentsError,
        commentsUsers,
        likeState,
        likeError,
        isLikedMap,
        commentsLikesCount,
      ];
}
