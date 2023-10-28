import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_likes_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_users_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_is_comment_liked_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/like_comment_usecase.dart';

import '../../domain/entities/comment.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart'
    as user_entity;

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<BaseCommentsEvent, CommentsState> {
  final AddCommentUseCase addCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final GetCommentUsersUseCase getCommentsUsersUseCase;
  final GetIsCommentLikedIsUseCase getIsCommentLikedIsUseCase;
  final GetCommentsLikesUseCase getCommentsLikesUseCase;
  final LikeCommentUseCase likeCommentUseCase;

  CommentsBloc(
    this.addCommentUseCase,
    this.getCommentsUseCase,
    this.getCommentsUsersUseCase,
    this.getIsCommentLikedIsUseCase,
    this.getCommentsLikesUseCase,
    this.likeCommentUseCase,
  ) : super(const CommentsState()) {
    on<CommentsAddEvent>(_addComment);
    on<CommentsGetEvent>(_getComments);
    on<CommentsGetCommentsUsersEvent>(_getCommentsUsers);
    on<CommentsGetIsLikedMapEvent>(_getIsLikedMap);
    on<CommentsGetCommentsLikesEvent>(_getCommentLikes);
    on<CommentsLikeCommentEvent>(_likeComment);
    on<CommentsReloadEvent>(_reloadComments);
    on<CommentsAddSuccessEvent>((event, emit) => emit(state.copyWith(addCommentState: RequestState.nothing)),);
  }

  FutureOr<void> _addComment(
      CommentsAddEvent event, Emitter<CommentsState> emit) async {
    final String addSuccessMsg = MyApp.isArabic
        ? 'تم إضافة التعليق بنجاح'
        : 'The comment added successfully';
    final String addFailedMsg = MyApp.isArabic
        ? 'فشل في إضافة التعليق. حاول مرةً أخرى'
        : 'Failed to add the comment. try again';
    emit(state.copyWith(addCommentState: RequestState.loading));
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DateTime now = DateTime.now();
    String date = DateFormat.yMd().add_jm().format(now);
    CommentModel commentModel = CommentModel(
      id,
      event.postId,
      FirebaseAuth.instance.currentUser?.uid ?? '',
      event.commentText,
      date,
    );
    final result = await addCommentUseCase(commentModel: commentModel);
    result.fold((failure) {
      AppToast.showToast(msg: addFailedMsg, state: RequestState.error);
      emit(state.copyWith(
          addCommentState: RequestState.error,
          addCommentError: failure.message));
    }, (comment) {
      AppToast.showToast(msg: addSuccessMsg, state: RequestState.success);
      add(CommentsGetEvent(event.postId));
      emit(state.copyWith(
        addCommentState: RequestState.success,
      ));
      Future.delayed(const Duration(milliseconds: 3000)).then((value) {
        add(const CommentsAddSuccessEvent());
      });
    });
  }

  FutureOr<void> _getComments(
      CommentsGetEvent event, Emitter<CommentsState> emit) async {
    final result = await getCommentsUseCase(postId: event.postId);
    result.fold((failure) {
      emit(state.copyWith(
          commentsError: failure.message, commentsState: RequestState.error));
    }, (comments) {
      add(CommentsGetCommentsUsersEvent(event.postId, comments));
    });
  }

  FutureOr<void> _getCommentsUsers(
      CommentsGetCommentsUsersEvent event, Emitter<CommentsState> emit) async {
    final result = await getCommentsUsersUseCase(comments: event.comments);
    result.fold((failure) {
      emit(state.copyWith(
          commentsError: failure.message, commentsState: RequestState.error));
    }, (commentsUsers) {
      add(CommentsGetIsLikedMapEvent(event.comments, commentsUsers));
    });
  }

  FutureOr<void> _getIsLikedMap(
      CommentsGetIsLikedMapEvent event, Emitter<CommentsState> emit) async {
    final result = await getIsCommentLikedIsUseCase(
      comments: event.comments,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    result.fold((failure) {
      emit(state.copyWith(
          commentsError: failure.message, commentsState: RequestState.error));
    }, (isLikedMap) {
      add(CommentsGetCommentsLikesEvent(
          event.comments, event.commentsUsers, isLikedMap));
    });
  }

  FutureOr<void> _getCommentLikes(
      CommentsGetCommentsLikesEvent event, Emitter<CommentsState> emit) async {
    final result = await getCommentsLikesUseCase(
      comments: event.comments,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    result.fold((failure) {
      emit(state.copyWith(
          commentsError: failure.message, commentsState: RequestState.error));
    }, (commentsLikes) {
      emit(state.copyWith(
        comments: event.comments,
        commentsState: RequestState.success,
        commentsUsers: event.commentsUsers,
        isLikedMap: event.isLikedMap,
        commentsLikesCount: commentsLikes,
        isCommentsLoading: false,
      ));
    });
  }

  FutureOr<void> _likeComment(
      CommentsLikeCommentEvent event, Emitter<CommentsState> emit) async {
    Map<String, bool> isLikedMap = state.isLikedMap;
    Map<String, int> commentLikes = state.commentsLikesCount;
    bool isLiked = !state.isLikedMap[event.comment.id]!;
    if (isLiked) {
      commentLikes[event.comment.id] = commentLikes[event.comment.id]! + 1;
    } else {
      commentLikes[event.comment.id] = commentLikes[event.comment.id]! - 1;
    }
    isLikedMap[event.comment.id] = isLiked;
    emit(state.copyWith(
      likeState: RequestState.loading,
      isLikedMap: isLikedMap,
      commentsLikesCount: commentLikes,
    ));

    final result = await likeCommentUseCase(
      comment: event.comment,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      isLiked: isLiked,
    );

    result.fold((error) {
      Map<String, bool> isLikedMap = state.isLikedMap;
      Map<String, int> commentLikes = state.commentsLikesCount;
      bool isLiked = !state.isLikedMap[event.comment.id]!;
      if (isLiked) {
        commentLikes[event.comment.id] = commentLikes[event.comment.id]! + 1;
      } else {
        commentLikes[event.comment.id] = commentLikes[event.comment.id]! - 1;
      }
      isLikedMap[event.comment.id] = isLiked;
      emit(state.copyWith(
        likeState: RequestState.error,
        likeError: error.message,
        isLikedMap: isLikedMap,
        commentsLikesCount: commentLikes,
      ));
    }, (_) {
      emit(state.copyWith(
        likeState: RequestState.success,
      ));
    });
  }

  FutureOr<void> _reloadComments(
      CommentsReloadEvent event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(isCommentsLoading: true));
    add(CommentsGetEvent(event.postId));
  }
}
