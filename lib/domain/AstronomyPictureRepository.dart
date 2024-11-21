
import 'package:dartz/dartz.dart';

import '../core/Failure.dart';
import '../data/AstronomyPictureRemoteDataSource.dart';
import 'AstronomyPicture.dart'; // You may need to import dartz for Either and Failure handling

class AstronomyPictureRepository {
  final AstronomyPictureRemoteDataSource remoteDataSource;

  AstronomyPictureRepository(this.remoteDataSource);

  Future<Either<Failure, AstronomyPicture>> getAstronomyPicture() async {
    try {
      final model = await remoteDataSource.fetchAstronomyPicture();
      return Right(AstronomyPicture.fromModel(model)); // You can convert the model to your domain object
    } catch (e) {
      return Left(Failure(message: e.toString())); // Pass an instance of Failure
    }
  }
}