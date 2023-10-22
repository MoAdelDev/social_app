import 'package:social_app/modules/home/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel(
    super.id,
    super.captionText,
    super.image,
    super.date,
    super.uid,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        json['id'],
        json['captionText'],
        json['image'],
        json['date'],
        json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'captionText': captionText,
        'image': image,
        'date': date,
      };
}
