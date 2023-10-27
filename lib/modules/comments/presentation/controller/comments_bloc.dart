import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_usecase.dart';

import '../../domain/entities/comment.dart';
import '../../domain/usecases/add_comment_usecase.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<BaseCommentsEvent, CommentsState> {
  final AddCommentUseCase addCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;

  CommentsBloc(
    this.addCommentUseCase,
    this.getCommentsUseCase,
  ) : super(const CommentsState()) {
    on<CommentsAddEvent>(_addComment);
    on<CommentsGetEvent>(_getComments);
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
    result.fold((error) {
      AppToast.showToast(msg: addFailedMsg, state: RequestState.error);
      emit(state.copyWith(
          addCommentState: RequestState.error, addCommentError: error.message));
    }, (comment) {
      AppToast.showToast(msg: addSuccessMsg, state: RequestState.success);
      emit(state.copyWith(
        addCommentState: RequestState.error,
      ));
    });
  }

  FutureOr<void> _getComments(
      CommentsGetEvent event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(commentsState: RequestState.loading));
    final result = await getCommentsUseCase(postId: event.postId);
    result.fold((error) {
      emit(state.copyWith(
          commentsError: error.message, commentsState: RequestState.error));
    }, (comments) {
      emit(state.copyWith(
        comments: comments,
        commentsState: RequestState.success,
      ));
    });
  }
}
