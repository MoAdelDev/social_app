import 'package:equatable/equatable.dart';


class Publish extends Equatable {
  final String uid;
  final String captionText;
  final String image;
  final String id;
  final String date;

  const Publish(this.id, this.uid, this.captionText, this.image, this.date);

  @override
  List<Object> get props => [
        id,
        uid,
        captionText,
        image,
        date,
      ];
}
