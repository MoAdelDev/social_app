import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/likes/domain/usecases/get_likes_usecase.dart';

import '../../../../authentication/domain/entities/user.dart';

part 'likes_event.dart';

part 'likes_state.dart';

class LikesBloc extends Bloc<BaseLikesEvent, LikesState> {
  final GetLikesUseCase getLikesUseCase;

  LikesBloc(
    this.getLikesUseCase,
  ) : super(const LikesState()) {
    on<LikesGetUsersEvent>(_getLikes);
  }

  FutureOr<void> _getLikes(
      LikesGetUsersEvent event, Emitter<LikesState> emit) async {
    final result = await getLikesUseCase(postId: event.postId);
    result.fold((failure) {
      emit(state.copyWith(
          likesError: failure.message, likesState: RequestState.error));
    }, (users) {
      emit(state.copyWith(users: users, likesState: RequestState.success));
    });
  }
}
