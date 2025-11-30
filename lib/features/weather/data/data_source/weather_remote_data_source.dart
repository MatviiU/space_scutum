import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:space_scutum/core/network/weather_api.dart';
import 'package:space_scutum/features/weather/data/data_source/models/weather_model.dart';

abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  });
}

@LazySingleton(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl(this._weatherApi);

  final WeatherApi _weatherApi;

  @override
  Future<WeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    // We retrieve the API Key securely from environment variables.
    // This prevents exposing sensitive keys in the source code.
    final weatherApiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
    return _weatherApi.getCurrentWeather(
      lat: lat,
      lon: lon,
      apiKey: weatherApiKey,
    );
  }
}
