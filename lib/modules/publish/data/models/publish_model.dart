import 'package:social_app/modules/publish/domain/entities/publish.dart';

class PublishModel extends Publish {
  const PublishModel(
    super.id,
    super.uid,
    super.captionText,
    super.image,
    super.date,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'captionText': captionText,
        'image': image,
        'date': date,
      };
}
