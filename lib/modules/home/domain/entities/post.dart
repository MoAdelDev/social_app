import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String captionText;
  final String image;
  final String date;
  final String uid;

  const Post(this.id, this.captionText, this.image, this.date, this.uid);


  @override
  List<Object> get props => [uid, captionText, image, id, date];
}
