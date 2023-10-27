import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String postId;
  final String uid;
  final String commentText;
  final String date;

  const Comment(
    this.id,
    this.postId,
    this.uid,
    this.commentText,
    this.date,
  );

  @override
  List<Object> get props => [
        id,
        postId,
        uid,
        commentText,
        date,
      ];
}
