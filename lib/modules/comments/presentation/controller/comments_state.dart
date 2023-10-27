part of 'comments_bloc.dart';

class CommentsState extends Equatable {
  final RequestState addCommentState;
  final String addCommentError;

  final List<Comment> comments;
  final RequestState commentsState;
  final String commentsError;

  const CommentsState({
    this.addCommentState = RequestState.nothing,
    this.addCommentError = '',
    this.comments = const [],
    this.commentsState = RequestState.nothing,
    this.commentsError = '',
  });

  CommentsState copyWith({
    RequestState? addCommentState,
    String? addCommentError,
    List<Comment>? comments,
    RequestState? commentsState,
    String? commentsError,
  }) =>
      CommentsState(
        addCommentState: addCommentState ?? this.addCommentState,
        addCommentError: addCommentError ?? this.addCommentError,
        comments: comments ?? this.comments,
        commentsState: commentsState ?? this.commentsState,
        commentsError: commentsError ?? this.commentsError,
      );

  @override
  List<Object> get props => [
        addCommentState,
        addCommentError,
        comments,
        commentsState,
        commentsError,
      ];
}
