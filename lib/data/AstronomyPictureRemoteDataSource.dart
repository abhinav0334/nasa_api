import '../domain/AstronomyPicture.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'AstronomyPictureModel.dart';

class AstronomyPictureRemoteDataSource {
  final http.Client client;

  AstronomyPictureRemoteDataSource(this.client);

  Future<AstronomyPictureModel> fetchAstronomyPicture() async {
    final response = await client.get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY'));

    if (response.statusCode == 200) {
      return AstronomyPictureModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
