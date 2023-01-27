import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/raw_car.dart';

class CarsRequestFailure implements Exception {}

class CarsNotFoundFailure implements Exception {}

class MarkersRemoteDataSource {
  Future<List<RawCar>> getMarkers() async {
    final url =
        Uri.parse('https://georgia.togo-tech.cloud/api/v6/avaliableCars');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw CarsRequestFailure();
    }

    final markersJson = jsonDecode(response.body) as Map;

    final cars = markersJson['cars'];

    if (cars is! List) throw CarsNotFoundFailure();

    return cars.map((marker) => RawCar.fromJson(marker)).toList();
  }
}
