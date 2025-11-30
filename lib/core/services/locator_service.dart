import 'package:injectable/injectable.dart';

typedef LatLon = ({double lat, double lon});

abstract interface class LocationService {
  Future<LatLon> getCurrentLocation();
}

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  @override
  Future<LatLon> getCurrentLocation() async {
    // Simulating GPS delay to test loading states in UI
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // TODO: For this test task, I'm mocking the location to save time on OS permissions configuration.
    // In production, this would use the 'geolocator' package.
    return (lat: 50.45, lon: 30.52);
  }
}
