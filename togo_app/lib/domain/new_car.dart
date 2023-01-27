class NewMarker {
  NewMarker({
    required this.tariffs,
    required this.gosnomer,
    required this.id,
    required this.model,
    required this.fuel,
    required this.cruisingRange,
    required this.alerting,
    required this.companyId,
    required this.lat,
    required this.lon,
  });

  final int id;
  final List<int> tariffs;
  final String gosnomer;
  final Model model;
  final double fuel;
  final double cruisingRange;
  final bool alerting;
  final int companyId;
  final double lat;
  final double lon;
}

class Model {
  const Model({
    required this.id,
    required this.brand,
    required this.model,
  });

  final int id;
  final String brand;
  final String model;
}
