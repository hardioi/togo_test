import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:togo_app/data/datasources/markers_remote_data_source.dart';
import 'package:togo_app/domain/marker_repo.dart';
import 'package:togo_app/domain/new_marker.dart';
import 'package:togo_app/domain/remapper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PopupController _popupController = PopupController();
  final MarkerRepo markerRepo = MarkerRepo(
    Remap(),
    MarkersRemoteDataSource(),
  );

  List<ToGoMarker> markers = [];
  NewMarker? selectedMarker;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    try {
      final cars = await markerRepo.getMarkers();

      setState(
        () {
          markers = cars
              .map(
                (car) => ToGoMarker(
                  point: LatLng(car.lat, car.lon),
                  builder: (context) => markerBuilder(context, car),
                  newMarker: car,
                ),
              )
              .toList();
        },
      );
    } catch (_) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Упс...',
          ),
          content: const Text(
            'Что-то пошло не так. Хотите попробовать ещё раз загрузить данные?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(
                  false,
                );
              },
              child: const Text(
                'No',
              ),
            ),
            TextButton(
              child: const Text(
                'Yes',
              ),
              onPressed: () {
                Navigator.of(ctx).pop(
                  init(),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  Widget markerBuilder(
    BuildContext context,
    NewMarker toGoMarker,
  ) {
    final color = toGoMarker == selectedMarker ? Colors.red : Colors.green;
    final size = toGoMarker == selectedMarker ? 40 : 26;

    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.bottomCenter,
      child: Icon(
        Icons.place,
        color: color,
        size: size.toDouble(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where\'s my car?'),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: (position, point) {
            setState(
              () {
                selectedMarker = null;
                _popupController.hideAllPopups();
              },
            );
          },
          zoom: 4,
          minZoom: 0,
          maxZoom: 18.5,
          center: LatLng(54.3200, 36.1600),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              spiderfyCluster: false,
              spiderfyCircleRadius: 80,
              spiderfySpiralDistanceMultiplier: 2,
              circleSpiralSwitchover: 12,
              maxClusterRadius: 120,
              rotate: true,
              size: const Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions: const FitBoundsOptions(
                padding: EdgeInsets.all(50),
                maxZoom: 20,
              ),
              markers: markers,
              onMarkerTap: (marker) {
                if (marker is ToGoMarker) {
                  setState(
                    () {
                      selectedMarker = marker.newMarker;
                    },
                  );
                }
              },
              polygonOptions: const PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3),
              popupOptions: PopupOptions(
                popupState: PopupState(),
                popupSnap: PopupSnap.markerTop,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  width: 200,
                  height: 70,
                  child: marker is ToGoMarker
                      ? Text(
                          'Здесь находится ${marker.newMarker.model.model} от ${marker.newMarker.model.brand}. Уровень заряда ${marker.newMarker.fuel}. Гос.номер ${marker.newMarker.gosnomer}.',
                        )
                      : Text('Error'),
                ),
              ),
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ToGoMarker extends Marker {
  ToGoMarker({
    required super.point,
    required super.builder,
    required this.newMarker,
  }) : super(height: 40, width: 40);

  final NewMarker newMarker;
}
