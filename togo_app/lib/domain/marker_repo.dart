import 'package:togo_app/domain/new_marker.dart';

import '../data/datasources/markers_remote_data_source.dart';
import 'remapper.dart';

class MarkerRepo {
  final Remap _remap;
  final MarkersRemoteDataSource _dataSource;

  MarkerRepo(
    this._remap,
    this._dataSource,
  );

  Future<List<NewMarker>> getMarkers() async {
    final cars = await _dataSource.getMarkers();

    final newCars = cars.map(
      (car) {
        return _remap.dataToDomain(car);
      },
    ).toList();

    return newCars;
  }
}
