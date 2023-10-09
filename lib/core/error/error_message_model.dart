import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;

  const ErrorMessageModel(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
