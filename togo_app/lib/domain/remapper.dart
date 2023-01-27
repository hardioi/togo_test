import 'package:togo_app/data/models/raw_car.dart';
import 'package:togo_app/domain/new_car.dart' as n;

class Remap {
  n.NewMarker dataToDomain(RawCar rawMarker) {
    n.Model newModel = n.Model(
      id: rawMarker.model.id,
      brand: rawMarker.model.brand,
      model: rawMarker.model.model,
    );

    return n.NewMarker(
      id: rawMarker.id,
      fuel: rawMarker.fuel,
      companyId: rawMarker.id,
      gosnomer: rawMarker.gosnomer,
      tariffs: rawMarker.tariffs,
      model: newModel,
      cruisingRange: rawMarker.cruisingRange,
      alerting: rawMarker.alerting,
      lat: rawMarker.lat,
      lon: rawMarker.lon,
    );
  }
}
