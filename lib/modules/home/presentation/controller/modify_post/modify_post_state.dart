part of 'modify_post_bloc.dart';

class ModifyPostState extends Equatable {
  final File? imagePicked;
  final String modifyPostError;
  final RequestState modifyPostState;

  const ModifyPostState({
    this.imagePicked,
    this.modifyPostState = RequestState.nothing,
    this.modifyPostError = '',
  });

  ModifyPostState copyWith({
    File? imagePicked,
    String? modifyPostError,
    RequestState? modifyPostState,
  }) =>
      ModifyPostState(
        imagePicked: imagePicked ?? this.imagePicked,
        modifyPostState: modifyPostState ?? this.modifyPostState,
        modifyPostError: modifyPostError ?? this.modifyPostError,
      );

  @override
  List<Object?> get props => [
        imagePicked,
        modifyPostError,
        modifyPostState,
      ];
}
