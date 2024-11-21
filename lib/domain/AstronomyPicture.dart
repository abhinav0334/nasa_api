import '../data/AstronomyPictureModel.dart';

class AstronomyPicture {
  final String imageUrl;
  final String title;
  final String explanation;

  AstronomyPicture({
    required this.imageUrl,
    required this.title,
    required this.explanation,
  });

  // Factory method to create AstronomyPicture from AstronomyPictureModel
  factory AstronomyPicture.fromModel(AstronomyPictureModel model) {
    return AstronomyPicture(
      imageUrl: model.imageUrl,
      title: model.title,
      explanation: model.explanation,
    );
  }
}