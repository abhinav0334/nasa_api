
import 'package:assignment/presentation/AstronomyPictureScreen.dart';
import 'package:assignment/presentation/AstronomyPictureState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/AstronomyPictureRemoteDataSource.dart';
import 'domain/AstronomyPictureRepository.dart';
import 'package:http/http.dart' as http;


void main() {
  final httpClient = http.Client();
  final remoteDataSource = AstronomyPictureRemoteDataSource(httpClient);
  final repository = AstronomyPictureRepository(remoteDataSource);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final AstronomyPictureRepository repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Picture App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AstronomyPictureCubit(repository), // Provide the repository to the cubit
        child: AstronomyPictureScreen(),
      ),
    );
  }
}

