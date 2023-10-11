part of 'publish_bloc.dart';

class PublishState extends Equatable {
  final RequestState publishState;
  final String publishError;

  const PublishState({
    this.publishState = RequestState.loading,
    this.publishError = '',
  });

  PublishState copyWith({RequestState? publishState, String? publishError}) =>
      PublishState(
        publishState: publishState ?? this.publishState,
        publishError: publishError ?? this.publishError,
      );

  @override
  List<Object> get props => [
        publishState,
        publishError,
      ];
}
