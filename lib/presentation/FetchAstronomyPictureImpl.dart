import 'package:dartz/dartz.dart';

import '../core/Failure.dart';
import '../domain/AstronomyPicture.dart';
import '../domain/FetchAstronomyPicture.dart';

class FetchAstronomyPictureImpl implements FetchAstronomyPicture {
  @override
  Future<Either<Failure, AstronomyPicture>> call() async {
    try {
      // Example: Mocked API Call
      final picture = AstronomyPicture(
        title: "Astronomy Picture",
        imageUrl: "https://example.com/image.jpg",
        explanation: "This is a test explanation",
      );

      return Right(picture); // Success
    } catch (e) {
      return Left(ServerFailure(message: e.toString())); // Failure    }
    }
  }

}
