import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/AstronomyPicture.dart';
import '../domain/AstronomyPictureRepository.dart';
import '../domain/FetchAstronomyPicture.dart';

abstract class AstronomyPictureState {}

class LoadingState extends AstronomyPictureState {}

class InitialState extends AstronomyPictureState {}

class LoadedState extends AstronomyPictureState {
  final AstronomyPicture picture;

  LoadedState(this.picture);
}

class ErrorState extends AstronomyPictureState {
  final String message;

  ErrorState(this.message);
}

class AstronomyPictureCubit extends Cubit<AstronomyPictureState> {
  final AstronomyPictureRepository repository; // Use the repository here

  AstronomyPictureCubit(this.repository) : super(InitialState());

  Future<void> getPicture() async {
    emit(LoadingState());

    final result = await repository.getAstronomyPicture(); // Use the repository to fetch the picture

    result.fold(
          (failure) => emit(ErrorState(failure.message)),
          (picture) => emit(LoadedState(picture)),
    );
  }
}
