import 'package:social_app/modules/comments/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel(
      super.id, super.postId, super.uid, super.commentText, super.date);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      json['id'],
      json['postId'],
      json['uid'],
      json['commentText'],
      json['date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'uid': uid,
        'commentText': commentText,
        'date': date,
      };
}
