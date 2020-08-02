import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

class Location {
  double lat, long;

  Location() {
    checkLocationServices();
  }

  Future checkLocationServices() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  Future<void> locate() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
