import 'package:dartz/dartz.dart';

import '../core/Failure.dart';
import 'AstronomyPicture.dart';

abstract class FetchAstronomyPicture {
  Future<Either<Failure, AstronomyPicture>> call();
}
