import 'package:injectable/injectable.dart';
import 'package:space_scutum/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:space_scutum/features/weather/data/mappers/weather_mapper.dart';
import 'package:space_scutum/features/weather/domain/entities/weather_entity.dart';

abstract interface class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather({
    required double lat,
    required double lon,
  });
}

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._remoteDataSource);

  final WeatherRemoteDataSource _remoteDataSource;

  @override
  Future<WeatherEntity> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    final weather = await _remoteDataSource.getCurrentWeather(
      lat: lat,
      lon: lon,
    );
    return weather.toEntity();
  }
}
