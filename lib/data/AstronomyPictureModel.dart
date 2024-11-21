import '../domain/AstronomyPicture.dart';

class AstronomyPictureModel extends AstronomyPicture {
  AstronomyPictureModel({
    required String title,
    required String imageUrl,
    required String explanation,
  }) : super(title: title, imageUrl: imageUrl, explanation: explanation);

  factory AstronomyPictureModel.fromJson(Map<String, dynamic> json) {
    return AstronomyPictureModel(
      title: json['title'],
      imageUrl: json['url'],
      explanation: json['explanation'],
    );
  }
}
